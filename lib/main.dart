import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:spotify/Pages/ChooseMode/bloc/Them_Cubit.dart';
import 'package:spotify/Pages/Splash_pages/SplashPage.dart';
import 'package:spotify/ThemApp.dart/App_Them.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. تهيئة HydratedBloc مع مسار الحفظ الدائم
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ), // تم تعديل المسار للتخزين الدائم
  );

  // 2. تهيئة Supabase
  try {
    await Supabase.initialize(
      url: 'https://pigeydjiwezccmwukang.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBpZ2V5ZGppd2V6Y2Ntd3VrYW5nIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODYxNDU2OTAsImV4cCI6MjEwMTcyMTY5MH0.QBoZS6frhnNRp258GMDtDpGUqJ1d6_IAhn-jeqLufs0',
    );
    debugPrint('✅ Supabase initialized successfully');
  } catch (e) {
    debugPrint('❌ Supabase initialization error: $e');
  }

  runApp(const Spotify());
}

class Spotify extends StatelessWidget {
  const Spotify({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeCubit())],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: mode, // يستمع للتغيرات القادمة من ThemeCubit مباشرة
            theme: AppThem.LightThem.copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            darkTheme: AppThem.DarkThem.copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
