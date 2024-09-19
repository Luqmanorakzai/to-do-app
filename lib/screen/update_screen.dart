import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/custom_widget/custom_auth_button.dart';
import 'package:todo_app/screen/home_screen.dart';


import '../utility/toas_message.dart';

class UpdateScreen extends StatefulWidget {
  final String titleTask;
  final String descrTask;
  final String taskId; // Add taskId to identify which task to update

  const UpdateScreen({
    super.key,
    required this.titleTask,
    required this.descrTask,
    required this.taskId, // Add taskId as required
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController updateTitleController;
  late TextEditingController updateDescrController;
  late DatabaseReference databaseReference = FirebaseDatabase.instance.ref('db');
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // Initialize controllers with the values passed from HomeScreen in edit ()
    // for the purpose of to take that store tasks
    updateTitleController = TextEditingController(text: widget.titleTask);
    updateDescrController = TextEditingController(text: widget.descrTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Update Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(14),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Update your task details below.',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              const Gap(20),
              TextField(
                controller: updateTitleController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Task Title',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 4,
                  ),
                  hintStyle: const TextStyle(color: Colors.black45),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black45, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black45, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const Gap(10),
              TextField(
                maxLines: 4,
                controller: updateDescrController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Task Description',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 4,
                  ),
                  hintStyle: const TextStyle(color: Colors.black45),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black45, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black45, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const Gap(20),
              CustomAuthBtn(
                height: 50.h,
                width: double.infinity,
                isloading: isLoading,
                fontSize: 20.0,
                text: 'Update',
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  // Validate fields
                  if (updateTitleController.text.isEmpty ||
                      updateDescrController.text.isEmpty) {
                    ToastPupop().toastShow(
                      'Please fill in all fields',
                      Colors.black,
                      Colors.white,
                    );
                    setState(() {
                      isLoading = false;
                    });
                    return;
                  }

                  // Update data in Firebase
                  await databaseReference.child(widget.taskId).update({
                    'taskTitle': updateTitleController.text.trim(),
                    'description': updateDescrController.text.trim(),
                  }).then((value) {
                    ToastPupop().toastShow(
                      'Task Updated Successfully',
                      Colors.black,
                      Colors.white,
                    );
                  }).catchError((error) {
                    ToastPupop().toastShow(
                      error.toString(),
                      Colors.black,
                      Colors.white,
                    );
                  });

                  setState(() {
                    isLoading = false;
                  });

                  // Navigate back to HomeScreen
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

