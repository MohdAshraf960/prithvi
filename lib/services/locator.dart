import 'package:get_it/get_it.dart';
import 'package:prithvi/services/firebase_analytics.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => AnalyticsServices());
}
