import 'package:truesight_flutter/truesight_flutter.dart';

class PcStatus extends DataModel {
  static const ONLINE = "ONLINE";

  static const OFFLINE = "OFFLINE";

  @override
  List<JsonField> get fields => [
        status,
      ];

  JsonString status = JsonString("status");
}
