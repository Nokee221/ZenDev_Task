import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;

  const IconTextButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        foregroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), 
          ),
        ),
      ),
      icon: Icon(icon , color: textColor,), // Ikona
      label: Text(text , style: TextStyle(color: textColor),), // Tekst
    );
  }
}