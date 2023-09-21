import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:job_task/blocs/login/login.dart';
import 'package:job_task/blocs/posts/post.dart';
import 'package:job_task/blocs/register/register.dart';
import 'package:job_task/data/remote/api_service.dart';
import 'package:job_task/data/repository/authentication_repository.dart';
import 'package:job_task/data/repository/posts_repository.dart';
import 'package:job_task/ui/screens/login/login_screen.dart';
import 'package:job_task/ui/screens/posts/posts_screen.dart';
import 'config/routes.dart';

final instance = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  instance.registerLazySingleton<ApiService>(() => ApiService());
  instance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(instance()));
  instance.registerLazySingleton<PostsRepository>(
      () => PostsRepository(instance()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) =>
              LoginBloc(instance<AuthenticationRepository>()),
        ),
        BlocProvider<RegisterBloc>(
          create: (BuildContext context) =>
              RegisterBloc(instance<AuthenticationRepository>()),
        ),
        BlocProvider<PostBloc>(
          create: (BuildContext context) =>
              PostBloc(instance<PostsRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Job Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        onGenerateRoute: RouteGenerator.getRoute,
        home: const LoginScreen(),
      ),
    );
  }
}
