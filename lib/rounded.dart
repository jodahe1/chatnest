import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color materialColor;  
  final Function() onCliked; 
  final String texts; 
  RoundedButton({
    required this.materialColor,
    required this.onCliked,
    required this.texts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: materialColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
           onCliked();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
           texts,
          ),
        ),
      ),
    );
  }
}
