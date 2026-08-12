class JamendoTrack {
  final String id;
  final String name;
  final String? artistName;
  final String? artistId;
  final String? albumName;
  final String? albumId;
  final String? image;
  final String? audio;
  final int? duration;

  JamendoTrack({
    required this.id,
    required this.name,
    this.artistName,
    this.artistId,
    this.albumName,
    this.albumId,
    this.image,
    this.audio,
    this.duration,
  });

  factory JamendoTrack.fromJson(Map<String, dynamic> json) {
    return JamendoTrack(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      artistName: json['artist_name'],
      artistId: json['artist_id']?.toString(),
      albumName: json['album_name'],
      albumId: json['album_id']?.toString(),
      image: json['image'],
      audio: json['audio'],
      duration: json['duration'],
    );
  }
}

class JamendoArtist {
  final String id;
  final String name;
  final String? image;
  final String? website;

  JamendoArtist({
    required this.id,
    required this.name,
    this.image,
    this.website,
  });

  factory JamendoArtist.fromJson(Map<String, dynamic> json) {
    return JamendoArtist(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      image: json['image'],
      website: json['website'],
    );
  }
}

class JamendoAlbum {
  final String id;
  final String name;
  final String? artistName;
  final String? artistId;
  final String? image;
  final String? releaseDate;

  JamendoAlbum({
    required this.id,
    required this.name,
    this.artistName,
    this.artistId,
    this.image,
    this.releaseDate,
  });

  factory JamendoAlbum.fromJson(Map<String, dynamic> json) {
    return JamendoAlbum(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      artistName: json['artist_name'],
      artistId: json['artist_id']?.toString(),
      image: json['image'],
      releaseDate: json['releasedate'],
    );
  }
}
