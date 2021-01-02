import 'package:dart_twitter_api/twitter_api.dart';
import 'package:notifications/services/secret_service.dart';

class TwitterService {
  final twitterApi = TwitterApi(
    client: TwitterClient(
      consumerKey: SecretService.flavorService.twitterApiKey,
      consumerSecret: SecretService.flavorService.twitterSecretKey,
      token: SecretService.flavorService.twitterToken,
      secret: SecretService.flavorService.twitterTokenSecret,
    ),
  );

  Future<void> sendTweet(String message) async {
    if (message.length > 280) {
      throw UnsupportedError('Message length with more than 280');
    }
    try {
      await twitterApi.tweetService.update(status: message);
      print('Send Telegram message');
    } catch (e) {
      print('Error to create tweet: $e');
    }
  }
}
