
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isOldHidden = true.obs;
  var isNewHidden = true.obs;
  var isConfirmHidden = true.obs;

  void toggleOld() => isOldHidden.value = !isOldHidden.value;
  void toggleNew() => isNewHidden.value = !isNewHidden.value;
  void toggleConfirm() => isConfirmHidden.value = !isConfirmHidden.value;

  void changePassword() {
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (newPass.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters",
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    if (newPass != confirmPass) {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    Get.snackbar("Success 🎉", "Password changed successfully",
        backgroundColor: Colors.green, colorText: Colors.white);

    clearFields();
  }

  void clearFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}