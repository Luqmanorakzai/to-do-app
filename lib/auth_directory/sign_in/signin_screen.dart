import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/auth_directory/sign_up/signup_screen.dart';
import 'package:todo_app/custom_widget/custom_auth_button.dart';
import 'package:todo_app/screen/home_screen.dart';
import 'package:todo_app/utility/toas_message.dart';


class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}
class _SigninScreenState extends State<SigninScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void sigIn() {
    setState(() {
      isLoading = true;
    });
    firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()).then((value){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return HomeScreen();
          }));
          ToastPupop().toastShow('Signed In successfully',
                     Colors.black, Colors.white);
          setState(() {
            isLoading = false;
          });
    }).onError((error, stackTrace) {
      ToastPupop().toastShow(error.toString(), Colors.black, Colors.white);
        setState(() {
          isLoading = false;
        });
    });

  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  'Good to see you!',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Gap(10),
                const Text(
                  "Let's continue the journey.",
                  style: TextStyle(color: Colors.black),
                ),
                Gap(50),
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
                      return 'email is empty';
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      // counterStyle: TextStyle(color: Colors.black),
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
                      return 'password is empty';
                    }
                    return null;
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.text,
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
                Gap(30),
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
                Gap(30),
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
                Gap(25),
                // GestureDetector(
                //   onTap: ()async{
                //     var email = emailController.text.trim();
                //     var password = passwordlController.text.trim();
                //     if(email.isEmpty|| password.isEmpty){
                //       Fluttertoast.showToast(
                //           msg: "Enter email and password",
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.CENTER,
                //           timeInSecForIosWeb: 1,
                //           backgroundColor: Colors.black,
                //           textColor: Colors.white,
                //           fontSize: 16.0
                //       );
                //       return;
                //     }
                //     try{
                //       // it will create obj in cloud
                //       FirebaseAuth firebaseAuth=FirebaseAuth.instance;
                //       UserCredential userCredential  =
                //       await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
                //       // check user is not null firstly
                //       if(userCredential.user != null){
                //         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                //           return HomeScreen();
                //         }));
                //       }
                //
                //     }on FirebaseAuthException catch (e){
                //       print("print auth: ${e.code}");
                //       // throw exception here
                //       if (e.code == "invalid-email") {
                //         Fluttertoast.showToast(
                //           msg: "Invalid Email",
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.BOTTOM,
                //           timeInSecForIosWeb: 1,
                //           backgroundColor: Colors.black,
                //           textColor: Colors.white,
                //           fontSize: 16.0,
                //         );
                //       }
                //       if(e.code =="wrong-password"){
                //       Fluttertoast.showToast(
                //           msg: "wrong-password",
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.BOTTOM,
                //           timeInSecForIosWeb: 1,
                //           backgroundColor: Colors.red,
                //           textColor: Colors.white,
                //           fontSize: 16.0
                //       );
                //       // return;
                //       }
                //       if (e.code == "user-not-found"){
                //         Fluttertoast.showToast(
                //             msg: "User not found",
                //             toastLength: Toast.LENGTH_SHORT,
                //             gravity: ToastGravity.BOTTOM,
                //             timeInSecForIosWeb: 1,
                //             backgroundColor: Colors.black,
                //             textColor: Colors.white,
                //             fontSize: 16.0
                //         );
                //       }
                //       if(e.code == "too-many-requests"){
                //         Fluttertoast.showToast(
                //           msg: "too many requests",
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.BOTTOM,
                //           timeInSecForIosWeb: 1,
                //           backgroundColor: Colors.black,
                //           textColor: Colors.white,
                //           fontSize: 16.0,
                //         );
                //       }
                //     }catch (e){
                //       // catch other error
                //       print("Other Error: $e");
                //       Fluttertoast.showToast(
                //           msg: "Something Went Worng",
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.BOTTOM,
                //           timeInSecForIosWeb: 1,
                //           backgroundColor: Colors.black,
                //           textColor: Colors.white,
                //           fontSize: 16.0
                //       );
                //       return;
                //
                //     }
                //
                //   },
                //   child:Container(
                //     height: screenHeight * 0.07,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //         color: Colors.black,
                //         borderRadius: BorderRadius.circular(10)),
                //     child: Center(
                //       child: Text(
                //         'Log In',
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 20,
                //             fontWeight: FontWeight.w500),
                //       ),
                //     ),
                //   ),
                // ),

                // custom btn gose from here
                CustomAuthBtn(
                  text: 'Sign In',
                  fontSize: 20.0,
                  isloading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sigIn();
                    }
                    // if (_formKey.currentState!.validate()) {
                    //   setState(() {
                    //     isLoading = true;
                    //   });
                    //   firebaseAuth
                    //       .signInWithEmailAndPassword(
                    //           email: emailController.text.trim(),
                    //           password: passwordlController.text.trim())
                    //       .then((value) {
                    //     // show toast msg here before dismiss the msg
                    //     Navigator.of(context).pushReplacement(
                    //         MaterialPageRoute(builder: (context) {
                    //       return const HomeScreen();
                    //     }));
                    //     ToastPupop().toastShow('Signed In successfully',
                    //         Colors.black, Colors.white);
                    //     setState(() {
                    //       isLoading = false;
                    //     });
                    //   }).onError((error, value) {
                    //     //throw error here from server side through
                    //     ToastPupop().toastShow(error, Colors.red, Colors.white);
                    //     setState(() {
                    //       isLoading = false;
                    //     });
                    //   });
                    // }
                  },
                ),

                Gap(25),
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return SignupScreen();
                    }));
                  },
                  child: Text(
                    'Sign Up',
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
    );
  }
}
