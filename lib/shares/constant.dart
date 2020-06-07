import 'package:flutter/material.dart';

bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
final Color backgroundColor = Color(0xFF4A4A58);


 

final emailField =
           InputDecoration(
             
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0,15.0),
              hintText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
                  borderSide:  BorderSide(color: Colors.orange, width: 0.0),
                  ),
                focusColor: Colors.green,
                  );
    
final Nom =
           InputDecoration(
             
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 15.0),
              hintText: "Nom",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));
                  


         final passwordField = InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
              hintText: "mot de passe",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));


                  
final Prenom =
           InputDecoration(
             
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Prenom",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));
                  

                 
final CIN =
           InputDecoration(
             
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "CIN",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


                  final inputFormulaire =
           InputDecoration(
              hintText: "ajouter une titre",
              fillColor: Colors.red,
     //   labelText: "Password",
        errorStyle: TextStyle(
          color: Colors.red,
          wordSpacing: 5.0,
        ),
        labelStyle: TextStyle(
          color: Colors.green,
            letterSpacing: 1.3
        ),
        hintStyle: TextStyle(
          color: Colors.white,
            letterSpacing: 1.3
        ),
        contentPadding: EdgeInsets.all(15.0), // Inside box padding
        border: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(1.5)
        ));
                final inputDescription =
           InputDecoration(
              hintText: "ajouter une description",
              fillColor: Colors.red,
        errorStyle: TextStyle(
          color: Colors.red,
          wordSpacing: 5.0,
        ),
        labelStyle: TextStyle(
          color: Colors.green,
            letterSpacing: 1.3
        ),
        hintStyle: TextStyle(
          color: Colors.white,
            letterSpacing: 1.3
        ),
        contentPadding: EdgeInsets.all(15.0), // Inside box padding
        border: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(1.5)
        ));
     