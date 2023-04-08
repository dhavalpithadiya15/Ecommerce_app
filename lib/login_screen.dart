import 'dart:convert';

import 'package:ecommerce_app/home_screen.dart';
import 'package:ecommerce_app/register_screen.dart';
import 'package:ecommerce_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool seePassword = true;
  bool isLogin = false;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool ff = false;

  lll() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = totalHeight - statusbarHeight;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blue.withOpacity(0.5),
                    width: double.infinity,
                    child: Text(
                      "D-Shop",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Color(0xff0C21C1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Sign in",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.025,
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "If you don’t have an account register",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text(
                                "You can ",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return RegisterScreen();
                                    },
                                  ));
                                },
                                child: Text(
                                  "Register here !",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0C21C1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.07,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: loginEmailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        hintText: "Enter your email address",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                        prefixIcon: Icon(
                          Icons.mail_outline_outlined,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please fill empty field";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.07,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Password",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: loginPasswordController,
                          obscureText: seePassword,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            hintText: "Enter your Password",
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 18),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (seePassword) {
                                    seePassword = false;
                                  } else if (!seePassword) {
                                    seePassword = true;
                                  }
                                });
                              },
                              icon: seePassword
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please fill empty field";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text("Forgot Password ?",
                                style: TextStyle(fontSize: 15)),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: bodyHeight * 0.04,
                  ),
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        EasyLoading.show(status: "Please wait...");
                        Map loginData = {
                          "mapEmailLogin": loginEmailController.text,
                          "mapPasswordLogin": loginPasswordController.text
                        };
                        var url = Uri.parse(
                            'https://dhaval1512.000webhostapp.com/ecommerce/login.php');
                        var response = await http.post(url, body: loginData);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                        var apiDecode = jsonDecode(response.body);
                        MyLoginData objMyLoginData =
                            MyLoginData.fromJson(apiDecode);
                        EasyLoading.dismiss(animation: false);
                        if (objMyLoginData.loginConnected == 1) {
                          if (objMyLoginData.loginSucess == 1) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 50,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    actions: [
                                      Lottie.asset(
                                        "lottie/loginsucsess.json",
                                        repeat: false,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Login Sucessfully",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            String? userName=objMyLoginData.userdata!.name;
                            String? userEmail=objMyLoginData.userdata!.email;
                            String? userImage=objMyLoginData.userdata!.image;
                            String? userId=objMyLoginData.userdata!.id;
                            SplashScreen.prefs!.setString("userName", userName!);
                            SplashScreen.prefs!.setString("userEmail", userEmail!);
                            SplashScreen.prefs!.setString("userImage", userImage!);
                            SplashScreen.prefs!.setString("userid", userId!);
                            SplashScreen.prefs!.setBool("isLogin", true);
                            Future.delayed(Duration(seconds: 3)).then((value) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreen();
                                },
                              ));
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "User not found",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xff0C21C1),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.02,
                  ),
                  Text(
                    "or continue with",
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.02,
                  ),
                  Container(
                    width: totalWidth * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("images/Facebook.png"),
                        Image.asset("images/apple.png"),
                        Image.asset("images/google.png")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyLoginData {
  int? loginConnected;
  int? loginSucess;
  Userdata? userdata;

  MyLoginData({this.loginConnected, this.loginSucess, this.userdata});

  MyLoginData.fromJson(Map<String, dynamic> json) {
    loginConnected = json['Login connected'];
    loginSucess = json['login sucess'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Login connected'] = this.loginConnected;
    data['login sucess'] = this.loginSucess;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? name;
  String? number;
  String? email;
  String? password;
  String? image;

  Userdata(
      {this.id, this.name, this.number, this.email, this.password, this.image});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    number = json['Number'];
    email = json['Email'];
    password = json['Password'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Number'] = this.number;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Image'] = this.image;
    return data;
  }
}
