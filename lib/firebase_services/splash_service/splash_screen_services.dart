

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../auth_directory/sign_in/signin_screen.dart';
import '../../screen/home_screen.dart';

// class SplashService {
//   void isLogin(BuildContext context) {
//     Future.delayed(const Duration(seconds: 2),(){
//       FirebaseAuth auth = FirebaseAuth.instance;
//       //store auth in final variable
//       final user = auth.currentUser;
//       if (user != null) {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => HomeScreen(),
//         ));
//       } else {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => SigninScreen(),
//         ));
//       }
//     });
//
//     }
// }

class SplashService{
  void isLogin(BuildContext context){
    Future.delayed(Duration(seconds: 2),(){
      if(FirebaseAuth.instance.currentUser!=null){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomeScreen() ,));
      }else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SigninScreen() ,));
      }
    });
  }
}

