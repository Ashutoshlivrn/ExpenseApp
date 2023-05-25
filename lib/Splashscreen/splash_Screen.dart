import 'package:expenseapp/SignIn_SignUp/sign_in.dart';
import 'package:expenseapp/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height/75;
    //  height/75 is   height = 10..
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: height*4 ,
                ),
                Center(
                  child: Lottie.network(
                    'https://assets8.lottiefiles.com/packages/lf20_rqes9zyp.json',
                    controller: _controller,
                    onLoaded: (cons) {
                      _controller
                        ..duration = cons.duration
                        ..forward().then((value) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          //dispose();
                        });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return SignIn();
        }
      },
    );
  }
}
