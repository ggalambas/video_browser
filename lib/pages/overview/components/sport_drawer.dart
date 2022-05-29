import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_browser/config/constants.dart';
import 'package:video_browser/models/sport.dart';
import 'package:video_browser/pages/login_page.dart';
import 'package:video_browser/widgets/background.dart';

class SportDrawer extends StatelessWidget {
  final ValueChanged<Sport?> onSportSelected;
  const SportDrawer({super.key, required this.onSportSelected});

  Widget get logo => SvgPicture.asset('assets/brand/horizontal_logo.svg');

  void select(BuildContext context, Sport? sport) {
    onSportSelected(sport);
    Navigator.pop(context);
  }

  void signOut(BuildContext context) =>
      Navigator.pushReplacementNamed(context, LoginPage.route);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Background(
        child: Row(
          children: [
            Expanded(
              child: Material(
                child: ListView(
                  children: [
                    AppBar(
                      title: logo,
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(
                          onPressed: () => signOut(context),
                          icon: const Icon(Icons.logout_outlined),
                        ),
                      ],
                    ),
                    ...sports(context),
                  ],
                ),
              ),
            ),
            const VerticalDivider(width: kDividerThickness),
          ],
        ),
      ),
    );
  }

  List<Widget> sports(context) => [
        ListTile(
          visualDensity: VisualDensity.compact,
          onTap: () => select(context, null),
          title: const Text('All Sports'),
        ),
        for (final sport in Sport.values)
          ListTile(
            visualDensity: VisualDensity.compact,
            onTap: () => select(context, sport),
            title: Text('$sport'),
          ),
      ];
}
