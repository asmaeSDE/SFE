import 'package:flutter/material.dart';
import 'package:programe/services/database.dart';
import 'package:programe/admin/listForms/questionResponse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardForm extends StatefulWidget {
  final AsyncSnapshot<dynamic> snapshot;
   int index;
   CardForm({Key key, this.snapshot,this.index}) : super(key: key);
  @override 
  CardFormState createState() => CardFormState();
}
 
class CardFormState extends State<CardForm> {
  
 
final _formKey = new GlobalKey<FormState>(); 
DatabaseService serviceData = new DatabaseService();
 Future<void> removeFormFromDB(String id){
    return Firestore.instance.collection('Formulaire').document(id).delete();
  }
 Future<void> removeCardFromDB(String id){
    return Firestore.instance.collection('card').document(id).delete();
  }
       Future getCards() async{
      QuerySnapshot query = await  Firestore.instance.collection('card').where('idForm', isEqualTo: widget.snapshot.data[widget.index].data['idForm']).getDocuments();
             return query.documents;
         
   } 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
             margin:EdgeInsets.fromLTRB(10.0,3.0,20.0,0.0),
              
          child:Column(
            
            children: <Widget>[
              Row(
              children: <Widget>[
                
                Expanded(
                  flex:5,
                  child: Container(
                 child: ListTile(
                key: new GlobalKey<FormState>(),
                 title: Text(widget.snapshot.data[widget.index].data["title"]??'test',style: TextStyle(fontSize: 15),),
            ),
                  )
                  ),
                  Expanded(
                    flex:1,
                    child: Container(
                      child:  SizedBox(
                       
                        child :IconButton(
                         icon:  Icon(Icons.delete_outline,size: 20,color: Color.fromRGBO(169, 50, 38 , .9)),
                         color: Color.fromRGBO(245, 177, 42, .9),
                       key: new GlobalKey<FormState>(),
                         onPressed: () async{
                           String titleForm=widget.snapshot.data[widget.index].data["title"];
                            showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Suppression"),
            content: new Text("vous voulez vraiment supprimer le formulaire $titleForm?",),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Non"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
               new FlatButton(
                child: new Text("Oui"),
                onPressed: () async {
                  var cards = await Firestore.instance
                .collection('card')
                .where('idForm', isEqualTo: widget.snapshot.data[widget.index].data['idForm'])
                .getDocuments();

              var batch = Firestore.instance.batch();
              cards.documents.forEach((doc) {
                print(doc.documentID);
                batch.delete(doc.reference); });
             
              await batch.commit();
                    removeFormFromDB(widget.snapshot.data[widget.index].documentID);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
                      
                            },
                      ),
                      ),
                    )),
                 Expanded(
                    flex:1,
                    child: SizedBox(
                       
                        child :IconButton(
                         icon:  Icon(Icons.keyboard_arrow_right,size: 30,color: Color.fromRGBO(25, 111, 61 , .9)),
                         color: Color.fromRGBO(245, 177, 42, .9),
                         
                         key: new GlobalKey<FormState>(),
                         onPressed: () async{
                     Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                     return new EditFormResponse(idForm: widget.snapshot.data[widget.index].data['idForm']);
                      
                      }));
                            },
                      ),
                      ),),
              ],
              ),
           
            ]
             ),
                
      ),
    );
  }
}