import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/screens/pages/profilePage/profileController.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileController controller = Get.find();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: controller.name.value);
    emailController = TextEditingController(text: controller.email.value);
    phoneController = TextEditingController(text: controller.phone.value);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

void saveProfile() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Confirm Update"),
        content: const Text("Do you want to save changes to your profile?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              controller.updateProfile(
                nameController.text,
                emailController.text,
                phoneController.text,
              );

              Navigator.of(context).pop(); // close dialog
              Navigator.of(context).pop(); // go back to previous screen
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // PROFILE IMAGE
              const CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
              ),

              const SizedBox(height: 25),

              // NAME
              textField("Name", nameController),

              const SizedBox(height: 15),

              // EMAIL
              textField("Email", emailController),

              const SizedBox(height: 15),

              // PHONE
              textField("Phone", phoneController),

              const SizedBox(height: 30),

              // SAVE BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: saveProfile,
                child: const Text(
                  "SAVE CHANGES",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}