import 'package:openapi/api.dart';

// walletサーバAPIインスタンス
final walletServerApi = DefaultApi(ApiClient(basePath: "http://localhost:8080"));

// 自分のwallet
Wallet? myWallet;
