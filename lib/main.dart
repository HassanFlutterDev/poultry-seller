// ignore_for_file: prefer_is_empty

import 'package:poultry_pal_seller/const/const.dart';
import 'package:poultry_pal_seller/firebase_options.dart';
import 'package:poultry_pal_seller/views/auth_screen/login_screen.dart';
import 'package:poultry_pal_seller/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  var isLoggedin = false;

  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        isLoggedin = false;
      } else {
        isLoggedin = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      home: isLoggedin ? const Home() : const LoginScreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
  }
}

ratings(List star1, List star2, List star3, List star4, List star5) {
  if (star2.length > star1.length &&
      star2.length > star3.length &&
      star2.length > star4.length &&
      star2.length > star5.length) {
    return 2.0;
  } else if (star1.length > star2.length &&
      star1.length > star3.length &&
      star1.length > star4.length &&
      star1.length > star5.length) {
    return 1.0;
  } else if (star3.length > star2.length &&
      star3.length > star1.length &&
      star3.length > star4.length &&
      star3.length > star5.length) {
    return 3.0;
  } else if (star4.length > star3.length &&
      star4.length > star1.length &&
      star4.length > star2.length &&
      star4.length > star5.length) {
    return 4.0;
  }
  if (star5.length > star3.length &&
      star5.length > star2.length &&
      star5.length > star4.length &&
      star5.length > star1.length) {
    return 5.0;
  } else {
    return 0.0;
  }
  // ignore: dead_code
  if (star1.length != 0 && star2.length != 0) {
    if (star1.length == star2.length) {
      return 1.0;
    }
  } else if (star2.length != 0 && star3.length != 0) {
    if (star2.length == star3.length) {
      return 2.0;
    }
  } else if (star3.length != 0 && star1.length != 0) {
    if (star3.length == star1.length) {
      return 3.0;
    }
  } else if (star4.length != 0 && star2.length != 0) {
    if (star4.length == star2.length) {
      return 4.0;
    } else if (star4.length != 0 && star3.length != 0) {
      if (star4.length == star3.length) {
        return 4.0;
      }
    } else if (star4.length != 0 && star1.length != 0) {
      if (star4.length == star1.length) {
        return 4.0;
      }
    } else if (star5.length != 0 && star2.length != 0) {
      if (star5.length == star2.length) {
        return 5.0;
      }
    } else if (star5.length != 0 && star4.length != 0) {
      if (star5.length == star4.length) {
        return 4.0;
      }
    } else if (star5.length != 0 && star3.length != 0) {
      if (star5.length == star3.length) {
        return 4.0;
      }
    } else if (star5.length != 0 && star1.length != 0) {
      if (star5.length == star1.length) {
        return 5.0;
      }
    }
  } else {
    return 0.0;
  }
}
