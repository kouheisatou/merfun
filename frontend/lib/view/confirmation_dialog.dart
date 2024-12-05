import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // イラスト画像
            Image.asset("images/thankyou.png"),
            SizedBox(height: 16),
            // メッセージテキスト
            Text(
              "ご購入ありがとうございます！",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // 「NFTカードを見る」ボタン
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // ボタンの背景色
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
              onPressed: () {
              },
              child: Text(
                "獲得したNFTカードを見る",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
              },
              child: Text(
                "シェアする",
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
