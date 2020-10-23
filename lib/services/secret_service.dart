import 'package:notifications/config/env.dart';

class SecretService {
  SecretService({
    this.spotifyClientId,
    this.spotifyClientSecret,
    this.twitterApiKey,
    this.twitterSecretKey,
    this.twitterBearerToken,
    this.telegramApiKey,
  });
  final String spotifyClientId;
  final String spotifyClientSecret;
  final String twitterApiKey;
  final String twitterSecretKey;
  final String twitterBearerToken;
  final String telegramApiKey;

  static SecretService fromJson(Map<String, dynamic> json) {
    return SecretService(
      spotifyClientId: json['spotifyClientId'] as String,
      spotifyClientSecret: json['spotifyClientSecret'] as String,
      twitterApiKey: json['twitterApiKey'] as String,
      twitterSecretKey: json['twitterSecretKey'] as String,
      twitterBearerToken: json['twitterBearerToken'] as String,
      telegramApiKey: json['telegramApiKey'] as String,
    );
  }

  static SecretService _flavorService;
  static SecretService get flavorService {
    if (_flavorService != null) return _flavorService;
    _flavorService = SecretService.fromJson(environment);
    return _flavorService;
  }
}
