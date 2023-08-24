import 'package:pop_capture/h.dart';

class Place {
  final String id;
  final String name;
  final String address;
  final String icon_url;
  final String icon_bg_color;
  final double lat;
  final double lon;

  const Place(
      {required this.id,
      required this.name,
      required this.address,
      required this.icon_url,
      required this.icon_bg_color,
      required this.lat,
      required this.lon});

  factory Place._fromMap(Map<String, dynamic> m) {
    return Place(
      id: m['_id']!,
      name: m['name']!,
      address: m['address']!,
      icon_url: m['icon_url']!,
      icon_bg_color: m['icon_bg_color']!,
      lat: m['lat']!,
      lon: m['lon']!,
    );
  }

  static List<Place> listFromJson(String source) {
    return (jsonDecode(source) as List).map((e) => Place._fromMap(e)).toList();
  }
}
