import 'package:spotify/Services/track_model.dart';

class HomeService {
  Future<List<TrackModel>> getChartTracks() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final List<Map<String, dynamic>> mockData = [
      {
        'id': 1,
        'title': 'As It Was',
        'artist': 'Harry Styles',
        'cover':
            'https://i.scdn.co/image/ab67616d0000b273b452ba64c76b94877f8f609a',
      },
      {
        'id': 2,
        'title': 'Flowers',
        'artist': 'Miley Cyrus',
        'cover':
            'https://i.scdn.co/image/ab67616d0000b273f01931a7f457618ceee9598f',
      },
      {
        'id': 3,
        'title': 'Anti-Hero',
        'artist': 'Taylor Swift',
        'cover':
            'https://i.scdn.co/image/ab67616d0000b273bb54bbe3cc1fb4be9bac3fc1',
      },
      {
        'id': 4,
        'title': 'Levitating',
        'artist': 'Dua Lipa',
        'cover':
            'https://i.scdn.co/image/ab67616d0000b273bd26b5f96396f6424e0f2f35',
      },
    ];

    return mockData
        .map(
          (item) => TrackModel(
            id: item['id'],
            title: item['title']!,
            artistName: item['artist']!,
            coverImage: item['cover']!,
            preview: '',
          ),
        )
        .toList();
  }
}
