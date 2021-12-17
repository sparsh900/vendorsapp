import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:vendors_app/app/models/appointment.dart';
import 'package:vendors_app/app/models/pet.dart';
import 'package:vendors_app/app/models/user.dart';
import 'package:vendors_app/services/database.dart';

class InnerAppointmentPage extends StatefulWidget {
  InnerAppointmentPage(
      {@required this.appointment,
      @required this.database,
      @required this.pet,
      @required this.patient});
  final Appointment appointment;
  final Database database;
  final Pet pet;
  final UserData patient;

  InnerAppointmentPageState createState() => InnerAppointmentPageState();
}

class InnerAppointmentPageState extends State<InnerAppointmentPage> {
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final int type = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(pH(57.0)), // here the desired height
        child: AppBar(
          backgroundColor: Color((0xFF36A9CC)),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back,
                size: 22, color: Color(0xFFFFFFFF)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.appointment.mode,
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontFamily: 'Roboto',
                letterSpacing: 1.5),
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          color: Color(0xFFFFFFFF),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: pH(320),
                alignment: Alignment.bottomLeft,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: widget.pet.image == null
                        ? AssetImage('images/sample1.jpg')
                        : NetworkImage(widget.pet.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          bottom: BorderSide(
                    color: Color(0xFF868686),
                    width: 1,
                  ))),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        pW(24), pH(14), pW(20), 0),
                    child: Wrap(
                      children: [
                        Container(
                          width: pW(123),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, pH(8), 0, pH(7)),
                                child: Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: pH(16),
                                    color: Color(0xFF868686),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, pH(20)),
                                child: Text(
                                  widget.pet.name,
                                  style: TextStyle(
                                    fontSize: pH(26),
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: pW(123),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, pH(8), 0, pH(7)),
                                child: Text(
                                  "Breed",
                                  style: TextStyle(
                                    fontSize: pH(16),
                                    color: Color(0xFF868686),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, pH(20)),
                                child: Text(
                                  widget.pet.breed,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: pH(26),
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: pW(123),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, pH(8), 0, pH(7)),
                                child: Text(
                                  "Animal",
                                  style: TextStyle(
                                    fontSize: pH(16),
                                    color: Color(0xFF868686),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, pH(20)),
                                child: Text(
                                  widget.pet.category,
                                  style: TextStyle(
                                    fontSize: pH(26),
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: pW(123),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, pH(8), 0, pH(7)),
                                child: Text(
                                  "Gender",
                                  style: TextStyle(
                                    fontSize: pH(16),
                                    color: Color(0xFF868686),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, pH(20)),
                                child: Text(
                                  "M/F",
                                  style: TextStyle(
                                    fontSize: pH(26),
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: pW(123),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, pH(8), 0, pH(7)),
                                child: Text(
                                  "Age",
                                  style: TextStyle(
                                    fontSize: pH(16),
                                    color: Color(0xFF868686),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, pH(20)),
                                child: Text(
                                  "${widget.pet.age} Yrs",
                                  style: TextStyle(
                                    fontSize: pH(26),
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: pW(123),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, pH(8), 0, pH(7)),
                                child: Text(
                                  "Weight",
                                  style: TextStyle(
                                    fontSize: pH(16),
                                    color: Color(0xFF868686),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, pH(20)),
                                child: Text(
                                  "${widget.pet.weight} Kg",
                                  style: TextStyle(
                                    fontSize: pH(26),
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        bottom: BorderSide(
                  color: Color(0xFF868686),
                  width: 1,
                ))),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      pW(15), pH(27), pW(18), pH(26)),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, pW(17), 0),
                        child: Text(
                          "Time:",
                          style: TextStyle(
                            fontSize: pH(16),
                            color: Color(0xFF868686),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                      Text(
                        "5 PM (IST), 10th October",
                        style: TextStyle(
                          fontSize: pH(24),
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.appointment.mode == "HomeVisit")
                Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          bottom: BorderSide(
                    color: Color(0xFF868686),
                    width: 1,
                  ))),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        pW(15), pH(27), pW(18), pH(26)),
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, pW(17), 0),
                          child: Text(
                            "Address:",
                            style: TextStyle(
                              fontSize: pH(16),
                              color: Color(0xFF868686),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.patient.address,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: pH(24),
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (widget.appointment.mode == "VideoCall" ||
                  widget.appointment.mode == "Chat")
                Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          bottom: BorderSide(
                    color: Color(0xFF868686),
                    width: 1,
                  ))),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        pW(15), pH(27), pW(18), pH(26)),
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, pW(17), 0),
                          child: Text(
                            "Email:",
                            style: TextStyle(
                              fontSize: pH(16),
                              color: Color(0xFF868686),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.patient.email,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: pH(24),
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (widget.appointment.status == "pending")
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                Container(
                  height: pH(60),
                  width: pW(207),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Color(0xFFFF5352),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    onPressed: () async {
                      final _userInput = await showPlatformDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => PlatformAlertDialog(
                          title: Text('Decline Appointment'),
                          content: Text('Are you sure you want to Decline?'),
                          actions: <Widget>[
                            PlatformDialogAction(
                              child: PlatformText('Cancel'),
                              onPressed: () =>
                                  Navigator.of(context).pop(false),
                            ),
                            PlatformDialogAction(
                              child: PlatformText('Decline'),
                              onPressed: () =>
                                  Navigator.of(context).pop(true),
                            ),
                          ],
                        ),
                      );
                      if (_userInput == true) {
                        widget.database.updateAppointment(
                            widget.appointment, "declined");
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Decline',
                        style: TextStyle(
                          fontSize: pH(22),
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Roboto',
                        )),
                    textColor: Colors.white,
                  ),
                ),
                Container(
                  height: pH(60),
                  width: pW(207),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Color(0xFF03A300),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    onPressed: () {
                      widget.database
                          .updateAppointment(widget.appointment, "accepted");
                      Navigator.of(context).pop();
                    },
                    child: Text('Accept',
                        style: TextStyle(
                          fontSize: pH(22),
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Roboto',
                        )),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        if (widget.appointment.status == "confirmed" &&
            widget.appointment.mode == "HomeVisit")
          Positioned(
            bottom: 0,
            child: Container(
              height: pH(60),
              width: pW(414),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Color(0xFF03A300),
              ),
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0, 0, pW(10), 0),
                      child: Icon(Icons.location_on),
                    ),
                    Text('LOCATE HOME',
                        style: TextStyle(
                          fontSize: pH(22),
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Roboto',
                        )),
                  ],
                ),
                textColor: Colors.white,
              ),
            ),
          ),
        if (widget.appointment.status == "completed")
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("DECLINED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: pH(22),
                    color: Color(0xFF03A300),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                  )),
            ),
          ),
        if (widget.appointment.status == "declined")
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("DECLINED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: pH(22),
                    color: Color(0xFFFF5352),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                  )),
            ),
          ),
        if (widget.appointment.status == "cancelled")
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("CANCELLED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: pH(22),
                    color: Color(0xFFFF5352),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                  )),
            ),
          ),
        if (widget.appointment.status == "accepted")
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("ACCEPTED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: pH(22),
                    color: Color(0xFF03A300),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                  )),
            ),
          ),
        if (widget.appointment.status == "confirmed" &&
            widget.appointment.mode == "VisitCLinic")
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("CONFIRMED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: pH(22),
                    color: Color(0xFF03A300),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                  )),
            ),
          ),
        if (widget.appointment.status == "confirmed" &&
            widget.appointment.mode == "VideoCall")
          Positioned(
            bottom: 0,
            child: Container(
              height: pH(60),
              width: pW(414),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Color(0xFF03A300),
              ),
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('JOIN VIDEO CALL',
                        style: TextStyle(
                            fontSize: pH(22),
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Roboto',
                            letterSpacing: 1)),
                  ],
                ),
                textColor: Colors.white,
              ),
            ),
          ),
        if (widget.appointment.status == "confirmed" &&
            widget.appointment.mode == "Chat")
          Positioned(
            bottom: 0,
            child: Container(
              height: pH(60),
              width: pW(414),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Color(0xFF03A300),
              ),
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('JOIN CHAT',
                        style: TextStyle(
                            fontSize: pH(22),
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Roboto',
                            letterSpacing: 1)),
                  ],
                ),
                textColor: Colors.white,
              ),
            ),
          ),
      ]),
    );
  }
}
