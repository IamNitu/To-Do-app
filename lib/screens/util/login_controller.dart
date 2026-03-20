
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/screens/pages/homePage/home_Screen.dart';

class LoginController extends GetxController{

//controllers
  final emailController =TextEditingController();
  final passwordController =TextEditingController();

  //loading state
  var isLoading =false.obs;

  //email validation
   String? emailError;
   bool isValidEmail(String email) {
      return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    }

  void login() async{
    if(emailController.text.isEmpty || passwordController.text.isEmpty){
      Get.snackbar('Error', 
      'Please fill all the fields',
      snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if(!isValidEmail(emailController.text)){
      Get.snackbar("Error", 'Please fill the valid email address',
      snackPosition: SnackPosition.BOTTOM);
      return;
    }
    

    isLoading.value =true;

    await Future.delayed(Duration(seconds: 2));

    isLoading.value=false;

    Get.snackbar('Success', 
      'Login Successfull',
      snackPosition: SnackPosition.BOTTOM);

      Get.to(()=>HomeScreen());
  }
@override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}