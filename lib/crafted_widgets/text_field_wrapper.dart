import 'package:pop_capture/h.dart';

class TextFieldWrapper extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final Color enabledBorderColor;
  final Color disabledBorderColor;
  final bool Function(String?)? valiFunc;
  final bool obscureText;
  final TextInputType keyboardType;

  const TextFieldWrapper({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.enabledBorderColor = const Color(0xffdddddd),
    this.disabledBorderColor = const Color(0xff888888),
    this.valiFunc = null,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      autocorrect: false,
      enableSuggestions: false,
      enableIMEPersonalizedLearning: false,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: disabledBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enabledBorderColor))),
      validator: (v) {
        // return null means validation passed
        if (valiFunc != null) {
          if (valiFunc!(v)) {
            return null;
          }
        } else if (v != null && !v.isWhitespace()) {
          return null;
        }
        return 'Enter your $hintText';
      },
      maxLines: maxLines,
    );
  }
}
