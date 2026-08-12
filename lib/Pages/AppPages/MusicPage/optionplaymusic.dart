import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/AlbumsGridView.dart';
import 'package:spotify/Pages/AppPages/MusicPage/ArtistSOngList.dart';
import 'package:spotify/Pages/AppPages/MusicPage/optionplaymusic.dart';
import 'package:spotify/ThemApp.dart/App_COlor.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbumView.dart'
    hide Catogriesalbumview;
import 'package:just_audio/just_audio.dart';

class Nowplayingpage extends StatefulWidget {
  final String? title;
  final String? artist;
  final String? imageUrl;
  final String? previewUrl;

  const Nowplayingpage({
    super.key,
    this.title,
    this.artist,
    this.imageUrl,
    this.previewUrl,
  });

  @override
  State<Nowplayingpage> createState() => _NowplayingpageState();
}

class _NowplayingpageState extends State<Nowplayingpage> {
  AudioPlayer? _audioPlayer;
  bool isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool isLooping = false;
  bool isShuffled = false;
  List<Map<String, String>> albums = [];
  String? _errorMessage;
  bool _isAudioInitialized = false;

  List<Map<String, String>> currentPlaylist = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    try {
      _audioPlayer = AudioPlayer();

      _audioPlayer!.positionStream.listen((p) {
        if (mounted) setState(() => _position = p);
      });

      _audioPlayer!.durationStream.listen((d) {
        if (d != null && mounted) setState(() => _duration = d);
      });

      _audioPlayer!.playerStateStream.listen((state) {
        if (mounted) {
          final playing = state.playing;
          if (state.processingState == ProcessingState.completed &&
              !isLooping) {
            _playNext();
          }
          setState(() {
            isPlaying = playing;
          });
        }
      });

      await _playCurrentSong();
    } catch (e) {
      setState(() {
        _errorMessage = 'فشل تهيئة مشغل الصوت: $e';
      });
      debugPrint('Audio init error: $e');
    }
  }

  Future<void> _playCurrentSong() async {
    if (_audioPlayer == null) return;

    final url = widget.previewUrl;
    if (url == null || url.isEmpty) {
      setState(() {
        _errorMessage = '⚠️ لا توجد معاينة لهذه الأغنية';
        _isAudioInitialized = false;
      });
      return;
    }

    try {
      await _audioPlayer!.setUrl(url);
      await _audioPlayer!.play();

      if (mounted) {
        setState(() {
          isPlaying = true;
          _isAudioInitialized = true;
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '⚠️ حدث خطأ أثناء التشغيل';
        _isAudioInitialized = false;
      });
      debugPrint('Play error: $e');
    }
  }

  // ✅ زر التشغيل/الإيقاف المؤقت (بدون Stop)
  void _togglePlayPause() {
    if (_audioPlayer == null || !_isAudioInitialized) {
      setState(() {
        _errorMessage = '⚠️ الصوت غير جاهز للتشغيل';
      });
      return;
    }

    try {
      if (isPlaying) {
        _audioPlayer!.pause();
      } else {
        // إذا كان الصوت متوقفاً عند البداية أو متوقفاً مؤقتاً، استأنف
        _audioPlayer!.play();
      }
      // الحالة ستُحدث تلقائياً من خلال playerStateStream
    } catch (e) {
      setState(() {
        _errorMessage = '⚠️ خطأ في التحكم بالصوت';
      });
    }
  }

  void _playNext() {
    if (currentPlaylist.isNotEmpty &&
        currentIndex < currentPlaylist.length - 1) {
      currentIndex++;
      _playSong(currentPlaylist[currentIndex]['preview'] ?? '');
    }
  }

  void _playPrevious() {
    if (currentPlaylist.isNotEmpty && currentIndex > 0) {
      currentIndex--;
      _playSong(currentPlaylist[currentIndex]['preview'] ?? '');
    }
  }

  Future<void> _playSong(String url) async {
    if (_audioPlayer == null || url.isEmpty) return;

    try {
      await _audioPlayer!.stop();
      await _audioPlayer!.setUrl(url);
      await _audioPlayer!.play();
      if (mounted) {
        setState(() {
          isPlaying = true;
          _position = Duration.zero;
          _errorMessage = null;
          _isAudioInitialized = true;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '⚠️ فشل تشغيل الأغنية';
        _isAudioInitialized = false;
      });
      debugPrint('Play song error: $e');
    }
  }

  void _toggleLoop() => setState(() => isLooping = !isLooping);
  void _toggleShuffle() => setState(() => isShuffled = !isShuffled);

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  void _onSongsLoaded(List<Map<String, String>> songs) {
    currentPlaylist = songs;
    final Map<String, Map<String, String>> albumMap = {};
    for (var song in songs) {
      final albumTitle = song['albumTitle'] ?? '';
      final albumImage = song['albumImage'] ?? '';
      if (albumTitle.isNotEmpty && albumImage.isNotEmpty) {
        if (!albumMap.containsKey(albumTitle)) {
          albumMap[albumTitle] = {
            'photo': albumImage,
            'Title': albumTitle,
            'Subtitle': widget.artist ?? 'فنان',
          };
        }
      }
    }
    setState(() => albums = albumMap.values.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        Title: const Text(
          'Now playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 0),
              _songPhoto(context, imageUrl: widget.imageUrl),
              Transform.translate(
                offset: const Offset(0, -0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _textSong(title: widget.title, artist: widget.artist),
                    const SizedBox(height: 20),
                    if (_errorMessage != null)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 10),
                    _songPlayerBar(
                      position: _position,
                      duration: _duration,
                      onChanged: (value) {
                        if (_isAudioInitialized && _audioPlayer != null) {
                          _audioPlayer!.seek(Duration(seconds: value.toInt()));
                        }
                      },
                      isEnabled: _isAudioInitialized,
                    ),
                    const SizedBox(height: 25),
                    _optionSong(
                      context,
                      isPlaying: isPlaying,
                      onPlayPause: _togglePlayPause,
                      onNext: _playNext,
                      onPrevious: _playPrevious,
                      onLoop: _toggleLoop,
                      onShuffle: _toggleShuffle,
                      isLooping: isLooping,
                      isShuffled: isShuffled,
                      hasError: _errorMessage != null || !_isAudioInitialized,
                    ),
                    const SizedBox(height: 10),
                    _songsetting(context),
                    const SizedBox(height: 20),
                    _OfMusical(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Songs by ${widget.artist ?? 'Artist'}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ArtistSongsList(
                      artistName: widget.artist ?? '',
                      onSongsLoaded: _onSongsLoaded,
                    ),
                    const SizedBox(height: 20),
                    if (albums.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Albums',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Catogriesalbumview(albumsList: albums),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ========== دوال مساعدة ==========

Widget _songPhoto(BuildContext context, {String? imageUrl}) {
  return Container(
    height: 450,
    width: 370,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      image: DecorationImage(
        image: (imageUrl != null && imageUrl.isNotEmpty)
            ? NetworkImage(imageUrl)
            : const AssetImage('Assest/Images/NowPlaying.png') as ImageProvider,
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget _textSong({String? title, String? artist}) {
  return Padding(
    padding: const EdgeInsets.only(right: 30, left: 30),
    child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? 'Bad Guy',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                artist ?? 'Billie Eilish',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/Heart.svg',
            height: 26,
            width: 26,
          ),
        ),
      ],
    ),
  );
}

Widget _songPlayerBar({
  required Duration position,
  required Duration duration,
  required ValueChanged<double> onChanged,
  required bool isEnabled,
}) {
  final maxValue = duration.inSeconds.toDouble() > 0
      ? duration.inSeconds.toDouble()
      : 1.0;

  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20),
    child: Column(
      children: [
        Slider(
          value: position.inSeconds.toDouble().clamp(0, maxValue),
          min: 0.0,
          max: maxValue,
          activeColor: isEnabled ? Colors.black : Colors.grey,
          inactiveColor: Colors.grey.shade300,
          onChanged: isEnabled ? onChanged : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(position),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                _formatDuration(duration),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _formatDuration(Duration d) {
  final minutes = d.inMinutes.remainder(60);
  final seconds = d.inSeconds.remainder(60);
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

Widget _optionSong(
  BuildContext context, {
  required bool isPlaying,
  required VoidCallback onPlayPause,
  required VoidCallback onNext,
  required VoidCallback onPrevious,
  required VoidCallback onLoop,
  required VoidCallback onShuffle,
  required bool isLooping,
  required bool isShuffled,
  required bool hasError,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: hasError ? null : onLoop,
          icon: SvgPicture.asset(
            isLooping
                ? 'Assest/Vectors/LoopActive.svg'
                : 'Assest/Vectors/Spam.svg',
            height: 20,
            width: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
        IconButton(
          onPressed: hasError ? null : onPrevious,
          icon: SvgPicture.asset(
            'Assest/Vectors/Previous.svg',
            height: 20,
            width: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
        // ✅ زر التشغيل/الإيقاف المؤقت (بدون Stop)
        GestureDetector(
          onTap: hasError ? null : onPlayPause,
          child: Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: hasError ? Colors.grey : Appcolor.Primary,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: SvgPicture.asset(
                isPlaying
                    ? 'Assest/Vectors/Pause.svg'
                    : 'Assest/Vectors/Play.svg',
                height: 30,
                width: 30,
                fit: BoxFit.none,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: hasError ? null : onNext,
          icon: SvgPicture.asset(
            'Assest/Vectors/Next.svg',
            height: 20,
            width: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
        IconButton(
          onPressed: hasError ? null : onShuffle,
          icon: SvgPicture.asset(
            isShuffled
                ? 'Assest/Vectors/ShuffleActive.svg'
                : 'Assest/Vectors/Shuffle 2.svg',
            height: 20,
            width: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
      ],
    ),
  );
}

Widget _songsetting(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'Assest/Vectors/Dvecies.png',
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
            height: 20,
            width: 20,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/playListIcon.svg',
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
        const SizedBox(width: 2),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/Share.svg',
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
      ],
    ),
  );
}

Widget _OfMusical() {
  return Align(
    alignment: Alignment.center,
    child: Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis adipiscing vestibulum orci enim, nascetur vitae ',
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
  );
}
