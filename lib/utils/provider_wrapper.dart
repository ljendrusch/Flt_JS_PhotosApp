import 'package:pop_capture/h.dart';

class ProviderWrapper extends StatelessWidget {
  const ProviderWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => LocalSettings(), lazy: false),
        ChangeNotifierProvider(create: (context) => Users(), lazy: false),
        ChangeNotifierProvider(create: (context) => Places(), lazy: false),
        ChangeNotifierProvider(create: (context) => ImageURLs(), lazy: false),
      ],
      child: child,
    );
  }
}
