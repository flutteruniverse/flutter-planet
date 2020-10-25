import 'package:notifications/config/env.dart';
import 'package:notifications/config/info_values.dart';
import 'package:notifications/services/secret_service.dart';
import 'package:spotify/spotify.dart';
import 'package:http/http.dart' as http;

class SpotifyService {
  final client = http.Client();
  static SpotifyApi _spotifyApi;
  Future<SpotifyApi> get spotifyApi async {
    if (_spotifyApi != null) return _spotifyApi;
    _spotifyApi = await _configCredentials();
    return _spotifyApi;
  }

  Future<SpotifyApi> _configCredentials() async {
    final enviroment = SecretService.fromJson(environment);
    final credentials = SpotifyApiCredentials(
        enviroment.spotifyClientId, enviroment.spotifyClientSecret);

    return SpotifyApi(credentials);
  }

  Future<Episode> getPodcast() async {
    final episodes = await (await spotifyApi).showEpisodes.list(
          InfoValues.SPOTIFY_ID,
          market: 'BR',
        );
    return episodes.first;
  }
}
