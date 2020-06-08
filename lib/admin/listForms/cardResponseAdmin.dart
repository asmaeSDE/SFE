


import 'package:flutter/material.dart';
import 'package:programe/admin/listForms/addNewOptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programe/models/card.dart';


class CardAdminResponse extends StatefulWidget {
  final CardModel cardInside;
  final int index;
  final String idForm;
  final AsyncSnapshot<dynamic> snapshot;
   CardAdminResponse({Key key, this.cardInside,this.snapshot,this.index,this.idForm}) : super(key: key);
  @override 
  CardAdminResponseState createState() => CardAdminResponseState();
}
 
class CardAdminResponseState extends State<CardAdminResponse> {
    final _formKey = GlobalKey<FormState>();
   
  List<Key> listKeys=[];  
     
     Future<void> removeCardFromDB(String id){
    return Firestore.instance.collection('card').document(id).delete();
  }
    CardModel cardUpdated;
    
  @override
  Widget build(BuildContext context) {

    return  SizedBox(
      width: 200,
      height: 200,
      child: new Card(
                key: Key(widget.cardInside.idCard),
                elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child:  Form( 
                 
                  child : new Container(
                    decoration: BoxDecoration(color: Colors.white),
                child:
              Column(
              children: <Widget>[
             Row( children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SizedBox(
                      width: 150,
                            height: 22,
                          child: Text(widget.cardInside.question,style: TextStyle(color: Color.fromRGBO(25, 111, 61 , .9),fontWeight: FontWeight.bold),
                          ),),
                ),
               Expanded(
                  flex: 1,
                  child: SizedBox(
                      width: 150,
                            height: 22,
                          child: Text(widget.cardInside.listResponses.length.toString()+'  réponses',style: TextStyle(color: Colors.green,backgroundColor:Color.fromRGBO(253, 235, 208 , .9),fontSize: 10),
                          ),),
                ),
             ]),
               
              
                        for(String item in widget.cardInside.listResponses)
                       Expanded(
                            flex:1,
                          child: SizedBox(
                            width: 200,
                            child:Table(
            border: TableBorder.all(
                color: Colors.black26, width: 1, style: BorderStyle.none),
            children: [ 
              TableRow(
                              children: [
                    Text(item),
                   
                  ]
                  ,),
                  ]),
                        
                          ))
                  
              ],
            
          ) ,
                ),
               
                ),
               
              ),
    );
  }}