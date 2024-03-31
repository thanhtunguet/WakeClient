import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:truesight_flutter/truesight_flutter.dart';
import 'package:wake_client/models/pc_status.dart';

@singleton
class ClientRepository extends HttpRepository {
  @override
  InterceptorsWrapper interceptorsWrapper = InterceptorsWrapper();

  @override
  String? get baseUrl => dotenv.env["BASE_URL"];

  Future<PcStatus> isServerOnline() async {
    return get("/api/pc/status").then((response) => response.body<PcStatus>());
  }

  Future<String> powerOn() async {
    return get("/api/pc/power-on").then((response) => response.data);
  }
}
