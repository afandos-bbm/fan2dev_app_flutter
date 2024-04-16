import 'package:flutter/widgets.dart';

enum Flavor {
  development,
  staging,
  production,
}

class Configuration {
  Configuration({
    required this.appUrl,
    required this.backUrl,
    this.sentryDsn,
  });

  final String appUrl;
  final String backUrl;
  final String? sentryDsn;
}

class ConfigurationService {
  ConfigurationService({
    required this.flavor,
  }) {
    switch (flavor) {
      case Flavor.development:
        _config = Configuration(
          backUrl: 'https://backend.alejandrofan2.dev',
          appUrl: 'http://localhost:3000',
        );
      case Flavor.staging:
        _config = Configuration(
          backUrl: 'https://backend.alejandrofan2.dev',
          appUrl: 'https://alejandrofan2.dev',
        );
      case Flavor.production:
        _config = Configuration(
          backUrl: 'https://backend.alejandrofan2.dev',
          appUrl: 'https://alejandrofan2.dev',
          sentryDsn:
              'https://b93730f66209c6d4c4384ecb37577873@o4507097049595904.ingest.de.sentry.io/4507097682280528',
        );
    }
  }

  final Flavor flavor;
  late Configuration _config;

  static ConfigurationService? _instance;

  static void initialize(Flavor flavor) {
    _instance = ConfigurationService(flavor: flavor);
  }

  static ConfigurationService get i {
    assert(_instance != null, 'ConfigurationService has not been initialized.');
    return _instance!;
  }

  Configuration get config => _config;

  String get appUrl => _config.appUrl;
  String get hadeaBackUrl => _config.backUrl;
  String? get sentryDsn => _config.sentryDsn;
  Flavor get currentFlavor => flavor;

  static ConfigurationService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
            InheritedConfigurationServiceWidget>()!
        .configService;
  }
}

class InheritedConfigurationServiceWidget extends InheritedWidget {
  const InheritedConfigurationServiceWidget({
    required this.configService,
    required super.child,
    super.key,
  });

  final ConfigurationService configService;

  @override
  bool updateShouldNotify(InheritedConfigurationServiceWidget oldWidget) {
    return configService != oldWidget.configService;
  }
}
