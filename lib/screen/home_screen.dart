import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/auth_directory/sign_up/signup_screen.dart';
import 'package:todo_app/custom_widget/custom_auth_button.dart';
import 'package:todo_app/screen/task_lists_screen.dart';
import 'package:todo_app/screen/update_screen.dart';
import 'package:todo_app/utility/toas_message.dart';
import '../auth_directory/sign_in/signin_screen.dart';
import '../custom_widget/custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLoading = false;
  late DatabaseReference dataRef = FirebaseDatabase.instance.ref('db');
  FirebaseAuth auth = FirebaseAuth.instance;

//// pass the parameters form you tap button
//   Future<void> update(String taskId, String currentTitle, String currentDescription) async {
//     late DatabaseReference dataRef = FirebaseDatabase.instance.ref('db');
//
//     // Prefill the text controllers with current task data
//     var updateTitleController = TextEditingController(text: currentTitle);
//     var updateDescriptionController = TextEditingController(text: currentDescription);
//
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Update Your Task', style: TextStyle(color: Colors.black)),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   style: const TextStyle(color: Colors.black),
//                   controller: updateTitleController,
//                   decoration: InputDecoration(
//                     hintText: 'Title',
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   style: const TextStyle(color: Colors.black),
//                   controller: updateDescriptionController,
//                   decoration: InputDecoration(
//                     hintText: 'Description',
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   // Close the dialog
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('No', style: TextStyle(color: Colors.black)),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   // Update the task in Firebase
//                   dataRef.child(taskId).update({
//                    'taskTitle': updateTitleController.text.trim(),
//                     'description': updateDescriptionController.text.trim(),
//                   }).then((value) {
//                     ToastPupop().toastShow('Task Updated Successfully', Colors.black, Colors.white);
//                     Navigator.of(context).pop(); // Close the dialog after success
//                   }).onError((error, stackTrace) {
//                     ToastPupop().toastShow(error.toString(), Colors.black, Colors.white);
//                   });
//                 },
//                 child: const Text('Update', style: TextStyle(color: Colors.black)),
//               ),
//             ],
//           );
//         }
//     );
//   }

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
        // to change the color of icon place on app bar
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                height: 70.h,
                width: 70.w,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
                child: Padding(
                  padding:  EdgeInsets.only(left: 60.sp,top: 35.sp),
                  child:const  Icon(Icons.edit),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                height: 2,
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Log Out',
                    style:
                    TextStyle(color: Colors.black, fontSize: 20.sp),
                  ),
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
                            content: const Text(
                                "Are you sure to log out?",
                                style: TextStyle(color: Colors.black)),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // If the user presses "Cancel", just close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel",
                                    style:
                                    TextStyle(color: Colors.black)),
                              ),
                              TextButton(
                                onPressed: () {
                                  // If the user presses "OK", log out and navigate to SigninScreen
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) {
                                            return const SigninScreen();
                                          }));
                                },
                                child: const Text("Log out",
                                    style:
                                    TextStyle(color: Colors.black)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.logout_outlined,
                        color: Colors.black),
                  ),
                ],
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delete account',
                    style:
                    TextStyle(color: Colors.black, fontSize: 20.sp),
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
                              content: const Text(
                                'Are you sure to delte?',
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'No',
                                      style:
                                      TextStyle(color: Colors.black),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      auth.currentUser!.delete();
                                      Navigator.of(context)
                                          .pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return const SignupScreen();
                                              }));
                                    },
                                    child: const Text(
                                      'Delete',
                                      style:
                                      TextStyle(color: Colors.black),
                                    )),
                              ],
                            );
                          });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.delete_outline,
                        size: 30.sp,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: FirebaseAnimatedList(
                  // add your db obj to query
                  query: dataRef,
                  itemBuilder: (BuildContext, DataSnapshot, _, index) {
                    return Container(
                      height: 100,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Column(
                        children: [
                          // Text(
                          //   'Date: ${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(int.parse(DataSnapshot.child('dt').value.toString())))}',
                          //   style: const TextStyle(color: Colors.white),
                          // ),
                          Text(
                              'Date: ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(DataSnapshot.child('dt').value.toString())))}'),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                DataSnapshot.child('taskTitle').value.toString(),
                                style:
                                    const TextStyle(color: Colors.white,),
                              ),
                              subtitle: Text(
                                DataSnapshot.child('description').value.toString(),
                                style:
                                   const  TextStyle(color: Colors.white,),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext) {
                                              return CustomDialoge(
                                                title: 'Confirmation',
                                                content: 'Are you sure to delete',
                                                onNoPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                onYesPressed: () {
                                                  // delete data through dataRef obj of the db
                                                  dataRef
                                                      .child(DataSnapshot.child('id')
                                                          .value
                                                          .toString())
                                                      .remove()
                                                      .then((value) {
                                                    ToastPupop().toastShow(
                                                        'Task deleted',
                                                        Colors.black,
                                                        Colors.white);
                                                  }).onError((error, stackTrace) {
                                                    ToastPupop().toastShow(error,
                                                        Colors.black, Colors.white);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              );
                                            });
                                        //update the firebase in this icon
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) {
                                          return UpdateScreen(
                                            // id: DataSnapshot.child(id).value.toString(),
                                            titleTask: DataSnapshot.child('taskTitle')
                                                .value
                                                .toString(),
                                            descrTask:
                                                DataSnapshot.child('description')
                                                    .value
                                                    .toString(),
                                            taskId: DataSnapshot.child('id')
                                                .value
                                                .toString(),
                                          );
                                        }));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Expanded(
                child: CustomAuthBtn(
                  height: 50.h,
                  width: double.infinity,
                  text: 'Add Your Tasks',
                  fontSize: 20.0.sp,
                  onPressed: (){
                    setState(() {
                      isLoading = true;
                    });
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const TaskListScreen();
                    }));
                  },
                )

            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       isLoading = true;
      //     });
      //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //       return const TaskListScreen();
      //     }));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
