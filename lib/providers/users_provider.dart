import 'package:pop_capture/h.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static final Users _instance = Users._internal();
  factory Users() => _instance;

  FetchState _fetchState = FetchState.init;
  String _message = '';
  User? _user = null;

  FetchState get status => _fetchState;
  String get message => _message;
  User? get user => _user;

  Users._internal() {
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      _fetchState = FetchState.loading;
      final res = await http.get(
        Uri.parse('$uri/'),
        headers: headerWithToken(LocalSettings().token),
      );

      if (res.statusCode == 200) {
        _fetchState = FetchState.success;
        _user = User.fromJson(res.body);
        _message = _user.toString();
      } else {
        _fetchState = FetchState.error;
        _message = res.statusCode.toString();
      }
    } catch (e) {
      _fetchState = FetchState.error;
      _message = '$e';
    }
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> cycleFavImage(BuildContext context, String imageUrl) async {
    try {
      final res = await http.post(
        Uri.parse('$uri/favImage'),
        headers: headerWithToken(LocalSettings().token),
        body: jsonEncode({'id': _user!.id, 'image': imageUrl}),
      );

      if (res.statusCode == 200) {
        bool favd = jsonDecode(res.body)['method'] == 'insert';
        if (favd)
          _user!.fav_images.add(imageUrl);
        else
          _user!.fav_images.remove(imageUrl);
        return favd;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('invalid image url $imageUrl')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return false;
  }

  void reset() {
    _fetchState = FetchState.init;
    _message = '';
    _user = null;
  }
}

// https://live.staticflickr.com/65535/52499936136_b78300949d.jpg
