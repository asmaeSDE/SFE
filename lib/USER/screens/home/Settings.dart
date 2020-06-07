import 'package:flutter/material.dart';
import 'package:programe/shares/NavDrawer.dart';


class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      resizeToAvoidBottomPadding: false ,
      backgroundColor: Colors.green[255],

      appBar: AppBar(

backgroundColor: Colors.green,
elevation: 0.0,
title: Text(
'Services'
),
centerTitle: true,
actions: <Widget>[
 
],

      ),
      drawer:NavDrawer(),

body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Card(
                color: Colors.orange[50],
                child: Container(
                   padding: EdgeInsets.all(10),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
 
                      SizedBox(height: 10.0), 
                       Text(
                'Conseil en stratégie',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20,
                       
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.orange,
                        ),
                      ),
                       SizedBox(height: 10.0),
                       Text( 
                       'Nos experts vous accompagnerons dans l’élaboration de la feuille de route de votre transformation digitale.Nous vous aiderons à définir les objectifs, à étudier les opportunités et les intérêts, à benchmarker les meilleures technologies et pratiques s’adaptant à votre contexte, à votre culture et à vos cultures, et à dresser un plan d’action.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                          fontFamily: 'Poppins',
                         
                        ),
                      ),
                      
                    ]
                   ),
                ),
             ),

             Card(
                color: Colors.orange[50],
                child: Container(
                   padding: EdgeInsets.all(10),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
 
                      SizedBox(height: 10.0), 
                       Text(
                'Formation et accompagnement',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20,
                       
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.orange,
                        ),
                      ),
                       SizedBox(height: 10.0),
                       Text( 
                       'Notre équipe de consultant formateur vous accompagne dans la mise en place des solutions digitales mais surtout pour le transfert de compétences avec vos équipes utilisateurs et managers.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                          fontFamily: 'Poppins',
                         
                        ),
                      ),
                      
                    ]
                   ),
                ),
             ),
             Card(
                color: Colors.orange[50],
                child: Container(
                   padding: EdgeInsets.all(10),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
 
                      SizedBox(height: 10.0), 
                       Text(
                'Simulateur de budget et de rentabilité',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20,
                       
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.orange,
                        ),
                      ),
                       SizedBox(height: 10.0),
                       Text( 
                       'En utilisant notre simulateur de budget, nous pourrons vous aider à élaborer votre budget de campagne en un temps record, en profitant d’une expérience de plusieurs années sur un ensemble de cultures, nous vous assisterons pour faire les simulations que vous voulez afin de dresser votre budget de campagne.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                          fontFamily: 'Poppins',
                         
                        ),
                      ),
                      
                    ]
                   ),
                ),
             ),
            ],
          ),
        ),
       ), 
    );
    
  }

     
}