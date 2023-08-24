import 'package:pop_capture/h.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff222222),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Pop Capture',
                  style: TextStyle(
                      fontFamily: GoogleFonts.fasthand().fontFamily,
                      fontSize: 44,
                      color: playdo_red)),
              const SizedBox(height: 32),
              _RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          TextFieldWrapper(
            controller: _emailController,
            hintText: 'email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          TextFieldWrapper(
              controller: _pwController,
              obscureText: true,
              hintText: 'password (at least 8 characters)',
              valiFunc: (String? s) =>
                  (s != null && !s.isWhitespace() && s.length >= 8)
                      ? true
                      : false),
          const SizedBox(height: 8),
          TextFieldWrapper(
            controller: _nameController,
            hintText: 'name',
          ),
          const SizedBox(height: 8),
          TextFieldWrapper(
            controller: _zipController,
            hintText: 'zip code',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _signupFunc,
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }

  void _signupFunc() async {
    if (_registerFormKey.currentState!.validate()) {
      bool success = await _signupUser(
        email: _emailController.text,
        password: _pwController.text,
        name: _nameController.text,
        zip: _zipController.text,
      );

      if (success) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(homeRoute, (route) => false);
      }
    }
  }

  Future<bool> _signupUser({
    required String name,
    required String email,
    required String password,
    required String zip,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/signup'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'zip': zip,
        }),
        headers: header,
      );

      switch (res.statusCode ~/ 100) {
        case 2:
          showSnackBar(context,
              'Signup successful!\nPlease log in with the same credentials');
          return true;
        case 4:
          showSnackBar(context, jsonDecode(res.body)['msg']);
          return false;
        case 5:
          showSnackBar(context, jsonDecode(res.body)['error']);
          return false;
        default:
          showSnackBar(context, res.body);
          return false;
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }
}
