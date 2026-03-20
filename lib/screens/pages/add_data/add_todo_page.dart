import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:social_app/controller/todo_controller.dart';

class AddTodoPage extends StatefulWidget {
  final bool isEdit;
  final int? index;
  final String? title;
  final String? message;
  const AddTodoPage({super.key, this.index, this.message, this.title, this.isEdit=true});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  TextEditingController titleController =TextEditingController();
  TextEditingController messageController =TextEditingController();
  final TodoController controller=Get.find();

  @override
  void initState(){
    super.initState();
    if(widget.isEdit){
      titleController.text = widget.title ?? "";
      messageController.text =widget.message??"";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("text",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addcard("Title", controller: titleController),
            SizedBox(height: 16,),
            addcard('Message', controller: messageController, isMessage: true),
            SizedBox(height: 20,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade300,
                shape: RoundedRectangleBorder(),
                minimumSize: Size(MediaQuery.of(context).size.width, 45)
              ),
              onPressed: (){
                if(widget.isEdit){
                  controller.editTodo(widget.index!, titleController.text, messageController.text);
                }
                else{
                  controller.addTodo(titleController.text,
                 messageController.text);
                }
                 Get.back();
              }, 
              child: Text('SAVE',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),))
          ],
        ),
      ),
    );
  }
}

Widget addcard(String title, {bool isMessage = false, TextEditingController? controller}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold
      ),),
      SizedBox(height: 4,),
       TextField(
        controller: controller,
        maxLines: isMessage ? 5 : 1,
        decoration: InputDecoration(
          hintText: isMessage ? "Add your message" : "",
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ],
  );
}