import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/changePasswordController.dart';

class Changepassword extends StatelessWidget {
  Changepassword({super.key});

  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // OLD PASSWORD
            Obx(() => TextField(
                  controller: controller.oldPasswordController,
                  obscureText: controller.isOldHidden.value,
                  decoration: InputDecoration(
                    labelText: "Old Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isOldHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: controller.toggleOld,
                    ),
                  ),
                )),

            const SizedBox(height: 15),

            // NEW PASSWORD
            Obx(() => TextField(
                  controller: controller.newPasswordController,
                  obscureText: controller.isNewHidden.value,
                  decoration: InputDecoration(
                    labelText: "New Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isNewHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: controller.toggleNew,
                    ),
                  ),
                )),

            const SizedBox(height: 15),

            // CONFIRM PASSWORD
            Obx(() => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.isConfirmHidden.value,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isConfirmHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: controller.toggleConfirm,
                    ),
                  ),
                )),

            const SizedBox(height: 25),

            // BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.changePassword,
                child: const Text("Update Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}