import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void _showSocialRegisterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Register using'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.facebook, color: Colors.blue),
              title: Text('Facebook'),
              onTap: () {
                // Handle Facebook registration
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.linked_camera, color: Colors.blueAccent),
              title: Text('LinkedIn'),
              onTap: () {
                // Handle LinkedIn registration
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text('Google'),
              onTap: () {

                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.alternate_email, color: Colors.lightBlue),
              title: Text('Twitter'),
              onTap: () {
                // Handle Twitter registration
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

  Future<User?> signInWithGoogle(BuildContext context) async {


    try {
      debugPrint("sign in start");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        debugPrint('USER IS NULL');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      // user details add to firebase
      if (user != null) {
        String? email = user.email;
        String? phone = user.phoneNumber;
        String? name = user.displayName;




        {
          // await addUserToFirebase(user, email!, phone!, name!);
        }
      }

      return user;
    } catch (e) {
      debugPrint("ERROR GOT : $e");
      return null;
    }
  }

// logout
  Future<void> signOut() async {
    // await _auth.signOut();
    await GoogleSignIn().signOut();
    }
}
