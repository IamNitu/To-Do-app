import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/screens/util/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Login page")),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height:420,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color:  Colors.blue.shade200,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
              child: Column(
                children: [
                  Text("Login Now!", style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
          
                  SizedBox(height: 20,),
          
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
            
                  SizedBox(height: 15),
            
                  TextField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
            
                  SizedBox(height: 40),
            
                  Obx(()=>SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(onPressed: controller.login, 
                    child: controller.isLoading.value?
                    CircularProgressIndicator(
                      color: Colors.white,
                    ): Text('Login', style: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                    ),)),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
