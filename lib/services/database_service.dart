import 'package:firedart/firedart.dart';
import 'package:notifications/config/env.dart';
import 'package:notifications/models/episode_references.dart';
import 'package:webfeed/webfeed.dart';

import 'secret_service.dart';

/// Service to manage firebase functions
class FirebaseService {
  static Firestore _firestore;
  final env = SecretService.fromJson(environment);

  Future<void> init() async {
    final firebaseAuth = FirebaseAuth(env.firebaseToken, VolatileStore());
    _firestore = Firestore('universo-flutter', auth: firebaseAuth);

    await firebaseAuth.signIn(env.firebaseUserEmail, env.firebaseUserPassword);
  }

  Future<void> addDocument(RssItem rssFeed) async {
    final data = await _parsingRssFeed(rssFeed);
    await _firestore.collection('episodes').add(data);
    print('Firebase - Added document');
  }

  Future<Map<String, dynamic>> _parsingRssFeed(RssItem rssFeed) async {
    final headers = <String>[
      'Noticias:',
      'Widget:',
      'Package:',
      'Dica:',
      'Fonte de conhecimento:',
      'Bugs e debugs:',
    ];
    var episodeReference = EpisodeReferences(references: []);

    // Get episode number
    final numberEpisode = rssFeed.itunes.episode;
    print('Number episode: ${numberEpisode}\n');
    episodeReference.episode = numberEpisode;

    // Get season number
    final numberSeason = rssFeed.itunes.season;
    print('Number season: $numberSeason\n');
    episodeReference.season = numberSeason;

    // Get references links
    final list = rssFeed.description.split('\n');
    var headerIndex = 0;
    var type = TypeReference.news;
    list.forEach((reference) {
      // Set reference id
      var referenceDetails = ReferenceDetails();

      // Set reference link
      var link = reference.splitMapJoin(
        RegExp(
          r'(?:ht|f)tps?:\/\/[-a-zA-Z0-9.]+\.[a-zA-Z]{2,3}(?:\/(?:[^"<=]|=)*)?',
          caseSensitive: false,
        ),
        onMatch: (match) => match.group(0),
        onNonMatch: (nonMatch) => '',
      );
      referenceDetails.link = link;

      // Set reference title
      var text = reference.splitMapJoin(
        RegExp(r'">(.*?)<\/', caseSensitive: false),
        onMatch: (match) =>
            match.group(0).replaceFirst('">', '').replaceAll('</', ''),
        onNonMatch: (nonMatch) => '',
      );
      referenceDetails.title = text;

      // Set reference type
      if (headerIndex < 5 && reference.startsWith(headers[headerIndex + 1])) {
        headerIndex++;
      }

      if (reference.startsWith(headers[headerIndex])) {
        type = _verifyType(headerIndex);
      }
      referenceDetails.type =
          type.toString().replaceFirst('TypeReference.', '');

      // Add reference to episode references
      if (referenceDetails.link.isNotEmpty &&
          referenceDetails.title.isNotEmpty) {
        episodeReference.references.add(referenceDetails);
      }
    });

    return episodeReference.toMap();
  }

  TypeReference _verifyType(int indexHeader) {
    switch (indexHeader) {
      case 0:
        return TypeReference.news;
        break;
      case 1:
        return TypeReference.widget;
        break;
      case 2:
        return TypeReference.package;
        break;
      case 3:
        return TypeReference.tip;
        break;
      case 4:
        return TypeReference.knowledgeSource;
        break;
      case 5:
        return TypeReference.bugDebug;
        break;
      default:
        return null;
    }
  }
}
