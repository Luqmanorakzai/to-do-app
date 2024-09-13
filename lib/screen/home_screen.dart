import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/auth_directory/sign_up/signup_screen.dart';
import 'package:todo_app/utility/toas_message.dart';

import '../auth_directory/sign_in/signin_screen.dart';
import '../custom_widget/custom_auth_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var dataLoading = false;

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Home Screen',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14))),
        actions: [
          // IconButton(onPressed: () {
          //   FirebaseAuth.instance.signOut();
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          //     return SigninScreen();
          //   }));
          // }, icon: Icon(Icons.logout_outlined,color: Colors.white,)),
          /////////////////////
          IconButton(
            onPressed: () {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      "Logout Confirmation",
                      style: TextStyle(color: Colors.black),
                    ),
                    content: const Text("Are you sure to log out?",
                        style: TextStyle(color: Colors.black)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // If the user presses "Cancel", just close the dialog
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.black)),
                      ),
                      TextButton(
                        onPressed: () {
                          // If the user presses "OK", log out and navigate to SigninScreen
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return SigninScreen();
                          }));
                        },
                        child: const Text("Log out",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout_outlined, color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Confirmation!!!',
                        style: TextStyle(color: Colors.black),
                      ),
                      content: Text(
                        'Are you sure to delte?',
                        style: TextStyle(color: Colors.black),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'No',
                              style: TextStyle(color: Colors.black),
                            )),
                        TextButton(
                            onPressed: () {
                              auth.currentUser!.delete();
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return const SignupScreen();
                              }));
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    );
                  });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.delete_outline,
                size: 25.sp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Add Tasks',
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
                      EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  hintStyle: TextStyle(color: Colors.black45),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2),
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
                  EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  hintStyle: TextStyle(color: Colors.black45),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(8))),
            ),
            Gap(20),
            CustomAuthBtn(
              onPressed: () {
                setState(() {
                  dataLoading = true;
                });
                late DatabaseReference dataRf;
                dataRf = FirebaseDatabase.instance.ref('DataAdded');
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                int dt = DateTime.now().millisecondsSinceEpoch;
                dataRf.child(id).set({
                  'id': id,
                  'taskTitle': titleController.text.trim(),
                  'description':descriptionController.text.trim(),
                  'dt': dt,
                }).then((value) {
                  ToastPupop().toastShow(
                      'Task Added Successfully', Colors.black, Colors.white);
                  setState(() {
                    dataLoading = false;
                  });
                }).onError((error, stackTrace) {
                  ToastPupop().toastShow(error, Colors.black, Colors.white);
                  setState(() {
                    dataLoading = false;
                  });
                });
                titleController.clear();
                descriptionController.clear();
              },
              isloading: dataLoading,
              fontSize: 20.0,
              text: 'Add Data',
            )
          ],
        ),
      ),
    );
  }
}
