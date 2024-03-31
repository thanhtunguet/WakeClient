import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:truesight_flutter/models/models.dart';
import 'package:wake_client/models/pc_status.dart';

import 'get_it.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
  DataModel.setType(PcStatus, () => PcStatus());
}
