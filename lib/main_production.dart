import 'package:fan2dev/bootstrap.dart';
import 'package:fan2dev/core/configuration_service/configuration_service.dart';
import 'package:fan2dev/features/app/mate_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  /// Initializes the configuration service with the production flavor
  ConfigurationService.initialize(Flavor.production);

  SentryFlutter.init(
    (options) {
      options.dsn = ConfigurationService.i.sentryDsn;
      options.environment = ConfigurationService.i.flavor.name;
      options.enableMetrics = true;
      options.autoAppStart = true;
    },
    appRunner: () => bootstrap(() => const MateApp()),
  );
}
