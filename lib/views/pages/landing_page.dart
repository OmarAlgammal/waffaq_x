
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/add_data_cubit/add_data_cubit.dart';
import 'package:waffaq_x/models/admin/admin_model.dart';
import 'package:waffaq_x/services/auth_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
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
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else{

          final user = snapshot.data;
          debugPrint('user : ${user!.email}');
          if (user == null) {
            return const LoginPage();
          }else{
            return HomePage(user: user,);
          }

        }
      },
    );
  }
}
