import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vendors_app/app/account.dart';
import 'package:vendors_app/app/previous.dart';
import 'package:vendors_app/app/upcoming.dart';
import 'package:vendors_app/services/database.dart';

import 'models/vet.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.database});
  final Database database;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  double pH(double height) {
    return MediaQuery.of(context).size.height * (height / 896);
  }

  double pW(double width) {
    return MediaQuery.of(context).size.width * (width / 414);
  }

  @override
  void initState() {

    super.initState();
    _notificationsSetup(widget.database);
  }

  Future<void> _setDeviceToken(Database database)
  async {
    var deviceTokenLocal = await _fcm.getToken();
    Vet vet= await database.getVet();
    await database.updateDeviceToken(vet, deviceTokenLocal);
  }

  Future<void> _notificationsSetup(Database database) async {
    var _status = await Permission.notification.status;
    if(_status.isUndetermined)
    {
      _fcm.requestNotificationPermissions();
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        if(message['notification']['title']!=null) {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  content: ListTile(
                    title: Text(message['notification']['title']),
                    subtitle: Text(message['notification']['body']),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
          );
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );

    _setDeviceToken(database);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(pH(120.0)),
            child: AppBar(
              backgroundColor: Color(0xFFD7F6FF),
              brightness: Brightness.light,
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(pW(20), pH(43), 0, pH(25)),
                child: Image.asset('images/petmet-logo.png',height: pH(32))),
                bottom: new TabBar(
                    tabs: <Tab>[
                      new Tab(child: Text('UPCOMING',style: TextStyle(color: Colors.black),)),
                      new Tab(child: Text('PREVIOUS',style: TextStyle(color: Colors.black),)),
                      new Tab(child: Text('ACCOUNT',style: TextStyle(color: Colors.black),)),
                    ],
                  indicatorColor: Colors.black,
                )
            ),
          ),
          body: TabBarView(
            children: [
              UpcomingPage(database: widget.database,),
              PreviousPage(database: widget.database,),
              AccountPage(database: widget.database,),
            ],
          ),
        ),
      ),
    );
  }
}
