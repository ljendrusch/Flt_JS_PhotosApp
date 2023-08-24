import 'package:pop_capture/h.dart';

const int _numTabs = 3;
const int _tabsLastIndex = _numTabs - 1;

class HomeScaffold extends StatefulWidget {
  final dynamic args;

  const HomeScaffold({super.key, this.args});

  @override
  State<HomeScaffold> createState() => HomeScaffoldState();

  static HomeScaffoldState? of(BuildContext context) =>
      context.findAncestorStateOfType<HomeScaffoldState>();
}

class HomeScaffoldState extends State<HomeScaffold> {
  int activePageIndex = 0;
  int currentTabIndex = 0;
  PersistentBottomSheetController<void>? cardController;

  @override
  void initState() {
    if (widget.args != null && widget.args.containsKey('index')) {
      activePageIndex = widget.args['index'];
      currentTabIndex = widget.args['index'];
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  void moveToTab(int index) {
    if (index < _tabsLastIndex) {
      setState(() {
        activePageIndex = index;
        currentTabIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: [
        const StreetMap(),
        const Favs(),
      ][activePageIndex],
      endDrawer: const _EndDrawer(),
      endDrawerEnableOpenDragGesture: false,
      onEndDrawerChanged: (scaffoldOpening) {
        if (!scaffoldOpening) {
          setState(() {
            currentTabIndex = activePageIndex;
          });
        }
      },
      bottomNavigationBar: Builder(
        builder: (context) => NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              currentTabIndex = index;
              if (index < _tabsLastIndex) {
                cardController?.close();
                activePageIndex = index;
              } else {
                Scaffold.of(context).openEndDrawer();
              }
            });
          },
          selectedIndex: currentTabIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            NavigationDestination(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: [
        TextField(autocorrect: false, enableSuggestions: false),
        Text('Favorites', style: const TextStyle(fontWeight: FontWeight.bold)),
      ][activePageIndex],
      actions: [const SizedBox()],
    );
  }
}

class _EndDrawer extends StatelessWidget {
  const _EndDrawer();

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<Users>(context).user;

    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * .04),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const ScrollPhysics(),
          children: [
            ButtonWrapper(
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              splashColor: Theme.of(context).splashColor,
              onPressed: () {
                // Navigator.of(context).pop();
                // Navigator.of(context).pushNamed(profileRoute);
              },
              child: ConstrainedBox(
                constraints:
                    BoxConstraints.tightFor(height: screenHeight * .18),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tight(
                          Size.square(screenHeight * .15),
                        ),
                        child: ClipPath(
                          clipper: ClipCircleBottomChorded(),
                          clipBehavior: Clip.antiAlias,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.asset('assets/bob.jpg'),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          user?.name ?? 'loading',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              thickness: 2,
              indent: 8,
              endIndent: 8,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            ListTile(
              title: const Text('Help Center'),
              onTap: () {
                //do a text popup
              },
            ),
            ListTile(
              title: const Text('Terms of Service'),
              onTap: () {
                //do a text popup
              },
            ),
            ListTile(
              title: const Text('Privacy'),
              onTap: () {
                //do a text popup
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                Provider.of<LocalSettings>(context, listen: false).reset();
                Provider.of<Users>(context, listen: false).reset();
                Provider.of<Places>(context, listen: false).reset();
                Provider.of<ImageURLs>(context, listen: false).reset();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
            ),
            const AboutListTile(
              applicationIcon: Icon(Icons.camera_alt),
              applicationName: 'Pop Capture',
              applicationVersion: '0.23',
            ),
          ],
        ),
      ),
    );
  }
}

class ClipCircleBottomChorded extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.addArc(Rect.fromLTWH(0, 0, w, h), pi * 3 / 4, pi * 3 / 2);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
