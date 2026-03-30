import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = "Nitu Sharma".obs;
  var email = "nitu@gmail.com".obs;
  var phone = "+977 98XXXXXXXX".obs;

  var tasks = 24.obs;
  var completed = 18.obs;
  var pending = 6.obs;

  void updateProfile(String newName, String newEmail, String newPhone) {
    name.value = newName;
    email.value = newEmail;
    phone.value = newPhone;

    Get.snackbar(
      "Success",
      "Profile updated successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void logout() {
    Get.snackbar("Logout", "You have been logged out");
  }
}