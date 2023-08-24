import 'package:pop_capture/h.dart';

class ImageFeed extends StatefulWidget {
  final dynamic args;

  const ImageFeed({super.key, this.args});

  @override
  State<ImageFeed> createState() => _ImageFeedState();
}

class _ImageFeedState extends State<ImageFeed> {
  late Place place;

  @override
  void initState() {
    place = widget.args!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImageURL? imageUrls = Provider.of<ImageURLs>(context).images(place.id);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Photography for',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            color: Theme.of(context).colorScheme.secondaryContainer,
            onSelected: (index) => (index == 0)
                ? Navigator.of(context).pop()
                : Navigator.of(context).pop(),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Action 1'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Action 2'),
              ),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Text(
              place.name,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            )),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: imageUrls?.urls.length ?? 0,
                itemBuilder: (context, index) {
                  String imageUrl = imageUrls?.urls[index] ?? '';
                  bool favStatus =
                      Users().user?.fav_images.contains(imageUrl) ?? false;

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      clipBehavior: Clip.hardEdge,
                                      child: (imageUrls != null &&
                                              imageUrls.urls.length > index)
                                          ? Image.network(imageUrls.urls[index])
                                          : Image.asset('assets/loading.jpg')),
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
                                  color: (favStatus)
                                      ? playdo_blue.withAlpha(200)
                                      : Colors.black.withAlpha(150),
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
                                    bool favd = (imageUrls != null &&
                                        imageUrls.urls.length > index &&
                                        await Users()
                                            .cycleFavImage(context, imageUrl));
                                    setState(() {
                                      print(favd);
                                      favStatus = favd;
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
