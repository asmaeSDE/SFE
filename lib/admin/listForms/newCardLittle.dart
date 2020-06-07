import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programe/models/card.dart';
import 'package:programe/services/formService.dart';
import 'package:programe/admin/WidgetProject/newCard.dart';
class NewCardLittle extends StatefulWidget {
   final String idForm;
   NewCardLittle({Key key,this.idForm}) : super(key: key);
  @override 
  NewCardLittleState createState() => NewCardLittleState();
}
 
class NewCardLittleState extends State<NewCardLittle> {
 List<Key> listKeys=[];  
     
  final FormService formDAO = new FormService();
  List<String> testList;
     Future<void> removeCardFromDB(String id){
    return Firestore.instance.collection('card').document(id).delete();
  }


    CardModel cardUpdated;
     List<String> inputsType = ['Liste Déroulante', 'Choix multiples', 'Cases à cocher', 'Paragraphe'];
     static String typeInput ='';
     static String typeInput2=''; 
       String newValueInputSelected='';                                                         
  List<String> listValues=['Input Text'];
  List<String> listContextInput=[];
  
final List<GlobalKey<NewCardState>> listKeysCard=[];
//final _formKey = new GlobalKey<FormState>(); 
 String addItem ='';
    var val=[];  

    
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Color.fromRGBO(25, 111, 61 , .9),
      appBar: new AppBar(
        title: Text('Ajouter des nouvelles questions',style: TextStyle(color:Color.fromRGBO(25, 111, 61 , .9)),),
        
         backgroundColor: Color.fromRGBO(253, 235, 208 , .9),
      ),
       body:  new Center(
      
        child: new ListView(
          
         children: <Widget>[
      
          for(GlobalKey<NewCardState> itemKey in listKeysCard) 
           Column(
          children: <Widget>[
            Row(
            children: <Widget>[
               Expanded(
                flex: 10,
                child:  NewCard(key: itemKey),
              ),
              Expanded(
                  flex: 2,
                  
                  child: Container(
                    // tag: 'hero',
                    child:  SizedBox(
                     height: 20,
                     width: 10,
                      child :IconButton(
                       icon:  Icon(Icons.delete,size: 20,color: Color.fromRGBO(130, 224, 170  , .9)),
                       
                       key: new GlobalKey<FormState>(),
                      onPressed: () async{
                            setState(() {
                              listKeysCard.remove(itemKey);
                            });
                          },
                    ),
                    ),
                  )),
             
            ],
          ),

            
          
          ],
          
        ) ,
           
           
          enregistrer(),
          ],         
        )
      ),
       floatingActionButton: FloatingActionButton(
       
          backgroundColor: Color.fromRGBO(253, 235, 208, .9),
       onPressed: (){
            counter();
            },
        child: Icon(Icons.add,color:Color.fromRGBO(25, 111, 61 , .9)),
      ),
    
    );
  }
    void showMyDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           title: new Text("Attention!"),
          content: new Text("Remplir tous les champs de question"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
        
          ],
        );
      },
    );
  }
  Widget enregistrer(){
    return RaisedButton(
           onPressed: (){
                   bool i=false;
                  
                    for(GlobalKey<NewCardState> itemKey in listKeysCard){ 
                      itemKey.currentState.validateAndSave();
                     if(itemKey.currentState.validateform()==true){
                     
                      print(itemKey.currentState.cardModel.question);
                      itemKey.currentState.listContextInput.add(itemKey.currentState.inputTest);
                     setState(() {
                      testList=itemKey.currentState.listContextInput;
                     // testList.remove('');
                     });
                      itemKey.currentState.cardModel.listContextInput=testList;
                       itemKey.currentState.cardModel.listContextInput.removeWhere((value) => value == null);
                       
                      itemKey.currentState.cardModel.idForm= widget.idForm;
                      formDAO.createCard(itemKey.currentState.cardModel); 
                     i=true;
                     }else{
                       i=false;
                    showMyDialog(context);
                     }
                    }
                    if(i==true){
                     for(GlobalKey<NewCardState> itemKey in listKeysCard){
                      itemKey.currentState.resetForm();
                    //   itemKey.currentState.listContextInput.clear();
                     }
                     
                     setState(() {
                     listKeysCard.clear();
                     });
                    }

                    

    },
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[Color.fromRGBO(20, 90, 50  , .9),
                                  Colors.green
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                                'Enregistrer',
                                style: TextStyle(fontSize: 15,color: Colors.white)
                            ),
                          ),
                        );
   
  }

    counter(){ setState(() {
               listKeysCard.add(new GlobalKey<NewCardState>());
             });}
    
}