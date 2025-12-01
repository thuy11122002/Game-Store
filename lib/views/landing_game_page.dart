import 'package:flutter/material.dart';
import 'package:game_store_app/services/auth_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingGamePage extends StatefulWidget {
  const LandingGamePage({super.key});

  @override
  State<LandingGamePage> createState() => _LandingGamePageState();
}

class _LandingGamePageState extends State<LandingGamePage> {
  final PageController controller = PageController();
  final List<String> images = [
    "assets/images/Game/Ori and the Will of the Wisps.jpg",
    "assets/images/Game/ArtStation - Ori and the Blind Forest_ Cover….jpg",
    "assets/images/Game/Ori and the Will of the Wisps.jpg",
    "assets/images/Game/ArtStation - Ori and the Blind Forest_ Cover….jpg",
    "assets/images/Game/Ori and the Will of the Wisps.jpg",
  ];

  final AuthService _authService = AuthService();

  void _logout() async {
    _authService.logout(context);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () => _logout(),
              ),
              ListTile(title: Text('Item 2')),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                controller: controller,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    child: Image.asset(fit: BoxFit.cover, images[index]),
                  );
                },
              )),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => {
                              _scaffoldKey.currentState?.openDrawer()
                              // _logout()
                            },
                        icon: Icon(
                          Icons.menu_rounded,
                          size: 36,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () => {},
                        icon: Icon(
                          Icons.card_travel_sharp,
                          size: 36,
                          color: Colors.white,
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ori and The Will of The Wisps",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: controller,
                          count: images.length,
                          effect: ExpandingDotsEffect(
                              dotHeight: 10,
                              dotWidth: 10,
                              activeDotColor: Colors.white),
                          onDotClicked: (index) {
                            controller.animateToPage(index,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                        ),
                        Row(
                          children: [
                            Text("See introduction",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            IconButton(
                                onPressed: () => {},
                                icon: Icon(
                                  Icons.play_circle_fill_rounded,
                                  size: 60,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
