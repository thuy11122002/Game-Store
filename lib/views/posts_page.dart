import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:game_store_app/models/post_model.dart';
import 'package:game_store_app/models/product_model.dart';
import 'package:game_store_app/services/auth_service.dart';
import 'package:game_store_app/views/detail_post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage>
    with SingleTickerProviderStateMixin {
  bool expanded = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthService _authService = AuthService();

  void _logout() async {
    _authService.logout(context);
  }

  late Future<List<Post>> futurePost = fetchPost();

  List<Post> posts = [];

  @override
  void initState() {
    // TODO: implement initState
    initializeData();
    super.initState();
  }

  void initializeData() async {
    try {
      final posts = await futurePost;
      if (posts.isNotEmpty) {
        setState(() {
          this.posts = posts;
        });
      }
    } catch (e) {
      print("Initialization Error: $e");
    }
  }

  Future<List<Post>> fetchPost() async {
    try {
      final reponse = await Supabase.instance.client.from("post").select();

      return (reponse as List).map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching product: $e");
      return [];
    }
  }

  Future<Product?> fetchOneProduct(int id) async {
    try {
      final reponse = await Supabase.instance.client
          .from("product")
          .select()
          .eq("id", id)
          .single();

      return Product.fromJson(reponse);
    } catch (e) {
      print("Error fetching product: $e");
      return null;
    }
  }

  Widget _buildPostList() {
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: futurePost,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return SizedBox.shrink();
          }
          return ListView.builder(
              // scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Future<Product?> p = fetchOneProduct(posts[index].game_id);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPost(
                            image: posts[index].image,
                            heading: posts[index].heading,
                            title: posts[index].title,
                            subtitle: posts[index].subtitle,
                            description: posts[index].description,
                            type: posts[index].type,
                            game_id: posts[index].game_id,
                          ),
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                    child: Container(
                      height: height / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          image: DecorationImage(
                              image: Image.network(posts[index].image).image,
                              fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: height / 2 / 1.8,
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
                          child: Column(
                            children: [
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        posts[index].title,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        posts[index].heading,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32),
                                      ),
                                      Text(
                                        posts[index].subtitle,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(24),
                                      bottomRight: Radius.circular(24)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: FutureBuilder(
                                      future: p,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (snapshot.hasError ||
                                            !snapshot.hasData) {
                                          return SizedBox.shrink();
                                        }
                                        final game = snapshot.data!;
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    game.image,
                                                    width: 52,
                                                    height: 52,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        game.name,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        game.category,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white38,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text("Nhận"))
                                          ],
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
                // onTap: () => _logout(),
              ),
              ListTile(title: Text('Item 2')),
            ],
          ),
        ),
      ),
      body: Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(27, 8, 40, 1),
            Color.fromRGBO(27, 8, 40, 1),
            Color.fromRGBO(27, 8, 40, 1),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
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
                          // IconButton(
                          //     onPressed: () =>
                          //         {_scaffoldKey.currentState?.openDrawer()},
                          //     icon: Icon(
                          //       Icons.menu_rounded,
                          //       size: 36,
                          //       color: Colors.white,
                          //     )),
                          Text(
                            "Tin Nổi Bật Hôm Nay",
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
                // Padding(
                //   padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child:
                //   ),
                // ),
                _buildPostList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
