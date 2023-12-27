import 'package:fan2dev/bootstrap.dart';
import 'package:fan2dev/core/configuration_service/configuration_service.dart';
import 'package:fan2dev/features/app/app.dart';

void main() {
  /// Initializes the configuration service with the staging flavor
  ConfigurationService.initialize(Flavor.staging);

  /// Starts the app running the bootstrap function
  bootstrap(() => const App());
}
