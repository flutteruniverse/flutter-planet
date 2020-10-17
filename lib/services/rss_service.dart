import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class RssService {
  final client = http.Client();

  Future<String> getLastEpisode() async {
    final response =
        await client.get('https://anchor.fm/s/127cd640/podcast/rss');
    final rssFeed = RssFeed.parse(response.body);
    if (!_verifyDate(rssFeed.items.first.pubDate)) return '';
    return rssFeed.items.first.title;
  }

  bool _verifyDate(DateTime dateTime) {
    final actualDate = DateTime.now();
    return dateTime.day == actualDate.day &&
        dateTime.month == actualDate.month &&
        dateTime.year == actualDate.year;
  }
}
