import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'cardUser.dart';
class ListUsers extends StatefulWidget {
     ListUsers({Key key}) : super(key: key);

     @override
     _ListUsersState createState() => new _ListUsersState();
}


class _ListUsersState extends State<ListUsers> {

  
      Future getUsers() async{
        var firestore = Firestore.instance;
       QuerySnapshot query = await  firestore.collection('user').getDocuments();
      
             return query.documents;
  
   }
     @override
     Widget build(BuildContext context) {
     return Scaffold(
      body: Container( 
        
        child: Column(
          children: <Widget>[
                Card(
                  color: Color.fromRGBO(253, 235, 208 , .9),
                  child: Text('Activez les accès des utilisateurs pour qu\'ils peuvent utiliser les formulaires créés ',
                  style: TextStyle(color:Color.fromRGBO(25, 111, 61 , .9)),)),
        
            FutureBuilder(
              future: getUsers(),
              builder: ( _, snapshot){
               Widget list = Column(children: <Widget>[  
                
               ],);
               if(snapshot.connectionState == ConnectionState.waiting){
                list = Center(child: Text('Loading ... '),);
                
              }
              else {
               
       list=  ListView.builder(
             
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
               itemCount: snapshot.data.length,
               itemBuilder: (_, index){
               return CardUser(snapshot: snapshot,index: index,result: snapshot.data[index].data['access']);
               });
              }
              return list;
              }),
            ],
        ),
      ),

   
      );

   
     }
} /* 
      floatingActionButton: FloatingActionButton(
       onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                return new NewForm();
              }));
            },
        tooltip: 'add new form',
        child: Icon(Icons.add),
      ),*/