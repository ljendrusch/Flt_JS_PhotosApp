import 'package:pop_capture/h.dart';

class PopCapture extends StatelessWidget {
  const PopCapture({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWrapper(
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pop Capture',
      theme: flexThemeDark,
      initialRoute: splashRoute,
      onGenerateRoute: router,
    );
  }
}
