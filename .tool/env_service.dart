import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final config = <String, String>{
    'spotifyClientId': Platform.environment['CLIENT_ID'],
    'spotifyClientSecret': Platform.environment['CLIENT_SECRET'],
    'twitterApiKey': Platform.environment['twitterApiKey'],
    'twitterSecretKey': Platform.environment['twitterSecretKey'],
    'twitterBearerToken': Platform.environment['twitterBearerToken'],
    'telegramApiKey': Platform.environment['telegramApiKey']
  };

  final filename = 'lib/config/env.dart';
  await File(filename).writeAsString(
      'const Map<String, String> environment = <String, String>${json.encode(config)};');
}
