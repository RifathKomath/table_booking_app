import 'package:get/get.dart';

class CartController extends GetxController {
  final RxList<int> cartQuantities = <int>[].obs;
  final double itemPrice = 10.0;
  final double taxAmount = 5.0;

  double get price =>
      cartQuantities.fold(0.0, (sum, qty) => sum + (qty * itemPrice));

  double get totalPrice =>
      cartQuantities.fold(0.0, (sum, qty) => sum + (qty * itemPrice)) +
      taxAmount;

  void increment(int index) {
    if (index < cartQuantities.length) {
      cartQuantities[index]++;
    }
  }

  void decrement(int index) {
    if (index < cartQuantities.length && cartQuantities[index] > 1) {
      cartQuantities[index]--;
    }
  }

  void addItem() {
    cartQuantities.add(1);
  }

  void removeItem(int index) {
    if (index < cartQuantities.length) {
      cartQuantities.removeAt(index);
    }
  }
}
