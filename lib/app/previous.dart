import 'package:flutter/material.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/cupertino.dart';
import 'package:vendors_app/app/models/appointment.dart';
import 'package:vendors_app/app/previous_appointment_list_tile.dart';
import 'package:vendors_app/services/database.dart';
import 'package:vendors_app/services/list_items_builder.dart';


class PreviousPage extends StatefulWidget {
  PreviousPage({@required this.database});
  final Database database;
  @override
  PreviousPageState createState() => PreviousPageState();
}

class PreviousPageState extends State<PreviousPage> {
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
  final List<String> breeds = <String>["Labrador","Labrador","Labrador","Labrador","Labrador","Labrador"];
  final List<String> role = <String>["HOME VISIT","CLINIC VISIT","VIDEO CALL","HOME VISIT","CLINIC VISIT","VIDEO CALL"];
  final List<int> colorCodes = <int>[100, 200, 300, 400, 500, 600];
  final List<int> life = <int>[1, 2, 3, 4, 5, 6];
  final List<bool> address = <bool>[true, false, false, true, false, false];
  final List<bool> button = <bool>[false, false, false, false, false, false];
  final List<String> type = <String>["HOME VISIT","CLINIC VISIT","VIDEO CALL","HOME VISIT","CLINIC VISIT","VIDEO CALL"];
  /*bool button1=false;
  bool button2=false;
  bool button3=false;*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
              color: Color(0xFFE5E5E5)
          ),
          child: _buildContent(context),
        ),

      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<Appointment>>(
      stream: widget.database
          .appointmentsStream(), // define stream coming from database , make sure it's type is List<SlotModel>
      builder: (context, snapshot) {
        return ListItemBuilder(
          showDivider: false,
            snapshot: snapshot,
            itemBuilder: (context, appointment) {
              if (appointment.status == 'cancelled' || appointment.status == 'declined' || appointment.status == 'complete') {
                return PreviousAppointmentListTile(
                  appointment: appointment,
                  database: widget.database,
                );
              }
              else{
                return Container();
              }
            });
      },
    );
  }
}



