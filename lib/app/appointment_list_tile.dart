import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:vendors_app/app/inner_info.dart';
import 'package:vendors_app/app/models/appointment.dart';
import 'package:vendors_app/app/models/pet.dart';
import 'package:vendors_app/app/models/user.dart';
import 'package:vendors_app/main.dart';
import 'package:vendors_app/services/database.dart';

class AppointmentListTile extends StatefulWidget {
  AppointmentListTile({@required this.appointment, @required this.database});
  final Database database;
  final Appointment appointment;
  @override
  _AppointmentListTileState createState() => _AppointmentListTileState();
}

class _AppointmentListTileState extends State<AppointmentListTile> {
  bool button = false;
  Pet pet;
  UserData patient;

  double pH(double height) {
    return MediaQuery.of(context).size.height * (height / 896);
  }

  double pW(double width) {
    return MediaQuery.of(context).size.width * (width / 412);
  }

  Future<void> _getPet() async {
    final petTemp = await widget.database
        .getPet(widget.appointment.patientId, widget.appointment.petName);
    if(mounted)
      {
        setState(() {
          pet = petTemp;
        });
      }
  }

  Future<void> _getPatient() async {
    final patientTemp =
        await widget.database.getPatient(widget.appointment.patientId);
    if(mounted)
      {
        setState(() {
          patient = patientTemp;
        });
      }
  }

  Widget _verticalWord(String mode) {
    if (mode == "HomeVisit") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'H',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'O',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'M',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'E',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            ' ',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'V',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'I',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'S',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'I',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'T',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
        ],
      );
    }
    if (mode == "VideoCall") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'V',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'I',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'D',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'E',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'O',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            ' ',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'C',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'A',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'L',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'L',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
        ],
      );
    }
    if (mode == "VisitClinic") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'C',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'L',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'I',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'N',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'I',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'C',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            ' ',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'V',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'I',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'S',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'I',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'T',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
        ],
      );
    }
    if (mode == "Chat") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'C',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            ' ',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'H',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            ' ',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'A',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            ' ',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
          Center(
              child: Text(
            'T',
            style: TextStyle(fontSize: 11, color: Colors.white),
          )),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _getPet();
    _getPatient();
    if (pet != null && patient != null) {
      return GestureDetector(
        onTap: () {
          setState(() {
            button = true;
          });
        },
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(pW(16), pW(18), pW(12), 0),
          child: Stack(children: [
            Container(
              width: pW(383),
              height: pH(190),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(7),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(1.0, 6.0),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Column(
                children: [
                  /*Container(
                        width: pW(383),
                        height: pH(28),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7)),
                          color: Color(0xFF36A9CC),
                        ),
                        child: Center(
                          child: Text(
                            "${widget.appointment.mode}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: pH(20),
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Roboto',

                              //letterSpacing: 4
                            ),
                          ),
                        ),
                      ),*/
                  Row(
                    children: [
                      Container(
                        width: pW(21),
                        height: pH(190),
                        color: petColor,
                        child: _verticalWord(widget.appointment.mode),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            pW(16), pH(15), pW(11), pH(16)),
                        child:
                            Stack(alignment: Alignment.bottomCenter, children: [
                          GestureDetector(
                            onTap: () =>
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => InnerAppointmentPage(
                                database: widget.database,
                                appointment: widget.appointment,
                                pet: pet,
                                patient: patient,
                              ),
                            )),
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: pet.image == null
                                    ? Image.asset(
                                        'images/sample1.jpg',
                                        fit: BoxFit.cover,
                                        width: pW(96),
                                        height: pH(126),
                                      )
                                    : Image.network(
                                        pet.image,
                                        fit: BoxFit.cover,
                                        width: pW(96),
                                        height: pH(126),
                                      ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: pH(26),
                              width: pW(96),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.39),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6)),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  pet.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: pH(16),
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                    //letterSpacing: 4
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0, pH(18), 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, pH(2)),
                              child: Text(
                                pet.breed,
                                style: TextStyle(
                                  fontSize: pH(16),
                                  color: Color(0xFF868686),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Roboto',
                                  //letterSpacing: 4
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, pH(21)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${pet.age} Yrs",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: pH(13),
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                    //letterSpacing: 4
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, pH(7)),
                              child: Text(
                                "${widget.appointment.time} (IST), ${widget.appointment.date}",
                                style: TextStyle(
                                  fontSize: pH(18),
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Roboto',
                                  //letterSpacing: 4
                                ),
                              ),
                            ),
                            if (widget.appointment.mode == 'HomeVisit' &&
                                patient != null)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, pH(2)),
                                child: Text(
                                  patient.address,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: pH(16),
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                    //letterSpacing: 4
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            if (widget.appointment.status == 'pending')
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  children: [
                    Container(
                      height: pH(27),
                      width: pW(120),
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
                                  onPressed: () => Navigator.of(context).pop(false),
                                ),
                                PlatformDialogAction(
                                  child: PlatformText('Decline'),
                                  onPressed: () => Navigator.of(context).pop(true),
                                ),
                              ],
                            ),
                          );
                          if(_userInput == true)
                            {
                              widget.database.updateAppointment(
                                  widget.appointment, "declined");
                            }
                        },
                        child: Text('Decline',
                            style: TextStyle(
                              fontSize: pH(17),
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Roboto',
                            )),
                        textColor: Colors.white,
                      ),
                    ),
                    Container(
                      height: pH(27),
                      width: pW(120),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color(0xFF03A300),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        onPressed: () {
                          widget.database.updateAppointment(
                              widget.appointment, "accepted");
                        },
                        child: Text('Accept',
                            style: TextStyle(
                              fontSize: pH(17),
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
            if (widget.appointment.status == 'accepted')
              Positioned(
                  bottom: pH(8),
                  right: pW(16),
                  child: Text(
                    "You Accepted the request",
                    style: TextStyle(
                      fontSize: pH(16),
                      color: Color(0xFF03A300),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Roboto',
                      //letterSpacing: 4
                    ),
                  )),
            if (widget.appointment.status == 'confirmed')
              Positioned(
                  bottom: pH(8),
                  right: pW(16),
                  child: Text(
                    "Appointment is confirmed",
                    style: TextStyle(
                      fontSize: pH(16),
                      color: Color(0xFF03A300),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Roboto',
                      //letterSpacing: 4
                    ),
                  )),
          ]),
        ),
      );
    } else {
      return Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: CircularProgressIndicator(),
      ));
    }
  }
}
