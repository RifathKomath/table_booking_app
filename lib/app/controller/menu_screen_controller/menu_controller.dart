import 'package:get/get.dart';

import '../cart_controller.dart/cart_controller.dart';

class MenuControllers extends GetxController {
  RxInt selectedIndex = RxInt(-1);
  RxInt selectedCategoryIndex = RxInt(-1);
  RxList<bool> favoriteStatus = RxList<bool>();
  RxList<String> allFoodItems = RxList<String>();
  RxList<String> filteredFoodItems = RxList<String>();
  RxList<String> filteredFoodImages = RxList<String>();
  RxInt cartCount = 0.obs;
  RxList<Map<String, dynamic>> cartItems = RxList<Map<String, dynamic>>();

  final Map<String, List<String>> categoryFoodMap = {
    'Salad': [
      'Chicken salad',
      'Seafood salad',
      'Lamb salad',
      'Pomfred salad',
    ],
    'Beverages': ['Tea', 'Pepsi', 'Milkshake', 'Juice'],
    'Desserts': ['Ice Cream', 'Pudding', 'Cake', 'Halwa'],
    'Soups': [
      'Mutton Soup',
      'Sweet Corn',
      'Chicken Soup',
      'Beef Soup',
    ],
    'Biriyani': [
      'Chicken Biriyani',
      'Mutton Biriyani',
      'Beef Biriyani',
      'Egg Biriyani'
    ],
  };

  final Map<String, List<String>> categoryFoodImages = {
    'Salad': [
      'assets/images/dish_1.png',
      'assets/images/dish_2.png',
      'assets/images/dish_3.png',
      'assets/images/dish_4.png',
    ],
    'Beverages': [
      'assets/images/tea_1-removebg-preview.png',
      'assets/images/pepso_can-removebg-preview.png',
      'assets/images/milk_shake_remove_bg.png',
      'assets/images/orange_bottle.png'
    ],
    'Desserts': [
      'assets/images/ice-cream-removebg-preview.png',
      'assets/images/turkish_pudding-removebg-preview.png',
      'assets/images/honey-cake-removebg-preview.png',
      'assets/images/halwa-removebg-preview.png'
    ],
    'Soups': [
      'assets/images/mutton_leg-removebg-preview.png',
      'assets/images/corn-soup-removebg-preview.png',
      'assets/images/chicken-sauce-removebg-preview.png',
      'assets/images/beef_soup-removebg-preview.png',
    ],
    'Biriyani': [
      'assets/images/Chicken-Biryani-Recipe-removebg-preview.png',
      'assets/images/Mutton-Biryani-removebg-preview.png',
      'assets/images/beef_biryani-1692140447453_1200x-removebg-preview.png',
      'assets/images/Egg-biryani-recipe_palates-desire-removebg-preview.png',
    ],
  };

  @override
  void onInit() {
    super.onInit();
    favoriteStatus.assignAll(List.generate(6, (index) => false));
    allFoodItems.addAll(categoryFoodMap['Salad'] ?? []);
    filteredFoodItems.addAll(allFoodItems);
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
    String category = categoryFoodMap.keys.elementAt(index);
    filteredFoodItems.assignAll(categoryFoodMap[category] ?? []);
    favoriteStatus
        .assignAll(List.generate(filteredFoodItems.length, (index) => false));
  }

  void selectedCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void toggleFavorite(int index) {
    favoriteStatus[index] = !favoriteStatus[index];
  }

 void addToCart(String foodName, String image) {
  cartCount.value++;
  cartItems.add({'name': foodName, 'image': image});
  Get.find<CartController>().addItem(); 
}

void removeFromCart(int index) {
  if (index < cartItems.length) {
    cartItems.removeAt(index);
    cartCount.value--;
    Get.find<CartController>().removeItem(index); 
  }
}

}
