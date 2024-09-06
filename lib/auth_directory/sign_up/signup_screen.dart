import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:ndialog/ndialog.dart';
import 'package:todo_app/auth_directory/sign_in/signin_screen.dart';
import 'package:todo_app/custom_widget/custom_auth_button.dart';
import 'package:todo_app/utility/toas_message.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var isloading = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //signup function
  void signUp() {
    setState(() {
      isloading = true;
    });
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((value) {
      // show toast msg here before dismiss the msg
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return SigninScreen();
      }));
      ToastPupop()
          .toastShow('Signed up successfully', Colors.black, Colors.white);
      setState(() {
        isloading = false;
      });
    }).onError((Error, value) {
      //throw error here from server side through
      ToastPupop().toastShow(Error, Colors.red, Colors.white);
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'W e l c o m e !',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Signup to get started.',
                    style: TextStyle(color: Colors.black),
                  ),
                  Gap(10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    validator: (useName) {
                      if (useName!.isEmpty) {
                        return 'Please enter UserName';
                      }
                      return null;
                    },
                    controller: nameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        // filled: true,
                        // enabled: true,
                        // labelText: 'text',
                        // label: Text('text'),
                        hintText: 'Username',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        hintStyle: TextStyle(color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 2),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  Gap(8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: emailController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        // filled: true,
                        // enabled: true,
                        // labelText: 'text',
                        // label: Text('text'),
                        hintText: 'abc@gmail.com',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        hintStyle: TextStyle(color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 2),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  Gap(8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    validator: (password) {
                      if (password!.isEmpty) {
                        return 'Please enter password';
                      }
                      if (passwordController.text.length < 8) {
                        return 'weak password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        // filled: true,
                        // enabled: true,
                        // labelText: 'text',
                        // label: Text('text'),
                        hintText: '********',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        hintStyle: TextStyle(color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 2),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  Gap(8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Text(
                          'Confirm password',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    validator: (confirmPassword) {
                      if (confirmPassword!.isEmpty) {
                        return 'Please Confirm you Password';
                      } if (passwordController.text !=
                          confirmPasswordController.text) {
                        return 'passwords donot matched';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: confirmPasswordController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        // filled: true,
                        // enabled: true,
                        // labelText: 'text',
                        // label: Text('text'),
                        hintText: '********',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        hintStyle: TextStyle(color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 2),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  Gap(14),
                  // Divider(thickness: 4,indent: 50,endIndent: 50,height: 2,color: Colors.cyan,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: screenWidth * 0.3,
                        color: Colors.black45,
                      ),
                      Gap(2),
                      const Text(
                        'or',
                        style: TextStyle(color: Colors.black),
                      ),
                      Gap(2),
                      Container(
                        height: 2,
                        width: screenWidth * 0.3,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                  Gap(14),
                  Container(
                    height: screenHeight * 0.080,
                    width: double.infinity,
                    // color: Colors.cyan,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              shape: BoxShape.circle),
                          child: Icon(size: 35, Icons.facebook_outlined),
                        ),
                        Gap(25),
                        Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  fit: BoxFit.contain,
                                  'assets/images/googleicon.png'),
                            )),
                        Gap(25),
                        Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  fit: BoxFit.contain,
                                  'assets/images/twitericon.png'),
                            )),
                      ],
                    ),
                  ),
                  Gap(20),
                  // GestureDetector(
                  //   onTap: () async {
                  //     Fluttertoast toast = Fluttertoast();
                  //     var name = nameController.text.trim();
                  //     var email = emailController.text.trim();
                  //     var password = passwordController.text.trim();
                  //     var confirmPassword = confirmPasswordController.text.trim();
                  //     if (name.isEmpty ||
                  //         email.isEmpty ||
                  //         password.isEmpty ||
                  //         confirmPassword.isEmpty) {
                  //       Fluttertoast.showToast(
                  //           msg: "Please Filled All Fields",
                  //           toastLength: Toast.LENGTH_SHORT,
                  //           gravity: ToastGravity.CENTER,
                  //           timeInSecForIosWeb: 1,
                  //           backgroundColor: Colors.black,
                  //           textColor: Colors.white,
                  //           fontSize: 16.0);
                  //       return;
                  //     }
                  //     //check password length for credential
                  //     if (password.length < 6) {
                  //       Fluttertoast.showToast(
                  //           msg: "Weak Password",
                  //           toastLength: Toast.LENGTH_SHORT,
                  //           gravity: ToastGravity.CENTER,
                  //           timeInSecForIosWeb: 1,
                  //           backgroundColor: Colors.black,
                  //           textColor: Colors.white,
                  //           fontSize: 16.0);
                  //       return;
                  //     }
                  //     if (confirmPassword != password) {
                  //       Fluttertoast.showToast(
                  //           msg: "ConfirmPassword doesn't matched",
                  //           toastLength: Toast.LENGTH_SHORT,
                  //           gravity: ToastGravity.CENTER,
                  //           timeInSecForIosWeb: 1,
                  //           backgroundColor: Colors.black,
                  //           textColor: Colors.white,
                  //           fontSize: 16.0);
                  //       return;
                  //     }
                  //     // show progress dialog before sign up code due to time
                  //     // Show progress dialog
                  //     NDialog dialog = NDialog(
                  //       dialogStyle: DialogStyle(titleDivider: true),
                  //       title: const Text("Signing Up"),
                  //       content: const Text("Please wait"),
                  //     );
                  //     dialog.show(context);
                  //     Navigator.pop(context);
                  //     // to signup to firebase
                  //     // initialize the instance in try {}catch for exceptions
                  //     try {
                  //       FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  //
                  //       // UserCredential are fore the user withe firestore
                  //       UserCredential useCredential =
                  //           await firebaseAuth.createUserWithEmailAndPassword(
                  //               email: email, password: password);
                  //       // store the user here like user name phone number
                  //       ////code goes here
                  //
                  //       //dialog dismiss
                  //       Navigator.pop(context);
                  //       //show success dialog
                  //       Fluttertoast.showToast(
                  //           msg: "Signed up Successfully",
                  //           toastLength: Toast.LENGTH_SHORT,
                  //           gravity: ToastGravity.CENTER,
                  //           timeInSecForIosWeb: 1,
                  //           backgroundColor: Colors.black,
                  //           textColor: Colors.white,
                  //           fontSize: 16.0);
                  //       //also navigate to login screen
                  //       Navigator.of(context).push(
                  //           MaterialPageRoute(builder: (context) {
                  //             return SigninScreen();
                  //           }));
                  //     } on FirebaseAuthException catch (e) {
                  //       if (e.code == 'email-already-in-user') {
                  //         // show toast
                  //         Fluttertoast.showToast(
                  //             msg: "Email is already in use",
                  //             toastLength: Toast.LENGTH_SHORT,
                  //             gravity: ToastGravity.CENTER,
                  //             timeInSecForIosWeb: 1,
                  //             backgroundColor: Colors.black,
                  //             textColor: Colors.white,
                  //             fontSize: 16.0);
                  //       } else if (e.code == 'weak-password') {
                  //         Fluttertoast.showToast(
                  //             msg: "Your password is weak",
                  //             toastLength: Toast.LENGTH_SHORT,
                  //             gravity: ToastGravity.CENTER,
                  //             timeInSecForIosWeb: 1,
                  //             backgroundColor: Colors.black,
                  //             textColor: Colors.white,
                  //             fontSize: 16.0);
                  //       }else {
                  //         Fluttertoast.showToast(
                  //             msg: "Failed to up${e.message}",
                  //             toastLength: Toast.LENGTH_SHORT,
                  //             gravity: ToastGravity.CENTER,
                  //             timeInSecForIosWeb: 1,
                  //             backgroundColor: Colors.black,
                  //             textColor: Colors.white,
                  //             fontSize: 16.0);
                  //       }
                  //     } catch (e) {
                  //       //dialog dismiss
                  //       Navigator.pop(context);
                  //       Fluttertoast.showToast(msg: 'Something went wrong');
                  //     }
                  //     ////////////////////////////////
                  //   },
                  //   child: Container(
                  //     height: screenHeight * 0.07,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Center(
                  //       child: Text(
                  //         'Sign Up',
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //// custom button
                  CustomAuthBtn(
                    text: 'Sign Up',
                    fontSize: 20.0,
                    isloading: isloading,
                    onPressed: () {
                      // if(_formKey.currentState!.validate()){
                      // if(passwordController.text!= confirmPasswordController.text){
                      // ToastPupop().toastShow('Passwords do not matched', Colors.black, Colors.white);
                      // }
                      //                   setState(() {
                      //                     isloading = true;
                      //                   });
                      //                   firebaseAuth.createUserWithEmailAndPassword(
                      //                       email: emailController.text.trim(),
                      //                       password: passwordController.text.trim()).then((value) {
                      //                     // show toast msg here before dismiss the msg
                      //                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                      //                       return SigninScreen();
                      //                     }));
                      //                     ToastPupop().toastShow('Signed up successfully', Colors.black, Colors.white);
                      //                     setState(() {
                      //                       isloading=false;
                      //                     });
                      //                   }).onError((Error, value) {
                      //                     //throw error here from server side through
                      //                     ToastPupop().toastShow(Error, Colors.red, Colors.white);
                      //                     setState(() {
                      //                       isloading = false;
                      //                     });
                      //                   });
                      ///////////////////////
                      if (_formKey.currentState!.validate()) {
                        signUp();
                        // setState(() {
                        //   isloading = false;
                        // });
                      }
                    }, // onpressed
                  ),
                  Gap(10),
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  Gap(8),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SigninScreen();
                      }));
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
