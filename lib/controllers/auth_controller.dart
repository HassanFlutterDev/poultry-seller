import 'package:poultry_pal_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  //text controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Define the specific email and password you want to allow for login.
  final String allowedEmail = "admin123@gmail.com";
  final String allowedPassword = "654321";

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    try {
      // Check if the entered email and password match the allowed credentials.
      if (emailController.text == allowedEmail &&
          passwordController.text == allowedPassword) {
        final UserCredential userCredential =
            await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        return userCredential;
      } else {
        // Show an error message for invalid credentials.
        VxToast.show(context, msg: "Invalid email or password.");
        return null; // Return null to indicate that the login failed
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      return null; // Return null to indicate that the login failed
    }
  }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
