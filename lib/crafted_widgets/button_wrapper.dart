import 'package:pop_capture/h.dart';

class ButtonWrapper extends StatelessWidget {
  final Color fillColor;
  final Color splashColor;
  final double elevation;
  final bool isRounded;
  final GestureTapCallback onPressed;
  final Widget child;

  const ButtonWrapper(
      {super.key,
      this.fillColor = Colors.transparent,
      required this.splashColor,
      this.elevation = 0,
      this.isRounded = true,
      required this.onPressed,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: fillColor,
      splashColor: splashColor,
      shape: (isRounded)
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          : Border(),
      constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
      elevation: elevation,
      focusElevation: elevation,
      hoverElevation: elevation,
      disabledElevation: 0,
      highlightElevation: elevation,
      onPressed: onPressed,
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
