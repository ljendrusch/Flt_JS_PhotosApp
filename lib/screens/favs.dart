import 'package:pop_capture/h.dart';

class Favs extends StatefulWidget {
  const Favs({super.key});

  @override
  State<Favs> createState() => _FavsState();
}

class _FavsState extends State<Favs> {
  @override
  Widget build(BuildContext context) {
    Set<String> imageUrls =
        Provider.of<Users>(context).user?.fav_images ?? Set.identity();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              physics: const ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                String imageUrl = imageUrls.elementAt(index);

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              clipBehavior: Clip.hardEdge,
                              child: Image.network(imageUrls.elementAt(index)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4, //20
                          right: 4,
                          child: Icon(
                            Icons.star_border,
                            size: 32,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(
                            Icons.star,
                            size: 20,
                            color: playdo_blue.withAlpha(200),
                          ),
                        ),
                        Center(
                          child: RawMaterialButton(
                            constraints: BoxConstraints.tightFor(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                            ),
                            splashColor: playdo_blue.withAlpha(80),
                            onPressed: () async {
                              await Users().cycleFavImage(context, imageUrl);
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
