import 'package:fan2dev/bootstrap.dart';
import 'package:fan2dev/core/configuration_service/configuration_service.dart';
import 'package:fan2dev/features/app/mate_app.dart';

void main() {
  /// Initializes the configuration service with the development flavor
  ConfigurationService.initialize(Flavor.development);

  /// Starts the app running the bootstrap function
  bootstrap(() => const MateApp());
}
