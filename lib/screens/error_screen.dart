import 'package:pop_capture/h.dart';

class ErrorPage extends StatelessWidget {
  final String errorString;

  const ErrorPage({super.key, required this.errorString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Page switch error on $errorString')),
    );
  }
}
