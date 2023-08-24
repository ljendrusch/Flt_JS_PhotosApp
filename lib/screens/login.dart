import 'package:pop_capture/h.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
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
              _LoginForm(),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Need an account?'),
                  const SizedBox(width: 8),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(registerRoute),
                      child: Text('Register')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
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
          const SizedBox(height: 22),
          ElevatedButton(onPressed: _loginFunc, child: Text('Log In')),
        ],
      ),
    );
  }

  void _loginFunc() async {
    if (_loginFormKey.currentState!.validate()) {
      bool success = await _loginUser(
        email: _emailController.text,
        password: _pwController.text,
      );

      if (success) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(homeRoute, (route) => false);
      }
    }
  }

  Future<bool> _loginUser({
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: header,
      );

      switch (res.statusCode ~/ 100) {
        case 2:
          showSnackBar(context, 'Login successful');
          Provider.of<Users>(context, listen: false)
              .setUser(User.fromJson(res.body));
          Provider.of<LocalSettings>(context, listen: false)
              .setToken(jsonDecode(res.body)['token']);
          Provider.of<Places>(context, listen: false).fetchPlaces();
          Provider.of<ImageURLs>(context, listen: false).fetchImageUrls();
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

// class _LoginForm extends StatefulWidget {
//   const _LoginForm();

//   @override
//   _LoginFormState createState() => _LoginFormState();
// }

// class _LoginFormState extends State<_LoginForm> {
//   final _loginFormKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _pwController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _pwController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _loginFormKey,
//       child: Column(
//         children: [
//           TextFieldWrapper(
//             controller: _emailController,
//             hintText: 'email',
//           ),
//           const SizedBox(height: 8),
//           TextFieldWrapper(
//               controller: _pwController,
//               hintText: 'password (at least 8 characters)',
//               valiFunc: (String? s) {
//                 print('pw validating ${_pwController.text}');
//                 return (s != null && !s.isWhitespace() && s.length >= 8)
//                     ? true
//                     : false;
//               }),
//           const SizedBox(height: 8),
//           ButtonWrapper(
//               splashColor: Theme.of(context).splashColor,
//               onPressed: _onPressed,
//               child: Text('Login')),
//           const SizedBox(height: 8),
//           _SignupDialog(email: _emailController.text, pw: _pwController.text),
//         ],
//       ),
//     );
//   }

//   void _onPressed() async {
//     if (_loginFormKey.currentState!.validate()) {
//       bool success = await _signInUser(
//         email: _emailController.text,
//         password: _pwController.text,
//       );

//       if (success) {
//         Navigator.of(context)
//             .pushNamedAndRemoveUntil(homeRoute, (route) => false);
//       }
//     }
//   }

//   Future<bool> _signInUser({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/signin'),
//         body: jsonEncode({'email': email, 'password': password}),
//         headers: header,
//       );

//       switch (res.statusCode ~/ 100) {
//         case 2:
//           showSnackBar(context, 'Login successful');
//           Provider.of<Users>(context, listen: false)
//               .setUser(User.fromJson(res.body));
//           Provider.of<LocalSettings>(context, listen: false)
//               .setToken(jsonDecode(res.body)['token']);
//           return true;
//         case 4:
//           showSnackBar(context, jsonDecode(res.body)['msg']);
//           return false;
//         case 5:
//           showSnackBar(context, jsonDecode(res.body)['error']);
//           return false;
//         default:
//           showSnackBar(context, res.body);
//           return false;
//       }
//     } catch (e) {
//       showSnackBar(context, e.toString());
//       return false;
//     }
//   }
// }

// class _SignupDialog extends StatelessWidget {
//   final String email;
//   final String pw;

//   _SignupDialog({this.email = '', this.pw = ''});

//   @override
//   Widget build(BuildContext context) {
//     return ButtonWrapper(
//       fillColor: Colors.lightBlue[700]!,
//       splashColor: Theme.of(context).splashColor,
//       elevation: 2,
//       child: Text('Sign Up'),
//       onPressed: () => _dialogBuilder(context),
//     );
//   }

//   Future<void> _dialogBuilder(BuildContext context) {
//     return showDialog<void>(
//       context: context,
//       builder: (context) {
//         final _signupFormKey = GlobalKey<FormState>();
//         final TextEditingController _nameController = TextEditingController();
//         final TextEditingController _emailController = TextEditingController();
//         final TextEditingController _pwController = TextEditingController();
//         final TextEditingController _zipController = TextEditingController();

//         _emailController.text = email;
//         _pwController.text = pw;

//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Theme.of(context).colorScheme.background,
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//               clipBehavior: Clip.hardEdge,
//               child: SingleChildScrollView(
//                 physics: const ScrollPhysics(),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextFieldWrapper(
//                         controller: _nameController,
//                         hintText: 'name',
//                       ),
//                       const SizedBox(height: 8),
//                       TextFieldWrapper(
//                         controller: _emailController,
//                         hintText: 'email',
//                       ),
//                       const SizedBox(height: 8),
//                       TextFieldWrapper(
//                           controller: _pwController,
//                           hintText: 'password (at least 8 characters)',
//                           valiFunc: (String? s) {
//                             print('pw validating');
//                             return (s != null &&
//                                     !s.isWhitespace() &&
//                                     s.length >= 8)
//                                 ? true
//                                 : false;
//                           }),
//                       const SizedBox(height: 8),
//                       TextFieldWrapper(
//                         controller: _zipController,
//                         hintText: 'zip',
//                       ),
//                       Divider(
//                           height: 22, thickness: 2, indent: 18, endIndent: 18),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ButtonWrapper(
//                             fillColor: Theme.of(context).primaryColorLight,
//                             splashColor: Theme.of(context).splashColor,
//                             elevation: 2,
//                             onPressed: () => Navigator.of(context).pop(),
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 8),
//                               child: Text('Cancel',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold)),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           ButtonWrapper(
//                             fillColor: Theme.of(context)
//                                 .colorScheme
//                                 .secondaryContainer,
//                             splashColor: Theme.of(context).splashColor,
//                             elevation: 2,
//                             onPressed: () async {
//                               print(_nameController.text);
//                               print(_emailController.text);
//                               print(_pwController.text);
//                               print(_zipController.text);

//                               if (_signupFormKey.currentState!.validate()) {
//                                 bool success = await _signUpUser(
//                                   context: context,
//                                   name: _nameController.text,
//                                   email: _emailController.text,
//                                   password: _pwController.text,
//                                   zip: _zipController.text,
//                                 );
//                                 if (success) {
//                                   Navigator.of(context).pop();
//                                 }
//                               }
//                             },
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 8),
//                               child: Text('Sign Up!',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold)),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<bool> _signUpUser({
//     required BuildContext context,
//     required String name,
//     required String email,
//     required String password,
//     required String zip,
//   }) async {
//     try {
//       User user = User(
//         name: name,
//         email: email,
//         password: password,
//         zip: zip,
//       );

//       http.Response res = await http.post(
//         Uri.parse('$uri/signup'),
//         body: user.toJson(),
//         headers: header,
//       );

//       switch (res.statusCode ~/ 100) {
//         case 2:
//           showSnackBar(context,
//               'Signup successful!\nPlease log in with the same credentials');
//           return true;
//         case 4:
//           showSnackBar(context, jsonDecode(res.body)['msg']);
//           return false;
//         case 5:
//           showSnackBar(context, jsonDecode(res.body)['error']);
//           return false;
//         default:
//           showSnackBar(context, res.body);
//           return false;
//       }
//     } catch (e) {
//       showSnackBar(context, e.toString());
//       return false;
//     }
//   }
// }
