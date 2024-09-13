import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/firebase_services/splash_service/splash_screen_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SplashService().isLogin(context);
    super.initState();
    // _navigate();
  }
//// instead of the below use fire service
  // _navigate() async {
  //   // await Future.delayed(Duration(milliseconds: 1500),(){});
  //   await Future.delayed(Duration(seconds: 2));
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  //       return HomeScreen();
  //     }));
  //   } else {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  //       return SigninScreen();
  //     }));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Center(
                child: Text(
              'Hello Splash Screen',
              style: TextStyle(color: Colors.black, fontSize: 20.sp),
            )),
          ),
          Image.asset('assets/images/shoe.jpeg')
        ],
      ),
    );
  }
}
