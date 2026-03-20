import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:social_app/controller/todo_controller.dart';
import 'package:social_app/screens/pages/add_data/add_todo_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TodoController controller =Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Hello',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            Get.to(()=>AddTodoPage());
          },
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.shade400,
            ),
            child: Center(
              child: Text(
                "+ Add ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //search textbar
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search here...",
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: Text(
                      'SEARCH',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //card
              Obx(()=>ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.todoList.length,
                  itemBuilder: (context,index){

                  final todo =controller.todoList[index];
                  return Card(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                   color: Colors.grey.shade200,
                   elevation: 4, 
                   child: Padding(
                     padding: const EdgeInsets.all(10),
                     child: ListTile(
                       title: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(todo.title, style: TextStyle(fontSize: 14)),
                           SizedBox(height: 4),
                           Text(todo.message, style: TextStyle(fontSize: 14)),
                           
                         ],
                       ),
                       // for deleteing card
                       trailing: Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           IconButton(
                           onPressed: (){
                            Get.to(()=>AddTodoPage(
                              index:index,
                              title:todo.title,
                              message:todo.message,
                            ));
                           }, icon: Icon(Icons.edit)),
                           IconButton(
                           onPressed: (){
                            controller.deleteTodo(index);
                           }, icon: Icon(Icons.delete,
                           color: Colors.redAccent,)),
                         ],
                       ),
                     ),
                   ),
                 );
                 })
              ),
            ],
          ),
        ),
      ),
    );
  }
}
