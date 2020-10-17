import 'package:notifications/services/rss_service.dart';

void main(List<String> arguments) async {
  final rssService = RssService();
  print('Podcast title: ${await rssService.getLastEpisode()}');
}
