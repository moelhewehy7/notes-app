import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key, required this.icon, this.onPressed})
      : super(key: key);

  final void Function()? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(40, 50),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.white.withOpacity(.05),
      ),
      child: Ink(
        width: 30,
        height: 30,
        child: Center(
          child: Icon(
            icon,
            size: 25,
          ),
        ),
      ),
    );
  }
}
