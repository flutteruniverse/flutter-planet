import 'dart:math';

import 'package:notifications/services/rss_service.dart';
import 'package:test/test.dart';

void main() {
  group('Rss service -', () {
    test('Test ', () async {
      final rssService = RssService();
      final episode = await rssService.getLastEpisode();

      expect(episode, isNotNull);
      if (episode.isNotEmpty) {
        expect(episode, contains('| #'));
      }
    });
  });
}
