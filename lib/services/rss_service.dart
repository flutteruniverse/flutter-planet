import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import '../config/info_values.dart';

class RssService {
  final client = http.Client();

  /// Get name of last podcast episode
  Future<String> getLastEpisode() async {
    try {
      final response = await client.get(InfoValues.PODCAST_LINK);
      final rssFeed = RssFeed.parse(response.body);
      if (!_verifyDate(rssFeed.items.first.pubDate)) return '';
      return rssFeed.items.first.title;
    } catch (e) {
      throw UnimplementedError('Error to get RSS podcast episode: $e');
    }
  }

  /// Verify if podcast episodes release today
  bool _verifyDate(DateTime dateTime) {
    final actualDate = DateTime.now();
    return dateTime.day == actualDate.day &&
        dateTime.month == actualDate.month &&
        dateTime.year == actualDate.year;
  }
}
