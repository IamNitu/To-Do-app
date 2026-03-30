import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/todo_controller.dart';
import 'package:social_app/screens/pages/homePage/speechController.dart';

class AddTodoPage extends StatefulWidget {
  final bool isEdit;
  final int? index;
  final String? title;
  final String? message;

  const AddTodoPage({
    super.key,
    this.index,
    this.message,
    this.title,
    this.isEdit = false,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final TodoController controller = Get.find();
  final SpeechController speechController = Get.put(SpeechController());

  // true = title, false = message
  RxBool isTitleField = true.obs;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      titleController.text = widget.title ?? "";
      messageController.text = widget.message ?? "";
    }
  }

  void startSpeech(bool forTitle) {
    isTitleField.value = forTitle;
    speechController.startListening();
  }

  void bindSpeechToField() {
    if (speechController.text.value.isEmpty) return;

    if (isTitleField.value) {
      titleController.text = speechController.text.value;
      titleController.selection = TextSelection.fromPosition(
        TextPosition(offset: titleController.text.length),
      );
    } else {
      messageController.text = speechController.text.value;
      messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: messageController.text.length),
      );
    }
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required bool isTitle,
    int maxLines = 1,
  }) {
    return Obx(() {
      bindSpeechToField();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),

          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  speechController.isListening.value
                      ? Icons.mic
                      : Icons.mic_none,
                  color: Colors.blue,
                ),
                onPressed: () => startSpeech(isTitle),
              ),
            ),
          ),

          if (speechController.isListening.value)
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "Listening...",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Todo",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            buildField(
              label: "Title",
              controller: titleController,
              isTitle: true,
            ),

            const SizedBox(height: 16),

            buildField(
              label: "Message",
              controller: messageController,
              isTitle: false,
              maxLines: 5,
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(MediaQuery.of(context).size.width, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (widget.isEdit && widget.index != null) {
                  controller.editTodo(
                    widget.index!,
                    titleController.text,
                    messageController.text,
                  );
                } else {
                  controller.addTodo(
                    titleController.text,
                    messageController.text,
                  );
                }

                Get.back();
              },
              child: const Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}