import 'package:dev_metrics/app/shared/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class AppConfig {
  AppConfig._();
  static late final http.Client httpClient;
  static late final SupabaseClient supabase;

  static String get baseUrl => _getBaseUrl();

  static Future<void> init() async {
    await Supabase.initialize(
      url: Constants.supabaseUrl,
      anonKey: Constants.supabaseAnonKey,
    );
    supabase = Supabase.instance.client;

    httpClient = http.Client();
  }

  static String _getBaseUrl() {
    return Constants.apiBaseUrl;
  }
}
