import 'package:pop_capture/h.dart';

Route<dynamic> router(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(builder: (_) => const Splash());
    case loginRoute: // '/login'
      return MaterialPageRoute(builder: (_) => const Login());
    case registerRoute: // '/register'
      return MaterialPageRoute(builder: (_) => const Register());
    case homeRoute: // '/'
      return MaterialPageRoute(
          builder: (_) => HomeScaffold(args: settings.arguments));
    case imageFeedRoute: // '/imageFeed'
      return MaterialPageRoute(
          builder: (_) => ImageFeed(args: settings.arguments));
    // case profileRoute: // '/profile'
    //   return MaterialPageRoute(builder: (_) => const Profile());
    default:
      return MaterialPageRoute(
          builder: (_) => ErrorPage(errorString: settings.name ?? '[unknown]'));
  }
}
