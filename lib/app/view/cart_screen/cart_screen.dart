import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_booking_app/core/extensions/margin_extension.dart';
import 'package:table_booking_app/core/style/colors.dart';
import '../../../core/style/style.dart';
import '../../controller/cart_controller.dart/cart_controller.dart';
import '../../controller/menu_screen_controller/menu_controller.dart';
import '../../widgets/app_button.dart';

class ShoppingCartScreen extends StatelessWidget {
  final MenuControllers controller = Get.put(MenuControllers());
  final CartController cartController = Get.put(CartController());

  ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteClr,
      appBar: AppBar(
        backgroundColor: whiteClr,
        title: Text(
          'Cart',
          style: AppTextStyles.textStyle_500_14.copyWith(fontSize: 16),
        ),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Text(
              'Your cart is empty!',
              style: AppTextStyles.textStyle_500_14.copyWith(fontSize: 16),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  color: fieldClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final item = controller.cartItems[index];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 76.21,
                                    width: 71.83,
                                    child: Image.asset(
                                      '${item['image']}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  15.wBox,
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/bxs_up-arrow.png'),
                                            5.wBox,
                                            Text('${item['name']}',
                                                style: AppTextStyles
                                                    .textStyle_600_14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400))
                                          ],
                                        ),
                                        5.hBox,
                                        Text(
                                          '\$ 10.0',
                                          style: AppTextStyles.textStyle_500_14,
                                        ),
                                        5.hBox,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                cartController.decrement(index);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 17,
                                                  color: blackClr,
                                                ),
                                              ),
                                            ),
                                            15.wBox,
                                            Obx(() {
                                              return Text(
                                                '${cartController.cartQuantities[index]}',
                                                style: AppTextStyles
                                                    .textStyle_600_14,
                                              );
                                            }),
                                            15.wBox,
                                            GestureDetector(
                                              onTap: () {
                                                cartController.increment(index);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 17,
                                                  color: blackClr,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 80),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: IconButton(
                                                   onPressed: () {
  controller.removeFromCart(index); },

                                                    icon: Icon(Icons.close)),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: controller.cartItems.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: cardClr,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    spacing: 2,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => PriceCutomRow(
                            label: 'Total',
                            value:
                                '\$ ${cartController.price.toStringAsFixed(2)}'),
                      ),
                      PriceCutomRow(
                          label: 'Tax :',
                          value:
                              '\$ ${cartController.taxAmount.toStringAsFixed(2)}'),
                      Divider(),
                      Obx(
                        () => PriceCutomRow(
                            label: 'Total',
                            value:
                                '\$ ${cartController.totalPrice.toStringAsFixed(2)}'),
                      ),
                      10.hBox,
                      AppButton(
                        text: 'Order',
                        btnClr: Color(0x80D9D9D9),
                        textstyle: AppTextStyles.textStyle_500_14
                            .copyWith(fontSize: 12),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class PriceCutomRow extends StatelessWidget {
  final String label;
  final String value;

  const PriceCutomRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: AppTextStyles.textStyle_600_14,
        ),
      ],
    );
  }
}
