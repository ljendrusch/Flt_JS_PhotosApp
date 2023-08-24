import 'package:pop_capture/h.dart';
import 'package:http/http.dart' as http;

class Places with ChangeNotifier {
  static final Places _instance = Places._internal();
  factory Places() => _instance;

  FetchState _fetchState = FetchState.init;
  String _message = '';
  List<Place> _places = [];

  FetchState get status => _fetchState;
  String get message => _message;
  List<Place> get places => _places;

  Places._internal() {
    fetchPlaces();
  }

  Future<void> fetchPlaces() async {
    try {
      _fetchState = FetchState.loading;
      final res = await http.get(
        Uri.parse('$uri/places'),
        headers: headerWithToken(LocalSettings().token),
      );

      if (res.statusCode == 200) {
        _fetchState = FetchState.success;
        _places = Place.listFromJson(res.body);
        _message = _places.toString();
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
    _places = [];
  }
}
