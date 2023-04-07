import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/add_comp_cubit/add_comp_cubit.dart';
import 'package:waffaq_x/controllers/add_data_cubit/add_data_cubit.dart';
import 'package:waffaq_x/controllers/all_mobiles_bloc/all_mobiles_bloc.dart';
import 'package:waffaq_x/controllers/all_mobiles_bloc/all_mobiles_event.dart';
import 'package:waffaq_x/controllers/brand_mobiles_bloc/brand_mobiles_bloc.dart';
import 'package:waffaq_x/controllers/cover_comp_bloc/cover_comp_bloc.dart';
import 'package:waffaq_x/controllers/delete_data_cubit/delete_data_cubit.dart';
import 'package:waffaq_x/controllers/glass_comp_bloc/glass_comp_bloc.dart';
import 'package:waffaq_x/controllers/screen_comp_bloc/screen_comp_bloc.dart';
import 'package:waffaq_x/firebase_options.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/routing/routers.dart';
import 'package:waffaq_x/utilities/routing/routes.dart';

import 'utilities/constants/constantsDimens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseFirestore.instance.clearPersistence();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AllMobilesBloc()..add(LoadAllMobiles()),
        ),
        BlocProvider(
          create: (_) => BrandMobilesBloc(),
        ),
        BlocProvider(
          create: (_) => ScreenCompBloc(),
        ),
        BlocProvider(
          create: (_) => CoverCompBloc(),
        ),
        BlocProvider(
          create: (_) => GlassCompBloc(),
        ),
        BlocProvider(
          create: (_) => AddCompCubit(),
        ),
        BlocProvider(
          create: (_) => AddDataCubit(),
        ),
        BlocProvider(
          create: (_) => DeleteDataCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.landingPage,
        onGenerateRoute: onGenerate,
        theme: ThemeData(
          primarySwatch: myCustomPrimaryColor,
          scaffoldBackgroundColor: whiteColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: whiteColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: whiteColor,
              statusBarIconBrightness: Brightness.dark,
            ),
            iconTheme: IconThemeData(
              color: blackColor,
            ),
            titleTextStyle: TextStyle(
              color: blackColor,
              fontSize: size24,
            ),
            elevation: size0,
            toolbarHeight: size120,
          ),
        ),
      ),
    );
  }
}
