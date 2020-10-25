import 'dart:io';

import 'package:notifications/services/rss_service.dart';
import 'package:notifications/services/spotify_service.dart';
import 'package:notifications/services/telegram_service.dart';

void main(List<String> arguments) async {
  // Init podcast servicies
  final rssService = RssService();
  final spotifyService = SpotifyService();

  // Check last episode
  final lastEpisode = await rssService.getLastEpisode();
  final episode = await spotifyService.getPodcast();
  if (lastEpisode.compareTo(episode.name) != 0) {
    print('No new episode or some error :(');
    exit(0);
  }

  // Init social media services
  final telegramService = TelegramService();
  await telegramService.initBot();

  // Post in social media
  await telegramService.sendMessage(
    title: episode.name,
    url: episode.externalUrls.spotify,
  );
}
