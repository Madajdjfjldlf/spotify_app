import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify/Pages/AppPages/homepage/Home.dart';
import 'package:spotify/Pages/AppPages/homepage/Homepage.dart';

import 'package:spotify/Pages/ChooseMode/bloc/Them_Cubit.dart';
import 'package:spotify/Pages/Splash_pages/SplashPage.dart';

import 'package:spotify/ThemApp.dart/App_Them.dart';

void main() async {
  // 1. التأكد من ربط عناصر فلاتر بنظام التشغيل
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تهيئة التخزين المحلي الخاص بـ HydratedBloc (تم إضافتها بشكل صحيح هنا)
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  // 3. تشغيل التطبيق مرة واحدة فقط بعد إتمام التهيئة
  runApp(const Spotify());
}

class Spotify extends StatelessWidget {
  const Spotify({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeCubit())],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThem.LightThem.copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          themeMode: mode,
          darkTheme: AppThem.DarkThem.copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),

          home: const SplashPage(),
        ),
      ),
    );
  }
}
