import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programe/services/database.dart';

class CardUser extends StatefulWidget {
  final AsyncSnapshot<dynamic> snapshot;
   int index=0;
   bool result;
   CardUser({Key key, this.snapshot,this.index,this.result}) : super(key: key);
  @override 
  CardUserState createState() => CardUserState();
}

class CardUserState extends State<CardUser> {
 
final _formKey = new GlobalKey<FormState>(); 
DatabaseService serviceData = new DatabaseService();
   void updateLED(bool newValue,String id) async {
    await Firestore.instance
        .collection('user')
        .document(id)
        .updateData({'access': newValue});
  }
bool isSwitch = false;
 
  @override
  Widget build(BuildContext context) {
    handleSwitch(bool value) {
      setState(() {
        isSwitch = value;
        widget.result = value;
      });
    }
     
    return Card(
        //   margin:EdgeInsets.fromLTRB(10.0,3.0,20.0,0.0),
              child:  Container(
                 decoration: BoxDecoration(color:  Color.fromRGBO(25, 111, 61 , .9)),
                child: Form( 
                  
                key: _formKey,
        child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: <Widget>[
             Row(
            children: <Widget>[
             Expanded(
                     flex: 5,
      child :ListTile(
         contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.contacts, color: Colors.white),
        ),
       
        trailing:
          Text(''),
          title: Text(widget.snapshot.data[widget.index].data["nom"]??'',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
             ),
           if (widget.snapshot.connectionState == ConnectionState.done) 
      
         Switch(
           value: widget.result != true ? isSwitch : widget.result ,
                  onChanged: (val) {
                   
                    updateLED(val,widget.snapshot.data[widget.index].documentID);
                     handleSwitch(val);
                  },
                  activeTrackColor:  Color.fromRGBO(130, 224, 170  , .9),
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                ),
     
           ])
        
          ]
           ),
                ),
              ),
    );
  }
}