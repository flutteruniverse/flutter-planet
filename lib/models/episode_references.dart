import 'dart:convert';

class EpisodeReferences {
  int episode;
  int season;
  List<ReferenceDetails> references;

  EpisodeReferences({
    this.episode,
    this.season,
    this.references,
  });

  Map<String, dynamic> toMap() {
    return {
      'episode': episode,
      'season': season,
      'references': references?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory EpisodeReferences.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return EpisodeReferences(
      episode: map['episode'],
      season: map['season'],
      references: List<ReferenceDetails>.from(
          map['references']?.map((x) => ReferenceDetails.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpisodeReferences.fromJson(String source) =>
      EpisodeReferences.fromMap(json.decode(source));
}

class ReferenceDetails {
  String link;
  String type;
  String title;

  ReferenceDetails({
    this.link,
    this.type,
    this.title,
  });

  Map<String, String> toMap() {
    return {
      'link': link,
      'type': type,
      'title': title,
    };
  }

  factory ReferenceDetails.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReferenceDetails(
      link: map['link'],
      type: map['type'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferenceDetails.fromJson(String source) =>
      ReferenceDetails.fromMap(json.decode(source));
}

enum TypeReference {
  news,
  widget,
  package,
  tip,
  knowledgeSource,
  bugDebug,
  job,
  app,
}
