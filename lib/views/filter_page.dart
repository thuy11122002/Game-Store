import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int selectedIndex = 0;

  bool leftBig = true;

  final List<String> types = [
    "Action",
    "Adventure",
    "Racing",
    "RPG",
    "Simulation",
    "Survival",
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 40;
    // final PageController controller = PageController();
    final PageController controller = PageController();

    final List<String> images = [
      "assets/images/Game/Ori and the Will of the Wisps.jpg",
      "assets/images/Game/ArtStation - Ori and the Blind Forest_ Cover….jpg",
      "assets/images/Game/Ori and the Will of the Wisps.jpg",
      "assets/images/Game/ArtStation - Ori and the Blind Forest_ Cover….jpg",
      "assets/images/Game/Ori and the Will of the Wisps.jpg",
      "assets/images/Game/ArtStation - Ori and the Blind Forest_ Cover….jpg",
      "assets/images/Game/Ori and the Will of the Wisps.jpg",
      "assets/images/Game/ArtStation - Ori and the Blind Forest_ Cover….jpg",
      "assets/images/Game/Ori and the Will of the Wisps.jpg",
      "assets/images/Game/ArtStation - Ori and the Blind Forest_ Cover….jpg",
      "assets/images/Game/Ori and the Will of the Wisps.jpg",
    ];

    List<Widget> galleryWidgets = [];

    int i = 0;
    while (i < images.length) {
      // Mỗi ảnh thứ 3 full width
      if ((i + 1) % 3 == 0) {
        galleryWidgets.add(
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Container(
              width: screenWidth,
              height: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                      image: AssetImage(images[i]),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87,
                        blurRadius: 10,
                        spreadRadius: 4,
                        offset: Offset(1, 1))
                  ]),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 80,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      // padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ori and The Will of The Wisps",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            "Offer ends 21 Apr @ 12:00am",
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(color: Colors.white38, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        i++;
      } else {
        // 2 ảnh trên 1 hàng
        int firstIndex = i;
        int? secondIndex = i + 1 < images.length ? i + 1 : null;

        galleryWidgets.add(
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: leftBig ? screenWidth * 0.55 : screenWidth * 0.4,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          blurRadius: 1,
                          spreadRadius: 4,
                          offset: Offset(1, 1))
                    ],
                    image: DecorationImage(
                        image: AssetImage(images[firstIndex]),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 100,
                      width: screenWidth * 0.55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          // padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ori and The Will of The Wisps",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                "Offer ends 21 Apr @ 12:00am",
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white38, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                if (secondIndex != null)
                  Container(
                    width: leftBig ? screenWidth * 0.4 : screenWidth * 0.55,
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          blurRadius: 1,
                          spreadRadius: 4,
                        )
                      ],
                      image: DecorationImage(
                          image: AssetImage(images[secondIndex]),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 100,
                        width: screenWidth * 0.55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            // padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ori and The Will of The Wisps",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Offer ends 21 Apr @ 12:00am",
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white38, fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );

        leftBig = !leftBig;
        i += secondIndex != null ? 2 : 1;
      }
    }
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(27, 8, 40, 1),
          Color.fromRGBO(27, 8, 40, 1),
          Color.fromRGBO(27, 8, 40, 1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      "Your Games Collections",
                      style: TextStyle(
                        color: Color.fromRGBO(109, 76, 146, 1),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 36,
                    padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                    child: ListView.builder(
                      controller: controller,
                      itemCount: types.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        bool isSelected = index == selectedIndex;

                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedIndex = index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              // color: Color.fromRGBO(99, 48, 209, 1)
                              color: isSelected
                                  ? Color.fromRGBO(99, 48, 209, 1)
                                  : Color.fromRGBO(40, 17, 61, 1),
                            ),
                            // padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                            margin: EdgeInsets.only(right: 8),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                child: Text(
                                  types[index],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.white38),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: ListView(
                        children: galleryWidgets,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
