import 'package:eventivo/features/Events/Data/repositories/event_repositories.dart';
import 'package:eventivo/features/Events/Data/repositories/program_repositories.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/bloc/chat_bloc.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/counter/bloc/counter_bloc.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/programs/bloc/programs_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/splash_screen.dart';
import 'package:eventivo/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:eventivo/features/chat/data/repositories/chat_repositories.dart';
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
        BlocProvider<AuthBlocBloc>(
          create: (context) => AuthBlocBloc()..add(LoadProfileImageEvent()),
        ),
        BlocProvider<EventBloc>(
          create: (context) => EventBloc(eventRepository: EventRepository())
            ..add(getEvents())
            ..add(Myevents()),
        ),
        BlocProvider<ChatBloc>(create: (context) => ChatBloc(ChatService())),
        BlocProvider<ProgramsBloc>(
          create: (context) => ProgramsBloc(programrepo: ProgramRepositories()),
        ),
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
        // BlocProvider<TicketsBloc>(
        //   create: (context) => TicketsBloc(TicketsRepositories()),
        // ),
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
