import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CheckController extends GetxController {
  RxBool isContainerVisible = false.obs;

  void toggleContainerVisibility() {
    isContainerVisible.value = !isContainerVisible.value;
  }
}
