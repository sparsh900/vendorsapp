import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:vendors_app/app/home.dart';
import 'package:vendors_app/app/landing_page.dart';
import 'package:vendors_app/app/models/vet.dart';
import 'package:vendors_app/app/verification_page.dart';
import 'package:vendors_app/app/vetform/vets_input_location.dart';
import 'package:vendors_app/common_widgets/custom_image_picker.dart';
import 'package:vendors_app/common_widgets/show_error_dialog.dart';
import 'package:vendors_app/main.dart';
import 'package:vendors_app/services/auth.dart';
import 'package:vendors_app/services/database.dart';

class Vetform extends StatefulWidget {
  Vetform({this.vet, @required this.email});
  final Vet vet;
  final email;

  @override
  _VetformState createState() => _VetformState();
}

class _VetformState extends State<Vetform> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseMessaging _fcm = FirebaseMessaging();

  String _name;
  String _clinicName;
  String _mobileNumber;
  String _experience;
  String _address;
  String _city;
  String _state;
  String _pincode;
  String _gstin;
  String _qualification;
  String _achievements;
  File _image;
  String _imageUrl;
  File _clinicImage;
  String _clinicImageUrl;
  Map<dynamic, dynamic> _locationData;
  bool _isHomeVisit = false;
  bool _isVisitClinic = false;
  bool _isChat = false;
  bool _isVideo = false;
  bool _isVaccine = false, _isDeworming = false, _isConsultation = false;
  String _cost;

  bool _isLoading = true;

  final FocusNode _myFocusNode1 = FocusNode();
  final FocusNode _myFocusNode2 = FocusNode();
  final FocusNode _myFocusNode3 = FocusNode();
  final FocusNode _myFocusNode4 = FocusNode();
  final FocusNode _myFocusNode5 = FocusNode();
  final FocusNode _myFocusNode6 = FocusNode();
  final FocusNode _myFocusNode7 = FocusNode();
  final FocusNode _myFocusNode8 = FocusNode();
  final FocusNode _myFocusNode9 = FocusNode();
  final FocusNode _myFocusNode10 = FocusNode();
  final FocusNode _myFocusNode11 = FocusNode();
  final FocusNode _myFocusNode12 = FocusNode();
  final FocusNode _myFocusNode13 = FocusNode();

  double pH(double height) {
    return MediaQuery.of(context).size.height * (height / 896);
  }

  double pW(double width) {
    return MediaQuery.of(context).size.width * (width / 414);
  }

  Widget _decideProfilePhoto() {
    if (_image == null) {
      return Center(
        child: Text(
          '+',
          style: TextStyle(
              fontSize: 30,
              color: Color.fromRGBO(54, 169, 204, 1),
              fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _decideClinicPhoto() {
    if (_clinicImage == null) {
      return Center(
        child: Text(
          '+',
          style: TextStyle(
              fontSize: 30,
              color: Color.fromRGBO(54, 169, 204, 1),
              fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Container();
    }
  }

  Future<void> _setProfilePhoto() async {
    _image = await CustomImagePicker.show(context);
    setState(() {});
    print(_image);
  }

  Future<void> _setClinicPhoto() async {
    _clinicImage = await CustomImagePicker.show(context);
    setState(() {});
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LandingPage()),
          (Route<dynamic> route) => false);
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

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _myFocusNode1.dispose();
    _myFocusNode2.dispose();
    _myFocusNode3.dispose();
    _myFocusNode4.dispose();
    _myFocusNode5.dispose();
    _myFocusNode6.dispose();
    _myFocusNode7.dispose();
    _myFocusNode8.dispose();
    _myFocusNode9.dispose();
    _myFocusNode10.dispose();
    _myFocusNode11.dispose();
    _myFocusNode12.dispose();
    _myFocusNode13.dispose();

    super.dispose();
  }

  Future<bool> _checkVetData(Database database) async {
    if (await database.checkVetData()) {
      if (await database.checkVetVerification()) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => HomePage(
                      database: database,
                    )),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => VerificationPage(
                      database: database,
                    )),
            (Route<dynamic> route) => false);
      }
    }
    else
      {
        setState(() {
          _isLoading=false;
        });
      }
  }

  @override
  void initState() {
    Database _database = Provider.of<Database>(context, listen: false);
    _checkVetData(_database);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xE5E5E5),
            padding: EdgeInsetsDirectional.fromSTEB(pW(18), pH(72), pW(24), 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLogoBar(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, pH(21), 0, 22),
                      child: Center(
                        child: Text(
                          _isLoading?'Loading ...':'Fill in details below to register',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : _buildForm(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildLogoBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: 0,
          child: Icon(Icons.exit_to_app),
        ),
        Image.asset(
          'images/petmet-appbar-logo.png',
          width: pW(135),
          height: pH(50),
        ),
        InkWell(
          onTap: () => _confirmSignOut(context),
          child: Icon(Icons.exit_to_app, color: Colors.red),
        ),
      ],
    );
  }

  Form _buildForm() {
    final Database database = Provider.of<Database>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _name,
                    onSaved: (value) => _name =
                        value.substring(0, 1).toUpperCase() +
                            value.substring(1),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'Name can\'t be empty',
                    focusNode: _myFocusNode1,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode2),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Your Name',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _clinicName,
                    onSaved: (value) => _clinicName =
                        value.substring(0, 1).toUpperCase() +
                            value.substring(1),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'Clinic Name can\'t be empty',
                    focusNode: _myFocusNode2,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode3),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Clinic Name',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "+91",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _mobileNumber,
                    onSaved: (value) => _mobileNumber = "91" + value,
                    validator: (value) =>
                        value.length == 10 ? null : 'Enter valid Mobile Number',
                    focusNode: _myFocusNode3,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode5),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Enter Your Mobile Number',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    enabled: false,
                    initialValue: widget.email,
                    validator: (value) =>
                        value.contains('@') && value.contains(".")
                            ? null
                            : 'Enter Valid Email',
                    focusNode: _myFocusNode4,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode5),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Your Email',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _experience,
                    onSaved: (value) => _experience =
                        value.substring(0, 1).toUpperCase() +
                            value.substring(1),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'Experience can\'t be empty',
                    focusNode: _myFocusNode5,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode6),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Experience in Years',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _address,
                    onSaved: (value) => _address = value,
                    validator: (value) =>
                        value.isNotEmpty ? null : 'Address can\'t be empty',
                    focusNode: _myFocusNode6,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode7),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Clinic/Office Address',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _city,
                    onSaved: (value) => _city =
                        value.substring(0, 1).toUpperCase() +
                            value.substring(1),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'City can\'t be empty',
                    focusNode: _myFocusNode7,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode8),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'City',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _state,
                    onSaved: (value) => _state =
                        value.substring(0, 1).toUpperCase() +
                            value.substring(1),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'State can\'t be empty',
                    focusNode: _myFocusNode8,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode9),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'State',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _pincode,
                    onSaved: (value) => _pincode = value,
                    validator: (value) =>
                        value.length == 6 ? null : 'Enter Valid Pincode',
                    focusNode: _myFocusNode9,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode10),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Pincode',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _gstin,
                    onSaved: (value) => _gstin =
                        value.substring(0, 1).toUpperCase() +
                            value.substring(1),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'GSTIN can\'t be empty',
                    focusNode: _myFocusNode10,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode11),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'GSTIN',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _qualification,
                    onSaved: (value) => _qualification =
                        value.substring(0, 1).toUpperCase() +
                            value.substring(1),
                    validator: (value) => value.isNotEmpty
                        ? null
                        : 'Qualification can\'t be empty',
                    focusNode: _myFocusNode11,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode12),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Qualification',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _achievements,
                    onSaved: (value) => _achievements =
                        value.substring(0, 1).toUpperCase() +
                            value.substring(1),
                    validator: (value) => value.isNotEmpty
                        ? null
                        : 'Achievements can\'t be empty',
                    focusNode: _myFocusNode12,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_myFocusNode13),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Achievements',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Rs.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    initialValue: _cost,
                    onSaved: (value) => _cost = value,
                    validator: (value) => value.isNotEmpty
                        ? null
                        : 'Cost can\'t be empty',
                    focusNode: _myFocusNode13,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(54, 169, 204, 1),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                      EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle: TextStyle(fontSize: 15),
                      labelText: 'Enter Cost to patient',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, pH(22), 0, 0),
            child: Center(
              child: Text(
                'Add Photos for better Customer Responses',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, pH(22), 0, 0),
                    child: Center(
                      child: Text(
                        'Profile Photo',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: metColor),
                      ),
                    ),
                  ),
                  SizedBox(height: pH(21)),
                  InkWell(
                    onTap: _setProfilePhoto,
                    child: Container(
                      height: pH(94),
                      width: pH(94),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(229, 229, 229, 1),
                        borderRadius: BorderRadius.circular(4),
                        image: _image == null
                            ? null
                            : DecorationImage(
                                image: FileImage(_image),
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                      child: _decideProfilePhoto(),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, pH(22), 0, 0),
                    child: Center(
                      child: Text(
                        'Clinic Photo',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: metColor),
                      ),
                    ),
                  ),
                  SizedBox(height: pH(21)),
                  InkWell(
                    onTap: _setClinicPhoto,
                    child: Container(
                      height: pH(46.25 * 2),
                      width: pH(103.5 * 2),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(229, 229, 229, 1),
                        borderRadius: BorderRadius.circular(4),
                        image: _clinicImage == null
                            ? null
                            : DecorationImage(
                                image: FileImage(_clinicImage),
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                      child: _decideClinicPhoto(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: pH(21)),
          Container(
            color: Colors.grey[200],
            height: pH(30),
            padding: EdgeInsets.only(right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(
                    Icons.location_on,
                    color: petColor,
                  ),
                  Text(
                      _locationData == null
                          ? "Add address"
                          : _locationData['address'].toString().substring(0,
                              _locationData['address'].toString().indexOf(',')),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ]),
                Container(
                  margin: EdgeInsets.all(4),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: Border.all(color: petColor),
                  ),
                  child: RaisedButton(
                      color: Colors.white,
                      child: Text(
                        "Change",
                        style: TextStyle(color: petColor, fontSize: 12),
                      ),
                      onPressed: () {
                        navigateAndDisplay(context);
                      }),
                ),
              ],
            ),
          ),
          Container(
            height: pH(620),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  color: petColor,
                  child: ListTile(
                    title: Text(
                      'Select Modes',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    leading: Icon(
                      Icons.assignment_ind,
                      color: Colors.white,
                    ),
                  ),
                ),
                SwitchListTile(
                  onChanged: (bool value) {
                    setState(() {
                      _isVisitClinic = value;
                    });
                  },
                  value: _isVisitClinic,
                  title: Text('Clinic Visit'),
                ),
                SwitchListTile(
                  onChanged: (bool value) {
                    setState(() {
                      _isHomeVisit = value;
                    });
                  },
                  value: _isHomeVisit,
                  title: Text('Home Visit'),
                ),
                SwitchListTile(
                  onChanged: (bool value) {
                    setState(() {
                      _isChat = value;
                    });
                  },
                  value: _isChat,
                  title: Text('Chat'),
                ),
                SwitchListTile(
                  onChanged: (bool value) {
                    setState(() {
                      _isVideo = value;
                    });
                  },
                  value: _isVideo,
                  title: Text('Video Call'),
                ),
                Container(
                  color: petColor,
                  child: ListTile(
                    title: Text(
                      'Select Services',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    leading: Icon(
                      Icons.assignment_ind,
                      color: Colors.white,
                    ),
                  ),
                ),
                SwitchListTile(
                  onChanged: (bool value) {
                    setState(() {
                      _isConsultation = value;
                    });
                  },
                  value: _isConsultation,
                  title: Text('Consultation'),
                ),
                SwitchListTile(
                  onChanged: (bool value) {
                    setState(() {
                      _isVaccine = value;
                    });
                  },
                  value: _isVaccine,
                  title: Text('Vaccine'),
                ),
                SwitchListTile(
                  onChanged: (bool value) {
                    setState(() {
                      _isDeworming = value;
                    });
                  },
                  value: _isDeworming,
                  title: Text('Deworming'),
                ),
              ],
            ),
          ),
          SizedBox(height: pH(80)),
          Row(children: [
            Expanded(
              child: FlatButton(
                padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 11),
                color: Color.fromRGBO(54, 169, 204, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'SAVE & PROCEED',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () => _submit(database),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  //Form Business logic

  navigateAndDisplay(BuildContext context) async {
    final Map<String, dynamic> locationData =
        await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => InputLocation(),
    ));
    print(locationData);
    if (locationData != null) {
      setState(() {
        _locationData = locationData;
      });
    }
  }

  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  bool validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> _uploadProfilePhoto() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('vetImages/${_gstin}Profile');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    _imageUrl = await storageReference.getDownloadURL();
    print('Profile Photo Uploaded');
  }

  Future<void> _uploadClinicPhoto() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('vetImages/${_gstin}Clinic');
    StorageUploadTask uploadTask = storageReference.putFile(_clinicImage);
    await uploadTask.onComplete;
    _clinicImageUrl = await storageReference.getDownloadURL();
    print('Clinic Photo Uploaded');
  }

  Future<void> _submit(Database database) async {
    if (validateAndSaveForm()) {
      try {
        setState(() {
          _isLoading = true;
        });

        if (_locationData == null) {
          ShowErrorDialog.show(
            context: context,
            title: 'No location selected',
            message: 'Please Add a location',
          );
          setState(() {
            _isLoading = false;
          });
        }
        else if(!(_isVisitClinic|_isHomeVisit|_isChat|_isVideo)){
          ShowErrorDialog.show(
            context: context,
            title: 'No Mode selected',
            message: 'Please select at least one Mode',
          );
          setState(() {
            _isLoading = false;
          });
        }
        else if(!(_isVaccine|_isDeworming|_isConsultation)){
          ShowErrorDialog.show(
            context: context,
            title: 'No service selected',
            message: 'Please select at least one service',
          );
          setState(() {
            _isLoading = false;
          });
        }
        else {
          if (_image != null) {
            await _uploadProfilePhoto();
          }
          if (_clinicImage != null) {
            await _uploadClinicPhoto();
          }
          final id = database.getUid();
          final _deviceId = await _fcm.getToken();
          final vet = Vet(
            Name: _name,
            clinicName: _clinicName,
            phone: _mobileNumber,
            experience: _experience,
            Address: _address,
            city: _city,
            state: _state,
            zip: _pincode,
            gstin: _gstin,
            Qualification: _qualification,
            Achievements: _achievements,
            iconPath: _imageUrl,
            imagePath: _clinicImageUrl,
            locationData: _locationData,
            openTime: "9:00 AM",
            closeTime: "8:00 PM",
            id: id,
            verified: false,
            deviceToken: _deviceId,
            isChat:_isChat,
            isVideo:_isVideo,
            isVisitClinic:_isVisitClinic,
            isHomeVisit:_isHomeVisit,
            isConsultation:_isConsultation,
            isVaccine:_isVaccine,
            isDeworming:_isDeworming,
            cost: double.tryParse(_cost),
          );
          await database.setVet(vet);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => VerificationPage(
                    database: database,
                  )),
                  (Route<dynamic> route) => false);
        }
      } on PlatformException catch (e) {
        ShowErrorDialog.show(
            context: context,
            title: 'Adding Vet Failed',
            message: e.toString());
      }
    }
  }
}
