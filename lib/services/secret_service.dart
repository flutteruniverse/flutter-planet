import 'package:notifications/config/env.dart';

class SecretService {
  SecretService({
    this.spotifyClientId,
    this.spotifyClientSecret,
    this.twitterApiKey,
    this.twitterSecretKey,
    this.twitterToken,
    this.twitterTokenSecret,
    this.telegramApiKey,
    this.firebaseToken,
    this.firebaseUserEmail,
    this.firebaseUserPassword,
  });
  final String spotifyClientId;
  final String spotifyClientSecret;
  final String twitterApiKey;
  final String twitterSecretKey;
  final String twitterToken;
  final String twitterTokenSecret;
  final String telegramApiKey;
  final String firebaseToken;
  final String firebaseUserEmail;
  final String firebaseUserPassword;

  static SecretService fromJson(Map<String, dynamic> json) {
    return SecretService(
      spotifyClientId: json['spotifyClientId'] as String,
      spotifyClientSecret: json['spotifyClientSecret'] as String,
      twitterApiKey: json['twitterApiKey'] as String,
      twitterSecretKey: json['twitterSecretKey'] as String,
      twitterToken: json['twitterToken'] as String,
      twitterTokenSecret: json['twitterTokenSecret'] as String,
      telegramApiKey: json['telegramApiKey'] as String,
      firebaseToken: json['firebaseToken'] as String,
      firebaseUserEmail: json['firebaseUserEmail'] as String,
      firebaseUserPassword: json['firebaseUserPassword'] as String,
    );
  }

  static SecretService _flavorService;
  static SecretService get flavorService {
    if (_flavorService != null) return _flavorService;
    _flavorService = SecretService.fromJson(environment);
    return _flavorService;
  }
}
