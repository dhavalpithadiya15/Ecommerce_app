import 'package:ecommerce_app/addcart_screen.dart';
import 'package:ecommerce_app/addproduct_screen.dart';
import 'package:ecommerce_app/home.dart';
import 'package:ecommerce_app/likeproduct_screen.dart';
import 'package:ecommerce_app/login_screen.dart';
import 'package:ecommerce_app/splash_screen.dart';
import 'package:ecommerce_app/updateproduct_screen.dart';
import 'package:ecommerce_app/viewproduct_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String myappBartitle = "";
  static int cnt = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawer = false;
  List<Widget> pages = [Home(), AddProductScreen(), ViewProductScreen(),LikeProductScreen()];

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = totalHeight - statusbarHeight;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color(0xff1A1A40),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://dhaval1512.000webhostapp.com/ecommerce/${SplashScreen.prefs!.getString("userImage")}"),
              ),
              decoration: BoxDecoration(color: Color(0xff1A1A40)),
              accountName: Text(
                "${SplashScreen.prefs!.getString("userName")}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              accountEmail: Text(
                "${SplashScreen.prefs!.getString("userEmail")}",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.white,
              endIndent: 30,
              indent: 30,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  HomeScreen.cnt = 0;
                  HomeScreen.myappBartitle = "Home";
                });
              },  
              title: Text(
                "Home",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  HomeScreen.cnt = 1;
                  HomeScreen.myappBartitle = "Add Product";
                });
              },
              title: Text(
                "Add Product",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              leading: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  HomeScreen.cnt = 2;
                  HomeScreen.myappBartitle = "View Product";
                });
              },
              title: Text(
                "View Product",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              leading: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  HomeScreen.cnt = 3;
                  HomeScreen.myappBartitle = "Like Product";
                });
              },
              title: Text(
                "Like Product",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              leading: Icon(
                CupertinoIcons.heart,
                color: Colors.white,
              ),
            ),

            ListTile(
              onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return AddCartScreen();
              },));
              },
              title: Text(
                "Cart",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              leading: Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: bodyHeight * 0.2,
            ),
            Divider(
              color: Colors.white,
              endIndent: 30,
              indent: 30,
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text(
                        "Are you sure want to Logout ?",
                        style: TextStyle(fontSize: 15),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                SplashScreen.prefs!
                                    .setBool("isLogin", false)
                                    .then((value) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return LoginScreen();
                                    },
                                  ));
                                });
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15)),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
              title: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      appBar: HomeScreen.cnt==0?AppBar(
        title: Text(HomeScreen.myappBartitle.isEmpty?"Home":HomeScreen.myappBartitle,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,),
        ),
        iconTheme: IconThemeData(
          color: Color(0xff0C21C1),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.heart),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return AddCartScreen();
              },));
            },
            icon: Icon(CupertinoIcons.shopping_cart),
            color: Colors.black,
          ),

        ],
      ):AppBar(
        backgroundColor: Colors.white,
        title: Text(HomeScreen.myappBartitle,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        iconTheme: IconThemeData(
          color: Color(0xff0C21C1),
        ),
        centerTitle: true,
      ),
      body: pages[HomeScreen.cnt],
    );
  }
}
