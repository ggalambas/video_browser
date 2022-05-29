import 'package:flutter/material.dart';
import 'package:video_browser/config/theme.dart';
import 'package:video_browser/pages/login_page.dart';
import 'package:video_browser/pages/overview/overview_page.dart';
import 'package:video_browser/pages/video/video_page.dart';
import 'package:video_browser/video_manager.dart';

void main() async {
  VideoManager.generateVideos();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Browser',
      theme: theme,
      routes: {
        LoginPage.route: (_) => const LoginPage(),
        OverviewPage.route: (_) => const OverviewPage(),
        VideoPage.route: (_) => const VideoPage(),
      },
      initialRoute: LoginPage.route,
    );
  }
}
