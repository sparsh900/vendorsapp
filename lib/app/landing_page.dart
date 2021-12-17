import 'package:flutter/material.dart';
import 'package:vendors_app/app/home.dart';
import 'package:vendors_app/app/sign_in_page.dart';
import 'package:vendors_app/app/vetform/vet_form.dart';
import 'package:vendors_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:vendors_app/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage();
          } else {
            print(user.uid);
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: Vetform(email: user.email),
            ); // placeholder
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
