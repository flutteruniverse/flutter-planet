import 'dart:io';

import 'package:notifications/config/info_values.dart';
import 'package:notifications/services/database_service.dart';
import 'package:notifications/services/rss_service.dart';
import 'package:notifications/services/spotify_service.dart';
import 'package:notifications/services/telegram_service.dart';
import 'package:notifications/services/twitter_service.dart';

void main(List<String> arguments) async {
  // Init podcast servicies
  final rssService = RssService();
  final spotifyService = SpotifyService();

  // Check last episode
  final lastEpisode = await rssService.getLastEpisode();
  final episode = await spotifyService.getPodcast();
  if (lastEpisode.title != null &&
      lastEpisode.title.compareTo(episode.name) != 0) {
    print('No new episode');
    exit(0);
  }

  // Init social media and database services
  final firebaseService = FirebaseService();
  final telegramService = TelegramService();
  final twitterService = TwitterService();
  await telegramService.initBot();
  await firebaseService.init();

  // Persist links
  await firebaseService.addDocument(lastEpisode);

  // Post in social media
  final message =
      '${InfoValues.TELEGRAM_INIT_MESSAGE}${episode.name}\n${InfoValues.TELEGRAM_MID_MESSAGE}${episode.externalUrls.spotify}';
  await telegramService.sendMessage(message);
  await twitterService.sendTweet(message);

  exit(0);
}
