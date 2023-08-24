import 'package:pop_capture/h.dart';

const playdo_blue = Color(0xff03b7d9);
const playdo_red = Color(0xfffd523c);

final _my_location = LatLng(37.7693917, -122.486245);

class StreetMap extends StatefulWidget {
  const StreetMap({super.key});

  @override
  State<StreetMap> createState() => _StreetMapState();
}

class _StreetMapState extends State<StreetMap> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<Place> places = Provider.of<Places>(context).places;
    List<Marker> markers = _initMarkers(places);

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: _my_location,
            minZoom: 5,
            zoom: 14,
            maxZoom: 20,
            onTap: (tapPosition, point) {
              _selectedIndex = -1;
              HomeScaffold.of(context)!.cardController?.close();
            },
          ),
          nonRotatedChildren: [
            TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoibGplbmRydXNjc2giLCJhIjoiY2w5b2c3eWhyMDk2djNvbGI5ZnlqOHk3dCJ9.120CPAGrDiGBunTz-w9OHQ',
                  'id': 'mapbox/dark-v10',
                }),
            MarkerLayer(
              markers: [
                ...markers,
                Marker(
                  height: 28,
                  width: 28,
                  point: _my_location,
                  builder: (_) => _MyLocationMarker(),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<Marker> _initMarkers(List<Place> places) {
    List<Marker> list = [];

    for (int i = 0; i < places.length; i++) {
      Place p = places[i];
      list.add(Marker(
        height: 44 * 1.2,
        width: 44,
        point: LatLng(p.lat, p.lon),
        builder: (_) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = i;
              // _bottomSheetUp = true;
            });
            HomeScaffold.of(context)!.cardController = showBottomSheet(
              context: context,
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              constraints: BoxConstraints.tightFor(
                  width: screenWidth * .92, height: screenHeight * .2),
              builder: (context) => _PlaceDetailsCard(place: p),
            );
          },
          child: _MapPin(selected: _selectedIndex == i),
        ),
      ));
    }

    return list;
  }
}

class _MapPin extends StatelessWidget {
  final bool selected;

  const _MapPin({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    double dim = (selected) ? 36.0 : 24.0;
    Color c = (selected) ? playdo_blue : playdo_red;

    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        height: dim * 1.2,
        width: dim,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        child: ClipPath(
          clipper: _ClipTeardrop(),
          child: ColoredBox(color: c),
        ),
      ),
    );
  }
}

class _MyLocationMarker extends StatelessWidget {
  const _MyLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: playdo_blue,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _PlaceDetailsCard extends StatelessWidget {
  final Place place;

  const _PlaceDetailsCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    ImageURL? imageUrl = Provider.of<ImageURLs>(context).images(place.id);

    final _titleStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.bold, color: Colors.black);
    final _addyStyle = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: Colors.grey[800]);

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double buttonDim = 36;
          double imageDim = constraints.maxHeight - buttonDim;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: imageDim,
                    height: imageDim,
                    child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: (imageUrl != null && imageUrl.urls.length > 0)
                            ? Image.network(imageUrl.urls[0])
                            : Image.asset('assets/loading.jpg')),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(place.name,
                            style: _titleStyle,
                            textAlign: TextAlign.center,
                            maxLines: 3),
                        const SizedBox(height: 8),
                        Text(place.address,
                            style: _addyStyle,
                            textAlign: TextAlign.center,
                            maxLines: 3),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              MaterialButton(
                color: playdo_blue,
                height: buttonDim,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(),
                child: Text('See Photography'),
                onPressed: () => Navigator.of(context)
                    .pushNamed(imageFeedRoute, arguments: place),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ClipTeardrop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double halfWidth = size.width / 2;
    double h = size.height;
    double upperRadius = h * .32;
    double lowerRadius = h * .34;

    final path = Path();
    // start at right centerish
    path.moveTo(halfWidth + upperRadius, upperRadius * 1.1);
    // corner xy then endpoint xy
    path.quadraticBezierTo(halfWidth + upperRadius, 0, halfWidth, 0);
    path.quadraticBezierTo(
        halfWidth - upperRadius, 0, halfWidth - upperRadius, upperRadius * 1.1);
    // upper half circle done, now at left centerish
    path.quadraticBezierTo(
        halfWidth - upperRadius, upperRadius + lowerRadius, halfWidth, h);
    path.quadraticBezierTo(halfWidth + upperRadius, upperRadius + lowerRadius,
        halfWidth + upperRadius, upperRadius * 1.1);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
