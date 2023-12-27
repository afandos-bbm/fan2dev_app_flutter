import 'package:fan2dev/core/shared_preferences_service/shared_preferences_service.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/utils/device_info.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

/// Initializes the GetIt service locator and registers the necessary
/// dependencies
Future<void> initGetIt() async {
  // * Storage
  locator.registerSingletonAsync<SharedPreferencesService>(
    SharedPreferencesService.initSharedPreferencesService,
  );

  await locator.isReady<SharedPreferencesService>();

  // * Core
  locator.registerLazySingleton<ThemeService>(ThemeService.new);
  locator.registerLazySingleton<DeviceInfo>(DeviceInfo.new);

  // TODO: Register your services here
}
