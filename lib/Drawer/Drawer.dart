import 'package:expenseapp/Auth/Auth.dart';
import 'package:expenseapp/SignIn_SignUp/sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  //String? displayLoginUsername;
  String? loginUsername;
  Future getDisplayName() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      //  displayLoginUsername = prefs.getString(FirebaseAuth.instance.currentUser!.displayName!);
      loginUsername = prefs.getString('theusername');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDisplayName();
  }

  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    print(firebaseUser.displayName.toString());
    //print(displayLoginUsername);

    return Drawer(
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.zero,
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            borderSide: BorderSide.none),
        width: 240,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(10)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/mountain.jpg'))),
              currentAccountPicture: Stack(children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/drop.jpg'),
                ),
                Positioned(
                  top: 38,
                  left: 38,
                  child: IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        print(file?.path);
                      },
                      icon: Icon(Icons.camera)),
                )
              ]),
              accountName: Text(
                '${loginUsername ?? firebaseUser.displayName}',
                style: TextStyle(color: Colors.grey[250]),
                overflow: TextOverflow.ellipsis,
              ),
              accountEmail: Text(
                firebaseUser.email.toString(),
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
              onDetailsPressed: () {
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
                      title: const Text('your username and email'),
                    );
                  },
                );
              },
              arrowColor: Colors.white70,
            ),
            const SizedBox(height: 1),
            foodItemListtile(),
            ordersListtile(),
            connectListtile(),
            const Divider(),
            //log out
            ListTile(
              onTap: () async {
                await Auth().LogOutFirebaseAccount();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SignIn()));
              },
              leading: const CircleAvatar(
                backgroundColor: Colors.lightGreen,
                radius: 15,
                child: Text('L', style: TextStyle(color: Colors.black)),
              ),
              title:
                  const Text(' LogOut ', style: TextStyle(color: Colors.black)),
            ),
            //delete the user from the firebase console
            ListTile(
              onTap: () async {
                await firebaseUser.delete();
                var prefs = await SharedPreferences.getInstance();
                prefs.clear();
                await GoogleSignIn().signOut();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SignIn()));
              },
              leading: const CircleAvatar(
                backgroundColor: Colors.lightGreen,
                radius: 15,
                child: Text('D', style: TextStyle(color: Colors.black)),
              ),
              title: const Text(' Delete Account ',
                  style: TextStyle(color: Colors.black)),
            )
          ],
        ));
  }

  foodItemListtile() {
    return ListTile(
      onTap: () {
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
              title: const Text('add food items from homepage'),
            );
          },
        );
      },
      leading: const CircleAvatar(
        backgroundColor: Colors.blueGrey,
        radius: 15,
        child: Text('F'),
      ),
      title: const Text(' Food Item ', style: TextStyle(color: Colors.black)),
    );
  }

  ordersListtile() {
    return ListTile(
      onTap: () {
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
            title: const Text('try to keep expenses under 200 per day'),
          ),
        );
      },
      leading: const CircleAvatar(
        backgroundColor: Colors.teal,
        radius: 15,
        child: Text('E', style: TextStyle(color: Colors.black)),
      ),
      title: const Text(' Expenses ', style: TextStyle(color: Colors.black)),
    );
  }

  connectListtile() {
    return ListTile(
      onTap: () {
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
            title: const Text('email: ichbinashutosh.k@gmail.com'),
          ),
        );
      },
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 15,
        child: Text(
          'C',
          style: TextStyle(color: Colors.black),
        ),
      ),
      title: const Text(' Connect ', style: TextStyle(color: Colors.black)),
    );
  }
}
