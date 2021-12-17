import 'package:flutter/material.dart';
import 'package:vendors_app/app/email_sign_form.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading=false;

  double pH(double height) {
    return MediaQuery.of(context).size.height * (height / 896);
  }

  double pW(double width) {
    return MediaQuery.of(context).size.width * (width / 414);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'images/petmet-appbar-logo.png',
                width: pW(171),
                height: pH(63),
              ),
              Container(
                width: pW(204.48),
                height: pH(216.25),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/sign_in_page.png'),
                    fit: BoxFit.fill,
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: EmailSignInForm.create(context),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
