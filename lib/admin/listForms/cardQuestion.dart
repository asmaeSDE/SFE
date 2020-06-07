


import 'package:flutter/material.dart';
import 'package:programe/admin/listForms/addNewOptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programe/models/card.dart';


class CardQuestion extends StatefulWidget {
  final CardModel cardInside;
  final int index;
  final String idForm;
  final AsyncSnapshot<dynamic> snapshot;
   CardQuestion({Key key, this.cardInside,this.snapshot,this.index,this.idForm}) : super(key: key);
  @override 
  CardQuestionState createState() => CardQuestionState();
}
 
class CardQuestionState extends State<CardQuestion> {
    final _formKey = GlobalKey<FormState>();
   
  List<Key> listKeys=[];  
     
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
   void upDateCard(CardModel modelCard) async {
     print(modelCard.idCard);
    await Firestore.instance
        .collection('card')
        .document(modelCard.idCard)
        .updateData({

          'question': modelCard.question,
          'inputType':modelCard.inputType,
          
          });
  }
  String addItem ='';
    var val=[];   
      deleteItemFromListDB(String ok,CardModel model){
    val.add(ok);
    Firestore.instance.collection("card").document(model.idCard).updateData({
    "listContextInput":FieldValue.arrayRemove(val) }).then((_) =>  print("success!"));
    print(ok);
      }
  @override
  Widget build(BuildContext context) {
    setState(() {
      
    typeInput=widget.cardInside.inputType;
    });
    return Column(
                                children: <Widget>[
                                  new Card(
                                    key: Key(widget.cardInside.idCard),
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child:  Form( 
               
                child : new Container(
                  decoration: BoxDecoration(color: Colors.white),
                child: new Column(
                  
          children: <Widget>[
            Row(
            children: <Widget>[
           
              Expanded(
                flex: 3,
                child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          key: Key(widget.cardInside.question),
                          initialValue: widget.cardInside.question,
                          onChanged: (val)async{
                            
                                  widget.cardInside.question=val;
                         
                          },
                          style: TextStyle(color: Colors.black),
                        ),),
              ),
            
            
              Expanded(
                  flex: 1,
                  child: Container(
                        // tag: 'hero',
                        child:  SizedBox(
                         height: 20,
                         width: 10,
                          child :IconButton(
                           icon:  Icon(Icons.cancel,size: 20,color: Color.fromRGBO(169, 50, 38 , .9)),
                           color: Color.fromRGBO(164, 203, 93, .9),
                           onPressed: () async{
                          
                             showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Suppression"),
          content: new Text("vous voulez vraiment supprimer la question ?"),
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
              onPressed: () {
                  removeCardFromDB(widget.cardInside.idCard);
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
                        
                  ))
                
            ],
          ),
         RaisedButton(
                   //  heroTag: new GlobalKey<FormState>(),
                       child: Text('add new Option',style:  new TextStyle(color:Color.fromRGBO(28, 40, 51 , .9)),),
                      color: Color.fromRGBO(253, 235, 208 , .9),
                   key: new GlobalKey<FormState>(),
                       
                       onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                   return  NewOption(idCard: widget.cardInside.idCard,cardUpdated: widget.cardInside,);
                    }));
                          },
                    ),
                  listChoix(typeInput,widget.cardInside), 
                  
         
            for(String item in widget.snapshot.data[widget.index].data['listContextInput'])
            
            newInputSelected(item,widget.cardInside.inputType,widget.cardInside),
      
            
          ],
          
        ) ,
              ),
             
              ),
             
            ), 
              Expanded(
                          flex: 0,
                        child: SizedBox(
                          width: 150,
                          height: 22,
                          child: RaisedButton.icon(
                            onPressed: ()async{
                            //  print('second');
                            print(listContextInput);
                         widget.cardInside.listContextInput=listContextInput;
                         
                              upDateCard(widget.cardInside);
                             
   
                            },
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text('Enregistrer', 
                        style: TextStyle(color:Color.fromRGBO(28, 40, 51 , .9)),),
                icon: Icon(Icons.save, color:Color.fromRGBO(28, 40, 51 , .9),), 
                textColor: Colors.white,
                splashColor: Colors.red,
                color: Color.fromRGBO(253, 235, 208 , .9),
                          ),
                      
                        )),

                        
                                ],
                              );
  }
   Widget listChoix(String inptType,CardModel cardInside){

     return  new DropdownButton<String>(
       key: new GlobalKey<FormState>(),
                hint: Text(inptType),
                items: inputsType.map((String value) {
                 return new DropdownMenuItem<String>( 
                   value: value, 
                   child: new Text(value), 
                   ); 
                   }).toList(), 
                onChanged:  (val) async{
                 setState(() {
                   
                 typeInput=val;
                 });
                  typeInput2=val; 
                 cardInside.inputType=val;
              }, 
              );

   }
     Widget newInputSelected(String value,String typeIn,CardModel cardInside) {
     
      Widget choix = SizedBox();
       
     if(typeIn==inputsType[0] && value!=''){
              choix= SizedBox(  width: 400, height: 50, 
               child: Row(
                children: <Widget>[
                  
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      enabled: false,
                    key:  new GlobalKey<FormState>(),
                    initialValue: value,
                    onChanged: (val){
                        addItem=val;
                    },
                   onTap: (){
                
                     listContextInput.add(addItem);
              
                   },
                    decoration: InputDecoration(
                        
                        icon: Icon(Icons.list,color: Color.fromRGBO(25, 111, 61 , .9))),
                ),
                  ), Expanded( flex:2,child: buttonDeleteItemList(value,cardInside))]
              ),
            );
                }else if(typeIn==inputsType[1] && value!=''){
                choix= SizedBox(  width: 400, height: 50, 
                 child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      enabled: false,
                    key: new GlobalKey<FormState>(),
                    initialValue: value,
                    onChanged: (val){
                     
                        addItem=val;
                    
                    },
                      onTap: (){
                         listContextInput.add(addItem);
                  
                    },
                    decoration: InputDecoration(
                        
                        icon: Icon(Icons.radio_button_checked,color: Color.fromRGBO(25, 111, 61 , .9))),
                ),
                  ), Expanded( flex:2,child: buttonDeleteItemList(value,cardInside))]
              ),
            );
          
                }else if(typeIn==inputsType[2] && value!=''){
                 
                 choix= SizedBox(  width: 400, height: 50,  child: Row(
                children: <Widget>[
                  
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: TextFormField(
                        enabled: false,
                      key:new GlobalKey<FormState>(),
                      initialValue: value,
                      onChanged: (val){
                       
                          addItem=val;
                      
                      },
                        onTap: (){
                      
                        listContextInput.add(addItem);
                  
                    },
                      decoration: InputDecoration(
                          
                          icon: Icon(Icons.check_circle,color: Color.fromRGBO(25, 111, 61 , .9))),
                ),
                    ),
                  ), Expanded(flex:2, child: buttonDeleteItemList(value,cardInside))]
              ),
            );
                
                } 
                 return  choix; 
  }
   Widget buttonDeleteItemList(String item,CardModel cardInside){
return IconButton(
  icon: Icon(Icons.cancel,size: 15,color: Color.fromRGBO(169, 50, 38 , .9),),
  onPressed: (){
deleteItemFromListDB(item,cardInside);
});
  }

}













/** */