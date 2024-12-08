import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kanban/firebase_options.dart';
import 'package:kanban/global/bloc/app_bloc.dart';
import 'package:kanban/global/bloc/app_state.dart';
import 'package:kanban/locator.dart';
import 'package:kanban/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AppBloc>(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'Kanban App',
            theme: state.themeData,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('de'), // Germany
            ],
          );
        },
      ),
    );
  }
}
