import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programe/admin/listForms/cardForm.dart';
class ListForms extends StatefulWidget {
     ListForms({Key key}) : super(key: key);

     @override
     _ListFormsState createState() => new _ListFormsState();
}


class _ListFormsState extends State<ListForms> {
     
      Future getForms() async{
        var firestore = Firestore.instance;
       QuerySnapshot query = await  firestore.collection('Formulaire').getDocuments();
      
             return query.documents;
  
   }
    @override
    Widget build(BuildContext context) {
    
     return Container(
        child: FutureBuilder(
          future: getForms(),
          builder: ( _, snapshot){
           Widget list = Column(children: <Widget>[
            
           ],);
           if(snapshot.connectionState == ConnectionState.waiting){
            list = Center(child: Text('Loading ... '),);
            
          }
          else {
           
       list= new SizedBox(
             child:  ListView.builder(
           itemCount: snapshot.data.length,
           
        padding: new EdgeInsets.symmetric(vertical: 16.0),
           itemBuilder: (_, index){
           return CardForm(snapshot: snapshot,index: index,);
           }));
          }
          return list;
          }),
      

   
      );

   
     }}