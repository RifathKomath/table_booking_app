import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_booking_app/app/controller/check_screen_controller/check_controller.dart';
import 'package:table_booking_app/app/controller/home_screen_controller/home_controller.dart';
import 'package:table_booking_app/app/widgets/app_button.dart';
import 'package:table_booking_app/app/widgets/app_text_field.dart';
import 'package:table_booking_app/core/extensions/margin_extension.dart';
import 'package:table_booking_app/core/style/colors.dart';
import 'package:table_booking_app/core/utils/validator.dart';

import '../../../core/style/style.dart';
import '../menu_screen/menu_screen.dart';

class CheckScreen extends StatelessWidget {
  CheckScreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  final CheckController checkController = Get.put(CheckController());

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController mobileController = TextEditingController();

    return Scaffold(
      backgroundColor: whiteClr,
      appBar: AppBar(
        title: Text(
          'Booking Confirmation',
          style: AppTextStyles.textStyle_500_14.copyWith(fontSize: 16),
        ),
        backgroundColor: whiteClr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Card(
                elevation: 5,
                color: whiteClr,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customRow(
                          'Enter Phone Number',
                          AppTextField(
                            controller: mobileController,
                            validator: (value) => validateMobileNumber(value),
                            borderRadius: 15,
                            hint: '93xxxxxxxxx',
                            keyboardType: TextInputType.numberWithOptions(),
                            bgColor: fieldClr,
                            borderClr: whiteClr,
                          )),
                      20.hBox,
                      AppButton(
                        isExpand: false,
                        btnRadius: 25,
                        text: 'Check',
                        textstyle: AppTextStyles.textStyle_500_14,
                        minHeight: 35,
                        borderSideClr: fieldClr,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (mobileController.text.length == 10) {
                              if (mobileController.text ==
                                  homeController.phoneNumber.value) {
                                checkController.toggleContainerVisibility();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                        'Phone number does not match the stored one'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                      'Please enter a valid 10-digit phone number'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      10.hBox,
                    ],
                  ),
                ),
              ),
              20.hBox,
              Obx(() {
                if (checkController.isContainerVisible.value) {
                  return Column(
                    children: [
                      Card(
                        color: fieldClr,
                        elevation: 0,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text(
                                'Name : ${homeController.name.value}',
                                style: AppTextStyles.textStyle_400_14,
                              ),
                              trailing: Text(
                                'No of Pax : ${homeController.numberOfPersons.value}',
                                style: AppTextStyles.textStyle_400_14,
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text(
                                'Table No : ${homeController.tableCount.value}',
                                style: AppTextStyles.textStyle_400_14,
                              ),
                              trailing: Text(
                                'Waiting Time: 15 mins',
                                style: AppTextStyles.textStyle_400_14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.hBox,
                         Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: AppButton(
                  btnRadius: 10,
                  bgclr: Colors.black12,
                  text: 'Explore Menu',
                  textstyle:
                      AppTextStyles.textStyle_500_14.copyWith(fontSize: 16),
                  borderSideClr: fieldClr,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MenuScreen()));
                  },
                ),
              ),
                    ],
                  );
                } else {
                  return SizedBox
                      .shrink(); 
                }
              }),
           
            ],
          ),
        ),
      ),
    );
  }

  Widget customRow(String label, Widget field) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label: ',
            style: AppTextStyles.textStyle_600_14.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: field),
      ],
    );
  }
}
