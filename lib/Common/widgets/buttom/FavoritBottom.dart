import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteIcon extends StatefulWidget {
  final int songId;

  const FavoriteIcon({super.key, required this.songId});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isFav = false;
  bool isLoading = true;
  double scal = 1.0;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  // ───── التحقق مما إذا كانت الأغنية مفضلة ─────
  Future<void> _checkFavorite() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final result = await supabase
          .from('favorites')
          .select('id')
          .eq('user_id', user.id)
          .eq('song_id', widget.songId)
          .maybeSingle();

      setState(() {
        isFav = result != null;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('❌ Check favorite error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // ───── إضافة أو حذف من المفضلة ─────
  Future<void> _toggleFavorite() async {
    if (isLoading) return;

    final user = supabase.auth.currentUser;

    if (user == null) {
      debugPrint('⚠️ User not logged in');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى تسجيل الدخول لإضافة المفضلة'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // تأثير الضغط
    setState(() {
      scal = 0.8;
    });

    await Future.delayed(const Duration(milliseconds: 120));

    try {
      if (isFav) {
        // ❌ حذف من المفضلة
        await supabase
            .from('favorites')
            .delete()
            .eq('user_id', user.id)
            .eq('song_id', widget.songId);

        setState(() {
          isFav = false;
          scal = 1.2;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تمت إزالة الأغنية من المفضلة'),
            backgroundColor: Colors.grey,
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        // ✅ إضافة إلى المفضلة
        await supabase.from('favorites').insert({
          'user_id': user.id,
          'song_id': widget.songId,
        });

        setState(() {
          isFav = true;
          scal = 1.2;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ تمت إضافة الأغنية إلى المفضلة'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Favorite error: $e');
      setState(() {
        scal = 1.0;
      });
    }

    await Future.delayed(const Duration(milliseconds: 120));

    setState(() {
      scal = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        width: 26,
        height: 26,
        child: Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: _toggleFavorite,
      child: AnimatedScale(
        scale: scal,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: isFav ? 1.0 : 0.0),
          duration: const Duration(milliseconds: 250),
          builder: (context, value, child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color.lerp(Appcolor.Grey, Appcolor.Primary, value)!,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                'Assest/Vectors/Favorit.svg',
                width: 26,
                height: 26,
              ),
            );
          },
        ),
      ),
    );
  }
}
