import 'package:expenseapp/Auth/Auth.dart';
import 'package:expenseapp/SignIn_SignUp/sign_up.dart';
import 'package:expenseapp/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formField = GlobalKey<FormState>();
  bool passToggle = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height/75;
    //  height/75 is   height = 10..

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentNode = FocusScope.of(context);
        if(currentNode.focusedChild != null && !currentNode.hasPrimaryFocus){
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //try and remove safe area once
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height *20,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.black87, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: const Center(
                    child: Text(
                      ' SIGN IN',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 2,
                        fontFamily: 'InknutAntiqua-Light',
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height:  height*9,
                ), // use mediaquery instead of giving height

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                      key: _formField,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: const Icon(Icons.email),
                            ),
                            validator: (value) {
                              final bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if (value.isEmpty) {
                                return 'Please enter email';
                              } else if (!emailValid) {
                                return ' Please enter valid email';
                              }
                            },
                          ),
                           SizedBox(
                            height: height*2,
                            //height: 10,
                          ),
                          TextFormField(
                            obscureText: passToggle,
                            controller: passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passToggle = !passToggle;
                                    });
                                  },
                                  child: Icon(passToggle
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else if (passwordController.text.length < 6) {
                                return 'Password length should be more than 6 characters';
                              }
                            },
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: height*20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 0,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                      right: 0,
                      top: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (_formField.currentState!.validate()) {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      elevation: 13,
                                      content: Text('signing in')));
                              await Auth().SignInWithFirebase(
                                  emailController.text, passwordController.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      elevation: 13, content: Text('signed in')));
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('back'))
                                    ],
                                    title: const Text(
                                        'No user found for that email'),
                                  ),
                                );
                              } else if (e.code == 'wrong-password') {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('back'))
                                    ],
                                    title: const Text(
                                        'Wrong password provided for this user'),
                                  ),
                                );
                              }
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('back'))
                                ],
                                title:
                                    const Text(' Please check your credentials '),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: height*4 ,
                          width: MediaQuery.of(context).size.width / 1.3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border:
                                Border.all(width: 1, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              ' Log In ',
                              style: TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Create an account?',
                            style: TextStyle(fontSize: 15),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: const Text(
                                ' Sign Up',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
