import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/addGoals/bloc/add_goal_bloc.dart';
import 'package:flutter_frontend/bloc/goals/goals_bloc.dart';
import 'package:flutter_frontend/bloc/auth/login/login_bloc.dart';
import 'package:flutter_frontend/bloc/auth/register/register_bloc.dart';
import 'package:flutter_frontend/bloc/goalsCategory/category_goal_bloc.dart';
import 'package:flutter_frontend/bloc/journals/journals_bloc.dart';
import 'package:flutter_frontend/data/datasource/remote_datasource.dart';
import 'package:flutter_frontend/routes.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'core/core.dart';
import 'pages/auth/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final remoteDatasource = RemoteDatasource();
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginBloc()),
          BlocProvider(create: (_) => RegisterBloc()),
          BlocProvider(create: (_) => GoalsBloc(remoteDatasource: remoteDatasource)),
          BlocProvider(create: (_) => JournalsBloc(remoteDatasource: remoteDatasource)),
          BlocProvider(create: (_) => CategoryGoalBloc(remoteDatasource: remoteDatasource)),
          BlocProvider(create: (_) => AddGoalBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: MyRoute.login.name,
          routes: routes,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          home: const SplashPage(),
        ));
  }
}
