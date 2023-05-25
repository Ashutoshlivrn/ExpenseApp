import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  var firebaseauth = FirebaseAuth.instance;
  //var currentUser = FirebaseAuth.instance.currentUser?.email ;

  // sign in with email password
  SignInWithFirebase(String email, String password) async {
    await firebaseauth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //create username and password for user
  CreateFirebaseAccount(String email, String password) async {
    await firebaseauth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // delete the user
  LogOutFirebaseAccount() async {
    await firebaseauth.signOut();
  }

  // sign in with phone
  SignInWithPhoneNumber(String phonenumber) {
    firebaseauth.signInWithPhoneNumber(phonenumber);
  }

  // sign in with Google
  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
