import 'package:flutter/material.dart';

class CustomAuthBtn extends StatelessWidget {
  final onPressed;
  final text;
  final fontSize;
  final isloading;
  const CustomAuthBtn(
      {super.key,
      this.onPressed,
      this.text,
      this.fontSize,
      this.isloading = false});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: screenHeight * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: isloading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text ?? "",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
}
