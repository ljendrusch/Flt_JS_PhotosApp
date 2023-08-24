import 'package:pop_capture/h.dart';

class Dummy {
  static final Dummy _instance = Dummy._internal();
  factory Dummy() => _instance;

  static List<String> _imageUrls = [];

  Dummy._internal() {}

  static List<String> get imageUrls {
    if (_imageUrls.isEmpty) {
      _imageUrls = [
        'https://images.unsplash.com/photo-1518057111178-44a106bad636?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1888&q=80',
      ];
    }

    return _imageUrls;
  }
}
