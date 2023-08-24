import 'package:pop_capture/h.dart';
import 'package:http/http.dart' as http;

class ImageURLs with ChangeNotifier {
  static final ImageURLs _instance = ImageURLs._internal();
  factory ImageURLs() => _instance;

  FetchState _fetchState = FetchState.init;
  String _message = '';
  Map<String, ImageURL> _map = {};

  FetchState get status => _fetchState;
  String get message => _message;
  ImageURL? images(String id) => _map[id];

  ImageURLs._internal() {
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    try {
      _fetchState = FetchState.loading;
      final res = await http.get(
        Uri.parse('$uri/images'),
        headers: headerWithToken(LocalSettings().token),
      );

      if (res.statusCode == 200) {
        _fetchState = FetchState.success;
        _map = ImageURL.mapFromJson(res.body);
        _message = _map.toString();
        notifyListeners();
      } else {
        _fetchState = FetchState.error;
        _message = res.statusCode.toString();
      }
    } catch (e) {
      _fetchState = FetchState.error;
      _message = '$e';
    }
  }

  void reset() {
    _fetchState = FetchState.init;
    _message = '';
    _map = {};
  }
}
