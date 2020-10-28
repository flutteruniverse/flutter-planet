import 'package:notifications/services/secret_service.dart';
import 'package:test/test.dart';

void main() {
  group('Env -', () {
    test('Verify keys', () {
      final secretService = SecretService.flavorService;

      expect(secretService.spotifyClientId, isNotNull);
      expect(secretService.spotifyClientSecret, isNotNull);
      expect(secretService.telegramApiKey, isNotNull);
      expect(secretService.twitterApiKey, isNotNull);
      expect(secretService.twitterSecretKey, isNotNull);
      expect(secretService.twitterToken, isNotNull);
      expect(secretService.twitterTokenSecret, isNotNull);

      expect(secretService.telegramApiKey, isNotEmpty);
      expect(secretService.twitterApiKey, isNotEmpty);
      expect(secretService.twitterSecretKey, isNotEmpty);
      expect(secretService.twitterToken, isNotEmpty);
      expect(secretService.twitterTokenSecret, isNotEmpty);
      expect(secretService.spotifyClientId.length, 32);
      expect(secretService.spotifyClientSecret.length, 32);
    });
  });
}
