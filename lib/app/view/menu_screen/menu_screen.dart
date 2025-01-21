import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_booking_app/core/extensions/margin_extension.dart';
import '../../../core/style/colors.dart';
import '../../../core/style/style.dart';
import '../../widgets/app_text_field.dart';
import '../../controller/menu_screen_controller/menu_controller.dart';
import '../cart_screen/cart_screen.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final MenuControllers controller = Get.put(MenuControllers());

  final List<String> indicatorText = [
    'Salad',
    'Beverages',
    'Desserts',
    'Soups',
    'Biryani',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteClr,
      appBar: AppBar(
        backgroundColor: whiteClr,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ShoppingCartScreen()));
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
                Obx(() {
                  if (controller.cartCount.value == 0) return SizedBox.shrink();
                  return Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        controller.cartCount.value.toString(),
                        style: AppTextStyles.textStyle_400_14
                            .copyWith(color: whiteClr),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            buildHeader(),
            15.hBox,
            AppTextField(
              hint: 'Search your favorite food',
              borderRadius: 20,
              bgColor: fieldClr,
              borderClr: whiteClr,
              prefixIcon: Icon(Icons.search),
            ),
            10.hBox,
            buildCategoryRow(),
            10.hBox,
            buildCategoryScrollView(),
            10.hBox,
            buildFoodGrid(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Align(
      alignment: Alignment.topLeft,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        curve: Curves.easeIn,
        duration: const Duration(seconds: 1),
        builder: (context, val, child) {
          return Opacity(
            opacity: val,
            child: Padding(
              padding: EdgeInsets.only(left: (1 - val) * 100),
              child: child,
            ),
          );
        },
        child: RichText(
          text: TextSpan(
            text: "Get Your ",
            style: AppTextStyles.textStyle_400_14.copyWith(fontSize: 28),
            children: [
              TextSpan(
                text: "Best\nFood",
                style: AppTextStyles.textStyle_600_14.copyWith(fontSize: 28),
              ),
              TextSpan(
                text: " in Paragon",
                style: AppTextStyles.textStyle_400_14.copyWith(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryRow() {
    return Row(
      children: [
        Obx(() => CategoryIndicator(
              text: 'Veg',
              imagePath: 'assets/images/green_dot.png',
              height: 45,
              width: 85,
              color: fieldClr,
              style: AppTextStyles.textStyle_400_14.copyWith(fontSize: 12),
              isSelected: controller.selectedCategoryIndex.value == 0,
              borderClr: controller.selectedCategoryIndex.value == 0
                  ? greenClr
                  : fieldClr,
              onTap: () => controller.selectedCategory(0),
            )),
        15.wBox,
        Obx(() => CategoryIndicator(
              text: 'Non-Veg',
              imagePath: 'assets/images/red_dot.png',
              height: 45,
              width: 119,
              color: fieldClr,
              style: AppTextStyles.textStyle_400_14.copyWith(fontSize: 12),
              isSelected: controller.selectedCategoryIndex.value == 1,
              borderClr: controller.selectedCategoryIndex.value == 1
                  ? redClr
                  : fieldClr,
              onTap: () => controller.selectedCategory(1),
            )),
      ],
    );
  }

  Widget buildCategoryScrollView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(indicatorText.length, (index) {
          return Obx(() => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SelectionIndicator(
                  text: indicatorText[index],
                  imagePath: 'assets/images/red_dot.png',
                  height: 45,
                  width: 110,
                  color: controller.selectedIndex.value == index
                      ? blackClr
                      : fieldClr,
                  style: AppTextStyles.textStyle_400_14.copyWith(fontSize: 12),
                  icon: controller.selectedIndex.value == index
                      ? Icons.check
                      : null,
                  iconColor: whiteClr,
                  onTap: () => controller.selectCategory(index),
                  isSelected: controller.selectedIndex.value == index,
                ),
              ));
        }),
      ),
    );
  }

  Widget buildFoodGrid() {
    return Expanded(
      child: Obx(() {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.6,
          ),
          itemCount: controller.filteredFoodItems.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: fieldClr,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Obx(() => IconButton(
                          onPressed: () => controller.toggleFavorite(index),
                          icon: Icon(
                            controller.favoriteStatus[index]
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: controller.favoriteStatus[index]
                                ? blackClr
                                : Colors.grey,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 125,
                    width: 125,
                    child: Image.asset(
                      controller.categoryFoodImages[
                                  controller.selectedIndex.value < 0
                                      ? 'Salad'
                                      : controller.categoryFoodMap.keys
                                          .elementAt(
                                              controller.selectedIndex.value)]
                              ?[index] ??
                          'assets/images/default_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    controller.filteredFoodItems[index],
                    style: AppTextStyles.textStyle_500_14,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '20 Min',
                          style: AppTextStyles.textStyle_400_14
                              .copyWith(fontSize: 12, color: cardTextClr),
                        ),
                        Spacer(),
                        Image.asset('assets/images/rating_icon.png'),
                        5.wBox,
                        Text(
                          '4.5',
                          style: AppTextStyles.textStyle_400_14
                              .copyWith(fontSize: 12, color: cardTextClr),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ 10.0',
                          style: AppTextStyles.textStyle_600_14,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: blackClr,
                          ),
                          child: InkWell(
                            onTap: () {
                              final foodName =
                                  controller.filteredFoodItems[index];
                              final image = controller.categoryFoodImages[
                                      controller.selectedIndex.value < 0
                                          ? 'Salad'
                                          : controller.categoryFoodMap.keys
                                              .elementAt(controller
                                                  .selectedIndex
                                                  .value)]?[index] ??
                                  '';
                              controller.addToCart(foodName, image);
                            },
                            child: Icon(
                              Icons.add,
                              color: whiteClr,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

class SelectionIndicator extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Color? borderClr;
  final String? text;
  final String? imagePath;
  final Color? iconColor;
  final TextStyle? style;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isSelected;

  const SelectionIndicator({
    super.key,
    this.height,
    this.borderClr = Colors.grey,
    this.width,
    this.color,
    this.iconColor,
    this.text,
    this.style,
    this.imagePath,
    this.icon,
    this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: isSelected ? 130 : 105,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderClr ?? Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (isSelected) Image.asset('assets/images/red_dot.png'),
              const SizedBox(width: 10),
              Text(
                text.toString(),
                style: style?.copyWith(
                  color: isSelected ? whiteClr : blackClr,
                ),
              ),
              Spacer(),
              if (isSelected)
                Icon(
                  Icons.close,
                  size: 20,
                  color: iconColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryIndicator extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Color? borderClr;
  final String? text;
  final String? imagePath;
  final Color? iconColor;
  final TextStyle? style;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isSelected;

  const CategoryIndicator({
    super.key,
    this.height,
    this.borderClr = Colors.grey,
    this.width,
    this.color,
    this.iconColor,
    this.text,
    this.style,
    this.imagePath,
    this.icon,
    this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: isSelected ? 120 : 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderClr ?? Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (isSelected) Image.asset(imagePath!),
              const SizedBox(width: 10),
              Text(text.toString(), style: style),
              const SizedBox(width: 5),
              if (isSelected)
                Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
