import 'package:notifications/services/rss_service.dart';
import 'package:test/test.dart';

void main() {
  group('Rss service -', () {
    test('Get last episode if is wednesday', () async {
      final rssService = RssService();
      final episode = await rssService.getLastEpisode();

      expect(episode, isNotNull);
      if (episode.title.isNotEmpty) {
        expect(episode.title, contains('| #'));
        expect(episode.pubDate.weekday, DateTime.wednesday);
        expect(episode.dc.creator, 'Matias de Andrea');
      }
    });
  });
}
