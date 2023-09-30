import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_app/core/constants/string_constants.dart';
import 'package:joke_app/core/constants/value_constants.dart';
import 'package:joke_app/core/database/cache_manager.dart';
import 'package:joke_app/features/joke/presentation/blocs/joke_bloc.dart';
import 'package:joke_app/features/joke/presentation/pages/home_page.dart';
import 'package:joke_app/injection_container.dart';

import 'app_bloc_observer.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await di.init();
  await CacheManager().initialise();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<JokeBloc>(
          create: (context) => sl<JokeBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(
          ValueConstants.BASE_SCREEN_WIDTH,
          ValueConstants.BASE_SCREEN_HEIGHT,
        ),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: StringConstants.JOKE,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.grey,
            ),
            home: const JokePage(
              key: Key("jokePage"),
            ),
          );
        },
      ),
    );
  }
}
