import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_browser/config/constants.dart';
import 'package:video_browser/pages/overview/overview_page.dart';
import 'package:video_browser/widgets/background.dart';
import 'package:video_browser/widgets/tap_to.dart';

class LoginPage extends StatefulWidget {
  static String route = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordObscured = true;

  Widget get logo => SvgPicture.asset('assets/brand/vertical_logo.svg');
  double get screenHeight {
    final media = MediaQuery.of(context);
    return media.size.height - media.padding.top;
  }

  void signIn() => Navigator.pushReplacementNamed(context, OverviewPage.route);

  @override
  Widget build(BuildContext context) {
    return TapTo.unfocus(
      child: Background(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: screenHeight,
                child: Column(
                  children: [
                    Expanded(flex: 3, child: Center(child: logo)),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          const Divider(),
                          emailField,
                          const Divider(),
                          passwordField,
                          const Divider(),
                          const Spacer(),
                          signInButton,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField get emailField => const TextField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: 'Email'),
      );

  TextField get passwordField => TextField(
        obscureText: isPasswordObscured,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: 'Password',
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: kInputPadding),
            child: IconButton(
              onPressed: () => setState(
                () => isPasswordObscured = !isPasswordObscured,
              ),
              iconSize: kSmallIconSize,
              icon: Icon(
                isPasswordObscured
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
        ),
      );

  ElevatedButton get signInButton => ElevatedButton(
        onPressed: signIn,
        child: const Text('Sign in'),
      );
}
