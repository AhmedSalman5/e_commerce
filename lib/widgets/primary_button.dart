import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPress;
  final String title;


  const PrimaryButton({super.key, this.onPress, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(title),
      ),
    );
  }
}
