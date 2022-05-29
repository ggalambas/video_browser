import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_browser/models/sport.dart';
import 'package:video_browser/models/video.dart';
import 'package:video_browser/pages/overview/components/sport_drawer.dart';
import 'package:video_browser/video_manager.dart';
import 'package:video_browser/widgets/background.dart';
import 'package:video_browser/widgets/video_tile.dart';

class OverviewPage extends StatefulWidget {
  static String route = '/overview';

  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage>
    with SingleTickerProviderStateMixin {
  Sport? sport;

  Widget get logo => SvgPicture.asset('assets/brand/logo.svg');
  List<Video> get videos => VideoManager.videosOf(sport);

  void selectSport(Sport? sport) => setState(() => this.sport = sport);
  bool shouldPlay(double dTop, double dBottom, double screenHeight) =>
      dTop < 0.5 * screenHeight && dBottom > 0.5 * screenHeight;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: sport == null ? logo : Text('$sport'),
          actions: [
            IconButton(
              onPressed: () {}, // TODO Search
              icon: const Icon(Icons.search_outlined),
            ),
          ],
        ),
        drawer: SportDrawer(onSportSelected: selectSport),
        body: InViewNotifierList(
          isInViewPortCondition: shouldPlay,
          itemCount: videos.length,
          builder: videoTilesBuilder,
        ),
      ),
    );
  }

  Widget videoTilesBuilder(BuildContext _, int i) => InViewNotifierWidget(
        id: '$i',
        builder: (_, isInView, __) => VideoTile(videos[i], autoPlay: isInView),
      );
}
