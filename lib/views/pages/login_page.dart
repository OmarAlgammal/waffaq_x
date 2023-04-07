import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waffaq_x/services/auth_services.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/constantsIcons.dart';
import 'package:waffaq_x/utilities/constants/texts/paths.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: padding16,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size64,
                        width: size64,
                        child: SvgPicture.asset(appLogoPath),
                      ),
                      gap16,
                      Text(
                        youWelcomeIn,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: greenColor,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gap8,
// login with facebook
                      // TODO: complete login with facebook
                      gap8,
                      ListTile(
                        tileColor: blueColor,
                        onTap: () async {
                          await authServices.signInWithFacebook();
                        },
                        leading: const Icon(
                          facebookIcon,
                          color: whiteColor,
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius: circular12,
                            side: BorderSide(
                              color: blueColor,
                            )),
                        title: const Text(
                          loginWithFacebookText,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: size18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
