import 'package:pop_capture/h.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      bool previous_login = Provider.of<Users>(context, listen: false).status ==
          FetchState.success;
      Navigator.of(context).pushNamedAndRemoveUntil(
        (previous_login) ? homeRoute : loginRoute,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222222),
      body: Center(
        child: Text(
          'Pop Capture',
          style: TextStyle(
              fontFamily: GoogleFonts.fasthand().fontFamily,
              fontSize: 44,
              color: playdo_red),
        ),
      ),
    );
  }
}
