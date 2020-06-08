import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programe/models/card.dart';

class NewOption extends StatefulWidget {
   final String idCard;
   final CardModel cardUpdated;
   NewOption({Key key, this.idCard,this.cardUpdated}) : super(key: key);
  @override 
  NewOptionState createState() => NewOptionState();
}
 
class NewOptionState extends State<NewOption> {
 List<Key> listKeys=[];  
     

  Future<void> addItemtoListDB(List<String> list){
   list.removeWhere((value) => value == null);       
    Firestore.instance.collection('card').document(widget.idCard).updateData({"listContextInput": FieldValue.arrayUnion(list)});
  }
    CardModel cardUpdated;
     List<String> inputsType = ['Liste Déroulante', 'Choix multiples', 'Cases à cocher', 'Paragraphe'];
     static String typeInput ='';
     static String typeInput2=''; 
       String newValueInputSelected='';                                                         
  List<String> listValues=['Input Text'];
  List<String> listContextInput=[];
//final _formKey = new GlobalKey<FormState>(); 
 String addItem ='';
    var val=[];  

    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromRGBO(25, 111, 61 , .9),
      appBar: new AppBar(
        title: Text('Ajouter des options',style: TextStyle(color:Color.fromRGBO(25, 111, 61 , .9)),),
        
         backgroundColor: Color.fromRGBO(253, 235, 208 , .9),
      ),
       body:   Card(
           key: new GlobalKey<FormState>(),
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child:  Form( 
               
                child : new Container(
                  decoration: BoxDecoration(color: Colors.white),
                child: new Column(
                  
          children: <Widget>[
            for(Key key in listKeys )
          newInputSelected2(widget.cardUpdated.inputType,key),
          Row(children: <Widget>[
              buttonAdd(),
              Spacer(),
             enregistrer(),
          ],)
         
          ],
          
        ) ,
              ),
             
              ),
             
            ),
    
    );
  }
  Widget enregistrer(){
    return  RaisedButton(
                          
                          onPressed: (){
       setState(() {
      listContextInput.add(addItem);
    });
     addItemtoListDB(listContextInput);
     listKeys.clear();
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
   Widget newInputSelected2(String typeIn,Key key) {
     
      Widget choix = SizedBox();
       
     if(typeIn==inputsType[0]){
              choix= SizedBox( width: 400, height: 50, child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: <Widget>[
             Row(
            children: <Widget>[
            
              Expanded(
                flex: 5,
                 child: Container(
                  child: SizedBox(
                    width: 100,
                    child:  TextFormField(
                    key: key,
                     onChanged: (val){
                   //   setState(() {
                        addItem=val;
                   //   });  
                    },
                     onTap: () async{
        listContextInput.add(addItem);
      },
                    decoration: InputDecoration(
                        
                        icon: Icon(Icons.list,color:Color.fromRGBO(130, 224, 170  , .9))),
                ),
                    ),
            
                 ),),
                 Expanded(
                   flex: 1,
                   child: SizedBox(
                     width: 50,
                     height: 20,
                      child:IconButton(
                       icon:  Icon(Icons.cancel,size: 20,color: Color.fromRGBO(169, 50, 38 , .9)),
                       
                       key: new GlobalKey<FormState>(),
                     onPressed: (){
                setState(() {
                  listKeys.remove(key);
                });
              }
                    ),
                   ),)
               
              ],),
          
            
           
          ]
             ),
            );
                }else if(typeIn==inputsType[1]){
                choix= SizedBox(  width: 400, height: 50,  child: Column(
                children: <Widget>[
                  Row(
            children: <Widget>[
            
                  Expanded(
                    flex: 3,
                    child: TextField(
                    key: key,
                    onChanged: (val){
                   //   setState(() {
                        addItem=val;
                   //   });  
                    },
                     onTap: () async{
        listContextInput.add(addItem);
      },
                    decoration: InputDecoration(
                        
                        icon: Icon(Icons.radio_button_checked,color: Color.fromRGBO(130, 224, 170  , .9),)),
                ),
                  ),Expanded(
                   flex: 1,
                   child: SizedBox(
                     width: 50,
                     height: 20,
                      child:IconButton(
                       icon:  Icon(Icons.cancel,size: 20,color: Color.fromRGBO(169, 50, 38 , .9)),
                       
                       key: new GlobalKey<FormState>(),
                     onPressed: (){
                setState(() {
                  listKeys.remove(key);
                });
              }
                    ),
                   ),)]
              ),]),
            );
          
                }else if(typeIn==inputsType[2]){
                 
                 choix= SizedBox(  width: 400, height: 50, child: Column(
                children: <Widget>[
                  Row(
            children: <Widget>[
            
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: TextFormField(
                      key: key,
                        onChanged: (val){
                   //   setState(() {
                        addItem=val;
                   //   });  
                    },
                     onTap: () async{
        listContextInput.add(addItem);
      },
                      decoration: InputDecoration(
                          
                          icon: Icon(Icons.check_circle,color: Color.fromRGBO(130, 224, 170  , .9),)),
                ),
                    ),
                  ),
                  Expanded(
                   flex: 1,
                   child: SizedBox(
                     width: 50,
                     height: 20,
                      child:IconButton(
                       icon:  Icon(Icons.cancel,size: 20,color: Color.fromRGBO(169, 50, 38 , .9)),
                       
                       key: new GlobalKey<FormState>(),
                     onPressed: (){
                setState(() {
                  listKeys.remove(key);
                });
              }
                    ),
                   ),)
                ]
              ),]),
            );
                
                } 
                 return  choix; 
  }
  
  Widget buttonAdd() {
     return new  RaisedButton(
                          onPressed: (){
                           counter();
                        },
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(72, 201, 176 , .9),
                                  Colors.greenAccent
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                                'Nouvelle option',
                                style: TextStyle(fontSize: 15,color: Colors.white)
                            ),
                          ),
                        );
   }
    counter(){
      setState(() {
        
           listKeys.add(UniqueKey());
      });
            }
   addInputsToListState(String value){
     
       setState(() {
        listContextInput.clear();
       });
      
    }
    
}