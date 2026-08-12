import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbumView.dart';
import 'package:spotify/Pages/AppPages/Library/CdMusic/CdMusicView.dart';
import 'package:spotify/Services/data_service.dart';

class Librarypage extends StatefulWidget {
  const Librarypage({super.key});

  @override
  State<Librarypage> createState() => _LibrarypageState();
}

class _LibrarypageState extends State<Librarypage> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkAndLoadData();
  }

  Future<void> _checkAndLoadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // ✅ إذا كانت البيانات فارغة، نحاول تحميلها
    if (DataService.cachedAlbums == null || DataService.cachedAlbums!.isEmpty) {
      debugPrint('⚠️ No cached albums, loading from API...');
      await DataService.loadAllData();
    }

    // ✅ طباعة عدد الألبومات للتحقق
    debugPrint('📦 Albums in cache: ${DataService.cachedAlbums?.length ?? 0}');

    // ✅ حتى لو فشل الـ API، الـ fallback سيضمن وجود بيانات
    if (DataService.cachedAlbums == null || DataService.cachedAlbums!.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'لا توجد ألبومات. تأكد من اتصالك بالإنترنت.';
      });
      return;
    }

    setState(() {
      _isLoading = false;
    });
  }

  List<Map<String, String>> _getAlbumsByRange(int start, int end) {
    final albums = DataService.cachedAlbums ?? [];
    if (albums.isEmpty) return [];

    final clampedStart = start.clamp(0, albums.length);
    final clampedEnd = end.clamp(0, albums.length);

    if (clampedStart >= clampedEnd) return [];

    return albums.sublist(clampedStart, clampedEnd);
  }

  @override
  Widget build(BuildContext context) {
    final allAlbums = DataService.cachedAlbums ?? [];

    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: BasicAppBar(
          hidIcons: false,
          hidarrow: true,
          Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
        ),
        body: const Center(
          child: CircularProgressIndicator(color: Color(0xFF1DB954)),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: BasicAppBar(
          hidIcons: false,
          hidarrow: true,
          Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.album, color: Colors.white54, size: 60),
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.white54, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _checkAndLoadData,
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة تحميل'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1DB954),
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (allAlbums.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: BasicAppBar(
          hidIcons: false,
          hidarrow: true,
          Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
        ),
        body: const Center(
          child: Text(
            'لا توجد ألبومات لعرضها',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: BasicAppBar(
        hidIcons: false,
        hidarrow: true,
        Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),

            _buildSection(title: 'New Albums', albums: _getAlbumsByRange(0, 4)),

            const SizedBox(height: 20),

            _buildSection(
              title: 'Popular Albums',
              albums: _getAlbumsByRange(4, 8),
            ),

            const SizedBox(height: 20),

            _buildSection(
              title: 'Editor\'s Picks',
              albums: _getAlbumsByRange(8, 12),
            ),

            const SizedBox(height: 20),

            _buildSection(title: 'Music For You', child: const Cdmusicview()),

            const SizedBox(height: 20),

            _buildSection(
              title: 'More Albums',
              albums: _getAlbumsByRange(12, 16),
            ),

            const SizedBox(height: 75),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    List<Map<String, String>>? albums,
    Widget? child,
  }) {
    if (child != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeader(title), const SizedBox(height: 8), child],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(title),
        const SizedBox(height: 8),
        if (albums != null && albums.isNotEmpty)
          Catogriesalbumview(albumsList: albums)
        else
          const SizedBox(
            height: 150,
            child: Center(
              child: Text(
                'لا توجد ألبومات',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              'See All',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1DB954),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
