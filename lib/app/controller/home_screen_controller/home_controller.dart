import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxInt tableCount = 0.obs;
  RxString name = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString numberOfPersons = ''.obs;
  RxBool isSubmitted = false.obs;
  late GlobalKey<FormState> formKey;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void incrementTableCount() {
    tableCount.value++;
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name.value);
    prefs.setString('phoneNumber', phoneNumber.value);
    prefs.setString('numberOfPersons', numberOfPersons.value);
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? '';
    phoneNumber.value = prefs.getString('phoneNumber') ?? '';
    numberOfPersons.value = prefs.getString('numberOfPersons') ?? '';
  }

  void toggleSubmission() {
    isSubmitted.value = true;
  }
}
