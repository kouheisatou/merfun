import 'package:blockchain_server_api/api.dart' as bc_api;
import 'package:wallet_server_api/api.dart' as wl_api;

final blockchain_server_api = bc_api.DefaultApi(bc_api.ApiClient(basePath: "http://localhost:5001"));
final wallet_server_api = wl_api.DefaultApi(wl_api.ApiClient(basePath: "http://localhost:8080"));
