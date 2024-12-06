import 'package:openapi/api.dart';

final walletServerApi = DefaultApi(ApiClient(basePath: "http://localhost:8080"));
Wallet? myWallet = null;
