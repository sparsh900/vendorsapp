import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendors_app/app/account.dart';
import 'package:vendors_app/app/home.dart';
import 'package:vendors_app/app/previous.dart';
import 'package:vendors_app/app/upcoming.dart';
import 'package:vendors_app/services/database.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({@required this.database});
  final Database database;
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool _isLoading = false;

  double pH(double height) {
    return MediaQuery.of(context).size.height * (height / 896);
  }

  double pW(double width) {
    return MediaQuery.of(context).size.width * (width / 414);
  }

  Future<void> _checkVerification() async {
    setState(() {
      _isLoading = true;
    });
    if (await widget.database.checkVetVerification()) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomePage(
              database: widget.database,
            ),
          ),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(pH(70.0)),
          child: AppBar(
            brightness: Brightness.light,
            backgroundColor: Color(0xFFD7F6FF),
            title: Padding(
                padding:
                    EdgeInsetsDirectional.fromSTEB(pW(20), pH(43), 0, pH(25)),
                child: Image.asset('images/petmet-logo.png', height: pH(32))),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Your Verification is in Progress',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.green,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 20),
            if (_isLoading == false)
              FlatButton(
                padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 11),
                color: Color.fromRGBO(54, 169, 204, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'RETRY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: _checkVerification,
              ),
            if (_isLoading) Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
