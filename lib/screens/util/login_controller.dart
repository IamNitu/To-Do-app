import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/screens/pages/homePage/home_Screen.dart';
import 'package:social_app/screens/util/login_page.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(email);
  }

  void login() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    if (!isValidEmail(emailController.text)) {
      Get.snackbar("Error", "Invalid email");
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar("Success", "Login Successful");

    // REMOVE LOGIN PAGE FROM STACK
    Get.offAll(() => HomeScreen());
  }

  // LOGOUT 
  void logout() {
    Get.offAll(() => LoginPage());

    Get.snackbar(
      "Logged Out",
      "You have been logged out",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}