// 分割払いボタン (OutlinedButton)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MerucariButtonWhite extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MerucariButtonWhite({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white, // 背景色を白に設定
        side: BorderSide(color: Colors.red), // 枠線の色
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // 角丸
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }
}

// 購入手続きボタン (ElevatedButton)
class MercariButtonRed extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MercariButtonRed({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // 背景色
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // 角丸
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
