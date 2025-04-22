class AppConfig {
  final String appName;
  final bool enableMap;
  final bool enableTracking;
  final String apiBaseUrl;
  final String flavor;

  const AppConfig({
    required this.appName,
    required this.enableMap,
    required this.enableTracking,
    required this.apiBaseUrl,
    required this.flavor,
  });
}
