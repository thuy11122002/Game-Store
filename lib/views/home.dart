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
                itemCount: 5,
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
              itemCount: 5,
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
                        Text(
                          "Game",
                          style: TextStyle(
                              color: Color.fromRGBO(109, 76, 146, 1),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person,
                              color: Colors.white, size: 24),
                        ),
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
