enum Environment {
  dev,
  stg,
  prod,
}

extension EnvironmentExt on Environment {
  String get envName {
    switch (this) {
      case Environment.dev:
        return 'LOCAL';
      case Environment.stg:
        return 'STAGING';
      case Environment.prod:
        return 'PROD';
    }
  }

  String get baseUrl {
    switch (this) {
      case Environment.dev:
        return "https://service.readdicts.com/api";
      case Environment.stg:
        return "https://service.readdicts.com/api";
      case Environment.prod:
        return "https://service.readdicts.com/api";
    }
  }
}
