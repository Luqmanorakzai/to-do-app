import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/auth_directory/sign_in/signin_screen.dart';
import 'package:todo_app/screen/home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigate();
  }
  _navigate() async {
    print('this is timer class');
    // await Future.delayed(Duration(milliseconds: 1500),(){});
    await Future.delayed(Duration(seconds: 2));
    if(FirebaseAuth.instance.currentUser!= null)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return HomeScreen();
        }));
      }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return SigninScreen();
      }));
    }


    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    //   return SigninScreen();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Center(child: Text('Hello Splash Screen',style: TextStyle(color: Colors.black,fontSize: 20.sp),)),
          ),
          Image.asset('assets/images/shoe.jpeg')
        ],
      ),
    );
  }
}
