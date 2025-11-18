import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    final List<String> images = [
      "assets/images/Game/Ori and the Will of the Wisps.jpg",
      "assets/images/Game/ArtStation - Ori and the Blind Forest_ Cover….jpg",
      "assets/images/Game/Ori and the Will of the Wisps.jpg",
      "assets/images/Game/ArtStation - Ori and the Blind Forest_ Cover….jpg",
      "assets/images/Game/Ori and the Will of the Wisps.jpg",
    ];
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
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
                          onPressed: () => {},
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
      ),
    );
  }
}
