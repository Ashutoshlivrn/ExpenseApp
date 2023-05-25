import 'package:expenseapp/Auth/Auth.dart';
import 'package:expenseapp/pages/home_page.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formField = GlobalKey<FormState>();
  bool passwordToggle = true;
  bool repeatpasswordToggle = true;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatpasswordController = TextEditingController();
  final phoneController = TextEditingController();

  void myalertdialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('back'))
            ],
            title: const Text('Check your credentials'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height/80;
    //  height/80 is   height = 10..
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentNode = FocusScope.of(context);
        if(currentNode.focusedChild != null && !currentNode.hasPrimaryFocus){
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //sign up container
                Container(
                  height: height * 20,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.black87, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: const Center(
                    child: Text(
                      ' SIGN UP',
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
                  height: height *2,
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                      key: formField,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //username
                          TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: const Icon(Icons.account_circle),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email';
                              } else if (value.length >= 25) {
                                return 'Enter Valid Name';
                              }
                            },
                          ),
                          SizedBox(
                            height: height*2,
                          ),
                          //email
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              final bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if (value.isEmpty) {
                                return 'Enter Email';
                              } else if (!emailValid) {
                                return 'Enter Valid Email';
                              }
                            },
                          ),
                          SizedBox(
                            height: height*2,
                          ),
                          //phone number
                          TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              prefixIcon: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (phoneController.text.length < 10) {
                                return 'check your phone number';
                              }
                            },
                          ),
                          SizedBox(
                            height: height*2,
                          ),
                          //password
                          TextFormField(
                            obscureText: passwordToggle,
                            controller: passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passwordToggle = !passwordToggle;
                                    });
                                  },
                                  child: Icon(passwordToggle
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else if (passwordController.text.length < 6) {
                                return 'Password should be more than 6 characters';
                              }
                            },
                          ),
                          SizedBox(
                            height: height*2,
                          ),
                          //re[eat
                          TextFormField(
                            obscureText: repeatpasswordToggle,
                            controller: repeatpasswordController,
                            decoration: InputDecoration(
                                labelText: 'Repeat Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      repeatpasswordToggle =
                                          !repeatpasswordToggle;
                                    });
                                  },
                                  child: Icon(repeatpasswordToggle
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else if (repeatpasswordController.text.length <
                                  6) {
                                return 'Password should be more than 6 characters';
                              }
                            },
                          ),
                          SizedBox(
                            height: height*3,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom + 10,
                                right: 0,
                                top: 0),
                            child: Column(
                              children: [
                                //sign up button
                                InkWell(
                                  onTap: () async {
                                    //  String displayname = await firebaseAuth.updateDisplayName(userNameController.text).toString();
                                    if (formField.currentState!.validate() &&
                                        (passwordController.text ==
                                            repeatpasswordController.text)) {
                                      //sign up with firebase
                                      Auth().CreateFirebaseAccount(
                                          emailController.text,
                                          passwordController.text);
                                      // var firebaseUserName = await FirebaseAuth.instance.currentUser!.displayName;
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      // prefs.setString('UserDisplayName', userNameController.text  );
                                      await prefs.setString(
                                          'theusername', userNameController.text);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                                    } else {
                                      myalertdialog();
                                    }
                                  },
                                  child: Container(
                                    height: height*4,
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      border: Border.all(
                                          width: 1, color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        ' Sign Up ',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                 SizedBox(
                                  height: height*3,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '---------------------',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      'Or continue with',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                    Text(
                                      '---------------------',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height*2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child:
                                            Image.asset('assets/googleimage.png'),
                                      ),
                                      onTap: () async {
                                        try {
                                          await Auth().signInWithGoogle();
                                          var prefs = await SharedPreferences
                                              .getInstance();
                                          await prefs.clear();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text('logged in')));
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  elevation: 13,
                                                  content: Text('can\'t login')));
                                        }
                                      },
                                    ),
                                    InkWell(
                                      onTap: () => ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              elevation: 13,
                                              content: Text('Not Available'))),
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset('assets/phone.jpg'),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                 SizedBox(
                  height: height,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
