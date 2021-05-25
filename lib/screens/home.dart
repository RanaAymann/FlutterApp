import 'package:FlutterApp/animation/animation.dart';
import 'package:FlutterApp/globals/globals.dart';
import 'package:FlutterApp/services/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'blog.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    final Size screenSize = media.size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: screenSize.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            width: 250,
                            child: RaisedButton.icon(
                              color: Color(
                                int.parse(
                                  Globals.convertColor("#907fa4"),
                                ),
                              ),
                              label: Text(
                                'Login with Gmail',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              icon: Image.asset(
                                "assets/images/Gmail_logo.ico",
                                color: Colors.white,
                                width: 24.0,
                                height: 24.0,
                              ),
                              onPressed: () async {
                                var googleLogin = await Login.loginWithGoogle();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenSize.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            width: 250,
                            child: RaisedButton.icon(
                              color: Color(
                                int.parse(
                                  Globals.convertColor("#907fa4"),
                                ),
                              ),
                              label: Text(
                                'Login with Apple',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              icon: Image.asset("assets/images/Apple-logo.png",
                                  color: Colors.white,
                                  width: 24.0,
                                  height: 24.0),
                              onPressed: () async {
                                var appleLogin =
                                    await Login.loginWithApple(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 350,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.asset('assets/images/myLogo.png'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("Welcome, I'm Rana"),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2,
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Blog()),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color(
                                  int.parse(
                                    Globals.convertColor("#907fa4"),
                                  ),
                                ),
                                Color(
                                  int.parse(
                                    Globals.convertColor("#a58faa"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
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
