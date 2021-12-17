import 'dart:io';

import 'package:flutter/material.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendors_app/app/inner_info.dart';
import 'package:vendors_app/app/landing_page.dart';
import 'package:vendors_app/app/notification.dart';
import 'package:vendors_app/services/auth.dart';
import 'package:vendors_app/services/database.dart';


class AccountPage extends StatefulWidget {
  AccountPage({@required this.database});
  final Database database;
  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {

  RateMyApp rateMyApp = RateMyApp(
    googlePlayIdentifier: 'com.petmet.vendors_app',
  );

  double pH(double height) {
    return MediaQuery.of(context).size.height * (height / 896);
  }

  double pW(double width) {
    return MediaQuery.of(context).size.width * (width / 414);
  }

  navigateToPage(BuildContext context, String page) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(page, (Route<dynamic> route) => false);
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          LandingPage()), (Route<dynamic> route) => false);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final _userInput = await showPlatformDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PlatformAlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to Logout?'),
        actions: <Widget>[
          PlatformDialogAction(
            child: PlatformText('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          PlatformDialogAction(
            child: PlatformText('Logout'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    if (_userInput == true) {
      _signOut(context);
    }
  }

  _launchURL() async {
    const url = 'https://petmet.co.in';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _rateApp(){
    rateMyApp.showStarRateDialog(
      context,
      title: 'Rate Petmet app', // The dialog title.
      message: 'You like this app ? Then take a little bit of your time to leave a rating :', // The dialog message.
      // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
      actionsBuilder: (context, stars) { // Triggered when the user updates the star rating.
        return [ // Return a list of actions (that will be shown at the bottom of the dialog).
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () async {
              Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.no);
            },
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () async {
              print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
              // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
              // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
              await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
              Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
            },
          ),
        ];
      },
      ignoreNativeDialog: Platform.isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
      dialogStyle: DialogStyle( // Custom dialog styles.
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions: StarRatingOptions(), // Custom star bar rating options.
      onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: Color(0xFFBDBDBD),
                      width: 1,
                    )
                  )
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(pW(30), pH(36), 0, pH(16)),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => NotificationsPage(database: widget.database,),
                      ));
                    },
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: pH(22),
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                        //letterSpacing: 4
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        bottom: BorderSide(
                          color: Color(0xFFBDBDBD),
                          width: 1,
                        )
                    )
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(pW(30), pH(24), 0, pH(16)),
                  child: InkWell(
                    onTap: _launchURL,
                    child: Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: pH(22),
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                        //letterSpacing: 4
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        bottom: BorderSide(
                          color: Color(0xFFBDBDBD),
                          width: 1,
                        )
                    )
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(pW(30), pH(24), 0, pH(16)),
                  child: InkWell(
                    onTap: _launchURL,
                    child: Text(
                      "Need Help?",
                      style: TextStyle(
                        fontSize: pH(22),
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                        //letterSpacing: 4
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(pW(30), pH(32), 0, pH(24)),
                  child: InkWell(
                    onTap: () async {
                      final Email email = Email(
                        body: 'Type Feedback Here',
                        subject: 'Feedback for PetMet Vendors App',
                        recipients: ['info.petmet@gmail.com'],
                        isHTML: false,
                      );

                      await FlutterEmailSender.send(email);
                    },
                    child: Text(
                      "Send Feedback",
                      style: TextStyle(
                        fontSize: pH(18),
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                        //letterSpacing: 4
                      ),
                    ),
                  ),
                ),
              ),
              //Will add after app store push
              // Container(
              //   child: Padding(
              //     padding: EdgeInsetsDirectional.fromSTEB(pW(30), pH(0), 0, pH(24)),
              //     child: InkWell(
              //       onTap: _rateApp,
              //       child: Text(
              //         Platform.isIOS?"Rate us on App Store":"Rate us on Play Store",
              //         style: TextStyle(
              //           fontSize: pH(18),
              //           color: Color(0xFF757575),
              //           fontWeight: FontWeight.w400,
              //           fontStyle: FontStyle.normal,
              //           fontFamily: 'Roboto',
              //           //letterSpacing: 4
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(pW(30), pH(0), 0, pH(24)),
                  child: InkWell(
                    onTap: () => _confirmSignOut(context),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: pH(18),
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                        //letterSpacing: 4
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}