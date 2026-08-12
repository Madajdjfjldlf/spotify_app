class DeezerTrack {
  final int id;
  final String title;
  final String titleShort;
  final int duration;
  final int rank;
  final String preview;
  final String? artistName;
  final String? artistPicture;
  final String? albumTitle;
  final String? albumCover;
  final String? albumCoverBig;

  DeezerTrack({
    required this.id,
    required this.title,
    required this.titleShort,
    required this.duration,
    required this.rank,
    required this.preview,
    this.artistName,
    this.artistPicture,
    this.albumTitle,
    this.albumCover,
    this.albumCoverBig,
  });

  factory DeezerTrack.fromJson(Map<String, dynamic> json) {
    final artist = json['artist'] as Map<String, dynamic>?;
    final album = json['album'] as Map<String, dynamic>?;
    return DeezerTrack(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleShort: json['title_short'] ?? '',
      duration: json['duration'] ?? 0,
      rank: json['rank'] ?? 0,
      preview: json['preview'] ?? '',
      artistName: artist?['name'],
      artistPicture: artist?['picture_medium'],
      albumTitle: album?['title'],
      albumCover: album?['cover_medium'],
      albumCoverBig: album?['cover_big'],
    );
  }
}

class DeezerArtist {
  final int id;
  final String name;
  final String? picture;
  final String? pictureBig;
  final int? nbFan;

  DeezerArtist({
    required this.id,
    required this.name,
    this.picture,
    this.pictureBig,
    this.nbFan,
  });

  factory DeezerArtist.fromJson(Map<String, dynamic> json) {
    return DeezerArtist(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      picture: json['picture_medium'],
      pictureBig: json['picture_big'],
      nbFan: json['nb_fan'],
    );
  }
}

class DeezerAlbum {
  final int id;
  final String title;
  final String? cover;
  final String? coverBig;
  final String? artistName;
  final int? nbTracks;

  DeezerAlbum({
    required this.id,
    required this.title,
    this.cover,
    this.coverBig,
    this.artistName,
    this.nbTracks,
  });

  factory DeezerAlbum.fromJson(Map<String, dynamic> json) {
    final artist = json['artist'] as Map<String, dynamic>?;
    return DeezerAlbum(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      cover: json['cover_medium'],
      coverBig: json['cover_big'],
      artistName: artist?['name'],
      nbTracks: json['nb_tracks'],
    );
  }
}
