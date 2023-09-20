import 'package:flutter/material.dart';
import 'package:job_task/ui/screens/login/login_screen.dart';
import 'package:job_task/ui/screens/posts/posts_screen.dart';
import 'package:job_task/ui/screens/register/register_screen.dart';

class Routes {
  static const String login = "/";
  static const String register = "/register";
  static const String posts = "/posts";
}

class RouteGenerator {
  static Route<dynamic> getRoute(
    RouteSettings routeSettings,
  ) {
    switch (routeSettings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.posts:
        return MaterialPageRoute(builder: (_) => const PostsScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('No Route Found!'),
              ),
              body: const Center(child: Text('No Route Found!')),
            ));
  }
}
