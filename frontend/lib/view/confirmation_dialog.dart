import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupportSuccessDialog extends StatelessWidget {
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
              "応援できました！",
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
                // NFTカードを見る処理
              },
              child: Text(
                "獲得したNFTカードを見る",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            // 「シェアする」テキストボタン
            TextButton(
              onPressed: () {
                // 応援をシェアする処理
              },
              child: Text(
                "応援したことをシェアする",
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
