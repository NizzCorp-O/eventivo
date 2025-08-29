import 'package:eventivo/features/Events/Data/repositories/Event_repositories.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/admin_home_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/splash_screen.dart';
import 'package:eventivo/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:eventivo/features/auth/presentation/pages/login_screen.dart';
import 'package:eventivo/features/auth/presentation/pages/register_screen.dart';

import 'package:eventivo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlocBloc>(create: (context) => AuthBlocBloc()),
        BlocProvider<EventBloc>(
          create: (context) => EventBloc(eventRepository: EventRepository()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
