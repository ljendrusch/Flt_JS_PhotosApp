import 'package:pop_capture/h.dart';

extension SetOfMaterialStateExt on Set<MaterialState> {
  bool get isDisabled => contains(MaterialState.disabled);
  bool get isDragged => contains(MaterialState.dragged);
  bool get isError => contains(MaterialState.error);
  bool get isFocused => contains(MaterialState.focused);
  bool get isHovered => contains(MaterialState.hovered);
  bool get isPressed => contains(MaterialState.pressed);
  bool get isScrolledUnder => contains(MaterialState.scrolledUnder);
  bool get isSelected => contains(MaterialState.selected);
}

RegExp _emailCheck = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

extension StringExt on String {
  bool isValidEmail() => _emailCheck.hasMatch(this);
  bool isWhitespace() => trim().isEmpty;
  bool isValidInt() => int.tryParse(this) != null;
  bool isValidDouble() => double.tryParse(this) != null;

  Uri toUri() => Uri.parse(this);

  LatLng toLatLng() {
    List<String> tokens = this.trim().split(',');
    double lat = double.parse(tokens[0].trim());
    double lng = double.parse(tokens[1].trim());
    return LatLng(lat, lng);
  }
}
