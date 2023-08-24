import 'package:pop_capture/h.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalSettings with ChangeNotifier {
  static final LocalSettings _instance = LocalSettings._internal();
  factory LocalSettings() => _instance;

  final Box _box = Hive.box('localSettings');

  late String _token;

  String get token => _token;

  LocalSettings._internal() {
    _token = _box.get('x-auth-token', defaultValue: '');
  }

  void setToken(String s) {
    _box.put('x-auth-token', s);
    _token = s;
    notifyListeners();
  }

  void reset() {
    _box.put('x-auth-token', '');
    _token = '';
  }
}
