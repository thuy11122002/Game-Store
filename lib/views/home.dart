import 'package:flutter/material.dart';
import 'package:game_store_app/models/product_model.dart';
import 'package:game_store_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController controller = PageController(
    viewportFraction: 0.8,
  );
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

  late Future<List<Product>> futureProduct = fetchProduct();

  List<Product> products = [];

  @override
  void initState() {
    // TODO: implement initState
    initializeData();
    super.initState();
  }

  void initializeData() async {
    try {
      final products = await futureProduct;
      if (products.isNotEmpty) {
        setState(() {
          this.products = products;
        });
      }
    } catch (e) {
      print("Initialization Error: $e");
    }
  }

  Future<List<Product>> fetchProduct() async {
    try {
      final reponse = await Supabase.instance.client.from("product").select();

      return (reponse as List).map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching product: $e");
      return [];
    }
  }

  Widget _buildSpecialDealProductList() {
    return FutureBuilder(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return SizedBox.shrink();
          }
          return Container(
            height: 400,
            padding: EdgeInsets.only(left: 24),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 160,
                    margin: EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 180,
                          width: 160,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              products[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Weekend Deal",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Offer ends 21 Apr @ 12:00am",
                          maxLines: null,
                          style: TextStyle(color: Colors.white38, fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 100,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            "Up to - 83%",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }

  Widget _buildProductList() {
    return FutureBuilder(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return SizedBox.shrink();
          }
          return Container(
            height: 240,
            padding: EdgeInsets.only(left: 0),
            child: PageView.builder(
              controller: controller,
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: 240,
                  width: 320,
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: Image.network(products[index].image).image,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 80,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                products[index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                products[index].description,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white38, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

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
      body: Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(27, 8, 40, 1),
            Color.fromRGBO(27, 8, 40, 1),
            Color.fromRGBO(27, 8, 40, 1),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
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
                            onPressed: () =>
                                {_scaffoldKey.currentState?.openDrawer()},
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 320,
                            height: 60,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color:
                                  Color.fromRGBO(40, 17, 61, 1), // màu nền tím
                              borderRadius:
                                  BorderRadius.circular(12), // bo góc tròn
                            ),
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold, // màu hint

                                  color: Color.fromRGBO(
                                      109, 76, 146, 1)), // màu chữ
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type something",
                                hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(109, 76, 146, 1),
                                    fontWeight: FontWeight.bold), // màu hint
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.purple),
                            child: IconButton(
                                onPressed: () => {},
                                icon: Icon(
                                  Icons.search_rounded,
                                  color: Colors.white,
                                  size: 32,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 320,
                                      child: Text(
                                        "Featured & Recommended",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(109, 76, 146, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "See all",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _buildProductList(),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 320,
                                      child: Text(
                                        "Special Offers",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(109, 76, 146, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "See all",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // Container(
                              //   height: 400,
                              //   padding: EdgeInsets.only(left: 24),
                              //   child: ListView.builder(
                              //       scrollDirection: Axis.horizontal,
                              //       itemCount: images.length,
                              //       itemBuilder: (context, index) {
                              //         return Container(
                              //           width: 160,
                              //           margin: EdgeInsets.only(right: 12),
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               SizedBox(
                              //                 height: 180,
                              //                 width: 160,
                              //                 child: ClipRRect(
                              //                   borderRadius:
                              //                       BorderRadius.circular(12),
                              //                   child: Image.asset(
                              //                     "assets/images/Game/Ori and the Will of the Wisps.jpg",
                              //                     fit: BoxFit.cover,
                              //                   ),
                              //                 ),
                              //               ),
                              //               SizedBox(
                              //                 height: 8,
                              //               ),
                              //               Text(
                              //                 "Weekend Deal",
                              //                 style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontWeight: FontWeight.bold,
                              //                     fontSize: 16),
                              //               ),
                              //               SizedBox(
                              //                 height: 8,
                              //               ),
                              //               Text(
                              //                 "Offer ends 21 Apr @ 12:00am",
                              //                 maxLines: null,
                              //                 style: TextStyle(
                              //                     color: Colors.white38,
                              //                     fontSize: 14),
                              //               ),
                              //               SizedBox(
                              //                 height: 8,
                              //               ),
                              //               Container(
                              //                 width: 100,
                              //                 padding: EdgeInsets.all(12),
                              //                 decoration: BoxDecoration(
                              //                     color: Colors.purple,
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             12)),
                              //                 child: Text(
                              //                   "Up to - 83%",
                              //                   style: TextStyle(
                              //                       color: Colors.white,
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         );
                              //       }),
                              // )
                              _buildSpecialDealProductList()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
