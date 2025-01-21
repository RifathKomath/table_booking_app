import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_booking_app/app/widgets/app_button.dart';
import 'package:table_booking_app/app/widgets/app_text_field.dart';
import 'package:table_booking_app/core/extensions/margin_extension.dart';
import 'package:table_booking_app/core/style/colors.dart';
import 'package:table_booking_app/core/style/style.dart';
import 'package:table_booking_app/core/utils/validator.dart';
import '../../controller/home_screen_controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          title: Text(
            'Booking Confirmation',
            style: AppTextStyles.textStyle_500_14.copyWith(fontSize: 16),
          ),
          backgroundColor: whiteClr.withOpacity(0.3),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Paragon',
                  style: AppTextStyles.textStyle_500_14
                      .copyWith(fontWeight: FontWeight.w300, fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  children: [
                    Card(
                      color: cardClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customRow(
                                'Name ',
                                AppTextField(
                                  bgColor: whiteClr.withOpacity(0.6),
                                  borderRadius: 15,
                                  validator: (value) => validateRequiredField(
                                      value,
                                      fieldName: 'Field'),
                                  onChanged: (value) =>
                                      homeController.name.value = value,
                                ),
                              ),
                              customRow(
                                'Phone Number ',
                                AppTextField(
                                  bgColor: whiteClr.withOpacity(0.6),
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  borderRadius: 15,
                                  validator: (value) => validateRequiredField(
                                      value,
                                      fieldName: 'Field'),
                                  onChanged: (value) =>
                                      homeController.phoneNumber.value = value,
                                ),
                              ),
                              customRow(
                                'Number of Persons ',
                                AppTextField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  bgColor: whiteClr.withOpacity(0.6),
                                  borderRadius: 15,
                                  validator: (value) => validateRequiredField(
                                      value,
                                      fieldName: 'Field'),
                                  onChanged: (value) => homeController
                                      .numberOfPersons.value = value,
                                ),
                              ),
                              10.hBox,
                              AppButton(
                                text: 'Submit',
                                btnClr: Color(0x80D9D9D9),
                                textstyle: AppTextStyles.textStyle_500_14
                                    .copyWith(fontSize: 12),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    homeController.saveData();
                                    homeController.incrementTableCount();
                                    homeController.toggleSubmission();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    10.hBox,
                    Obx(() {
                      return homeController.isSubmitted.value
                          ? Card(
                              color: cardClr,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Table Number is ${homeController.tableCount.value}',
                                        style: AppTextStyles.textStyle_600_14
                                            .copyWith(fontSize: 20),
                                      ),
                                    ),
                                    30.hBox,
                                    Image.asset(
                                      height: 100,
                                      width: 129,
                                      'assets/images/success_gif.gif',
                                    ),
                                    30.hBox,
                                    Text(
                                      'Your reservation for ${homeController.numberOfPersons.value} pax\nin Paragon is confirmed',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.textStyle_500_14
                                          .copyWith(fontSize: 20),
                                    ),
                                    50.hBox,
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Waiting Time: 15 mins',
                                        style: AppTextStyles.textStyle_500_14
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox
                              .shrink(); // Hide container if not submitted
                    }),
                  ],
                ),
              ),
              10.hBox
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
