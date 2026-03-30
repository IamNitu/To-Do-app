import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/screens/pages/profilePage/profileController.dart';
import 'package:social_app/screens/pages/profilePage/profileWidgets/aboutApp.dart';
import 'package:social_app/screens/pages/profilePage/profileWidgets/changePassword.dart';
import 'package:social_app/screens/pages/profilePage/profileWidgets/editProfile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          "Profile"),
        elevation: 0,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // PROFILE CARD
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),

              child: Obx(() {
                return Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/300",
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      controller.name.value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      controller.email.value,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        statBox("Tasks", controller.tasks.value),
                        statBox("Done", controller.completed.value),
                        statBox("Pending", controller.pending.value),
                      ],
                    ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 20),

            // SETTINGS SECTION
            settingsTile(Icons.edit, "Edit Profile", () {
              Get.to(()=>EditProfilePage());
            }),
            settingsTile(Icons.notifications, "Notifications", () {}),
            settingsTile(Icons.lock, "Change Password", () {
              Get.to(()=>Changepassword());
            }),
            settingsTile(Icons.info, "About App", () {
              Get.to(()=>AboutApp());
            }),

            const SizedBox(height: 20),

            // LOGOUT BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: controller.logout,
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget statBox(String title, int value) {
    return Column(
      children: [
        Text(
          "$value",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget settingsTile(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}