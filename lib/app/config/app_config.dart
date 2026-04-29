import 'package:dev_metrics/app/shared/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class AppConfig {
  AppConfig._();

  static late final SupabaseClient supabase;
  static late final http.Client httpClient;

  static Future<void> init() async {
    _validateEnv();

    await Supabase.initialize(
      url: Constants.supabaseUrl,
      anonKey: Constants.supabaseAnonKey,
    );

    supabase = Supabase.instance.client;
    httpClient = http.Client();
  }

  static void _validateEnv() {
    if (Constants.supabaseUrl.isEmpty) {
      throw Exception('SUPABASE_URL not defined');
    }

    if (Constants.supabaseAnonKey.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY not defined');
    }
  }
}
