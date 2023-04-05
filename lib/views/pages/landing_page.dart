import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:waffaq_x/services/auth_services.dart';
import 'package:waffaq_x/views/pages/home_page.dart';
import 'package:waffaq_x/views/pages/login_page.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
    return StreamBuilder<User?>(
      stream: authServices.loginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else {
          final user = snapshot.data;
          if (user == null) {
            return const LoginPage();
          }
          return HomePage(
            user: user,
          );
        }
      },
    );
  }
}
