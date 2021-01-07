import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    // final LoginResult result = await FacebookAuth.instance.login();

    // // Create a credential from the access token
    // final FacebookAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(result.accessToken.token);

    // // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance
    //     .signInWithCredential(facebookAuthCredential);
  }
}
