import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/screen/home_screen.dart';
import '../custom_widget/custom_auth_button.dart';
import '../utility/toas_message.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var isLoading = false;
  // late DatabaseReference
  // dataRef = FirebaseDatabase.instance.ref('db');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Add Your Tasks',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Type your task title and \n details',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              Gap(20),
              TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    // counterStyle: TextStyle(color: Colors.black),
                    // filled: true,
                    // enabled: true,
                    // labelText: 'text',
                    // label: Text('text'),
                    hintText: 'Task Title',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    hintStyle: const TextStyle(color: Colors.black45),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black45, width: 2),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black45, width: 2),
                        borderRadius: BorderRadius.circular(8))),
              ),
              Gap(10),
              TextField(
                maxLines: 4,
                controller: descriptionController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    // counterStyle: TextStyle(color: Colors.black),
                    // filled: true,
                    // enabled: true,
                    // labelText: 'text',
                    // label: Text('text'),
                    hintText: 'Task Description',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    hintStyle: const TextStyle(color: Colors.black45),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black45, width: 2),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black45, width: 2),
                        borderRadius: BorderRadius.circular(8))),
              ),
              const Gap(20),
              CustomAuthBtn(
                height: 50.h,
                width: double.infinity,
                isloading: isLoading,
                fontSize: 20.0,
                text: 'Add Tasks',
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  if (titleController.text.trim().isEmpty &&
                      descriptionController.text.trim().isEmpty) {
                    ToastPupop().toastShow('please fill your fields',
                        Colors.black, Colors.white);
                    setState(() {
                      isLoading = false;
                    });
                    return;
                  }
                  // dataBaseRef is na object and db is my database name in firebase
                  late DatabaseReference databaseRef;
                  databaseRef = FirebaseDatabase.instance.ref('db');
                  String id =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  int dt = DateTime.now().millisecondsSinceEpoch;
                  databaseRef.child(id).set({
                    'id': id,
                    'taskTitle': titleController.text.trim(),
                    'description': descriptionController.text.trim(),
                    'dt': dt,
                  }).then((value) {
                    ToastPupop().toastShow('Task Added Successfully',
                        Colors.black, Colors.white);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }));
                    setState(() {
                      isLoading = false;
                    });

                  }).onError((error, stackTrace) {
                    ToastPupop()
                        .toastShow(error, Colors.black, Colors.white);
                    setState(() {
                      isLoading = false;
                    });
                  });
                  titleController.clear();
                  descriptionController.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
