import 'package:pop_capture/h.dart';

class ImageURL {
  final String id;
  final double lat;
  final double lon;
  final List<String> urls;

  const ImageURL({
    required this.id,
    required this.lat,
    required this.lon,
    required this.urls,
  });

  factory ImageURL._fromMap(Map<String, dynamic> m) {
    return ImageURL(
      id: m['_id']!,
      lat: m['lat']!,
      lon: m['lon']!,
      urls: (m['urls']! as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  // factory ImageURL._fromMap(Map<String, dynamic> m) {
  //   return ImageURL(
  //     id: m['_id']!,
  //     lat: m['lat']!,
  //     lon: m['lon']!,
  //     urls: _urlsList(m['urls']!),
  //   );
  // }

  // static List<String> _urlsList(List<dynamic> source) {
  //   return source.map((e) => e.toString()).toList();
  // }

  static Map<String, ImageURL> mapFromJson(String source) {
    Map<String, ImageURL> m = {};
    (jsonDecode(source) as List).forEach((e) {
      ImageURL i = ImageURL._fromMap(e);
      m[i.id] = i;
    });
    return m;
  }
}
