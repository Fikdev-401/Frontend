import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/addGoals/add_goal_bloc.dart';
import 'package:flutter_frontend/bloc/addJournals/bloc/add_journal_bloc.dart';
import 'package:flutter_frontend/bloc/goals/goals_bloc.dart';
import 'package:flutter_frontend/bloc/auth/login/login_bloc.dart';
import 'package:flutter_frontend/bloc/auth/register/register_bloc.dart';
import 'package:flutter_frontend/bloc/goalsCategory/category_goal_bloc.dart';
import 'package:flutter_frontend/bloc/journals/journals_bloc.dart';
import 'package:flutter_frontend/bloc/journalsCategory/category_journal_bloc.dart';
import 'package:flutter_frontend/bloc/user/user_bloc.dart';
import 'package:flutter_frontend/data/datasource/remote_datasource.dart';
import 'package:flutter_frontend/routes.dart';
import 'package:flutter_frontend/ui/pages/add_journal_pages.dart';
import 'package:flutter_frontend/ui/pages/auth/splash_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


// import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null); // Inisialisasi Bahasa Indonesia
  Intl.defaultLocale = 'id_ID';
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
          BlocProvider(
              create: (_) => GoalsBloc(remoteDatasource: remoteDatasource)),
          BlocProvider(
              create: (_) => JournalsBloc(remoteDatasource: remoteDatasource)),
          BlocProvider(
              create: (_) =>
                  CategoryGoalBloc(remoteDatasource: remoteDatasource)),
          BlocProvider(create: (_) => AddGoalBloc()),
          BlocProvider(create: (_) => AddJournalBloc(),
          child: AddJournalPage(),
          ),
          BlocProvider(
              create: (_) =>
                  CategoryJournalBloc(remoteDatasource: remoteDatasource)),
          BlocProvider(create: (_) => EditGoalBloc()),
          BlocProvider(create: (_) => EditJournalBloc()),
          BlocProvider(create: (_) => DeleteJournalBloc(remoteDatasource: remoteDatasource)),
          BlocProvider(create: (_) => DeleteGoalBloc(remoteDatasource: remoteDatasource)),
          BlocProvider(create: (_) => UserBloc()),
          
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          routes: routes,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
        ));
  }
}
