import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onpressed,
  });
  final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,
        child: Text(
          "Save",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff62FCD7),
            fixedSize: Size(MediaQuery.of(context).size.width,
                40), // Change the button size here
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))));
  }
}
