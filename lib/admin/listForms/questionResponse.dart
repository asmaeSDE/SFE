import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programe/models/card.dart';
import 'package:programe/admin/listForms/cardResponseAdmin.dart';

import 'package:programe/admin/listForms/newCardLittle.dart';
import 'package:programe/admin/listForms/cardQuestion.dart';
class EditFormResponse extends StatefulWidget {
   
    final String idForm;
     EditFormResponse({Key key,this.idForm}) : super(key: key);

     @override
     _EditFormResponseState createState() => new _EditFormResponseState();
}

const List<String> tabNames = const<String>[
     'Questions', 'Réponses'
];

class _EditFormResponseState extends State<EditFormResponse> {
   var firestore ;


     int _screen = 0;
    
    final _formKey = GlobalKey<FormState>();
   
  List<Key> listKeys=[];  
      Future getCards() async{
       QuerySnapshot query = await  Firestore.instance.collection('card').where('idForm', isEqualTo: widget.idForm).getDocuments();
      
             return query.documents;
  
   } 
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
   
     @override
     Widget build(BuildContext context) {
       return new DefaultTabController(
         length: tabNames.length,
         child: new Scaffold(
           appBar: new AppBar(
             title: new Text('Editer le formulaire'),
             backgroundColor: Color.fromRGBO(25, 111, 61 , .9),
           ),
           body: new TabBarView(
             children: new List<Widget>.generate(tabNames.length, (int index) {
               switch (_screen) {
                 case 0: return Center(
                   child:  Column(
                   //    mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                    Expanded(
                    flex: 5,
                      child: SizedBox(
                     width: 500,
                     height: 500,
                      child: Container(
                         child: FutureBuilder(
                         future: getCards(),
             builder: ( _, snapshot){
           Widget list=Column(children: <Widget>[],);
           if(snapshot.connectionState == ConnectionState.waiting){
            list = Center(child: Text('Loading ... '),);
            
          }
          else {
       list= ListView.builder(
                          physics: BouncingScrollPhysics(),
                          cacheExtent: 1000,
                          addAutomaticKeepAlives: true,
                          reverse: false,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                   CardModel cardInside=new CardModel(idCard: snapshot.data[index].documentID,idForm:  widget.idForm,question: snapshot.data[index].data['question'],inputType: snapshot.data[index].data['inputType'] );
                          
                              return  CardQuestion(key:Key(cardInside.idCard),cardInside: cardInside,snapshot: snapshot,index: index);
    
           },
           );
          }
          return list;
          }
                          ),
                         ),
                   ),),
                       RaisedButton(
                          onPressed: (){
                           Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                   return  NewCardLittle(idForm: widget.idForm);
                    }));
                        },
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(25, 111, 61 , .9),
                                  Colors.greenAccent
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                                'Ajouter des questions',
                                style: TextStyle(fontSize: 15,color: Colors.black)
                            ),
                          ),
                        )
                        
                     ],
                   ),
 
                     
                 );
                 case 1: return Center(
                   child:  Column(
                   //    mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                    Expanded(
                    flex: 5,
                      child: SizedBox(
                     width: 500,
                     height: 500,
                      child: Container(
                         child: FutureBuilder(
                         future: getCards(),
             builder: ( _, snapshot){
           Widget list=Column(children: <Widget>[],);
           if(snapshot.connectionState == ConnectionState.waiting){
            list = Center(child: Text('Loading ... '),);
            
          }
          else {
       list= ListView.builder(
                          physics: BouncingScrollPhysics(),
                          cacheExtent: 1000,
                          addAutomaticKeepAlives: true,
                          reverse: false,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                   CardModel cardInside=new CardModel(idCard: snapshot.data[index].documentID,idForm:  widget.idForm,question: snapshot.data[index].data['question'],listResponses: List<String>.from(snapshot.data[index].data['listResponses']),inputType: snapshot.data[index].data['inputType'] );
                          
                              return  CardAdminResponse(key:Key(cardInside.idCard),cardInside: cardInside,snapshot: snapshot,index: index);
    
           },
           );
          }
          return list;
          }
                          ),
                         ),
                   ),),
                      
                        
                     ],
                   ),
 
                     
                 );
               }
             }),
           ),

           bottomNavigationBar: new Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
            
               new BottomNavigationBar(
                 currentIndex: _screen,
                 onTap: (int index) {
                   setState(() {
                     _screen = index;
                   });
                 },
                 items: [
                   new BottomNavigationBarItem(
                     icon: new Icon(Icons.question_answer),
                     title: new Text('Questions'),
                   ),
                   new BottomNavigationBarItem(
                     icon: new Icon(Icons.check_circle),
                     title: new Text('Réponses'),
                   ),
                 ],
               ),
             ],
           ),
         ),
       );
   
     }
   
          

     Widget newInputSelected(String value,String typeIn,CardModel cardInside) {
       
      Widget choix = SizedBox();
  print(value);
     if(typeIn==inputsType[0] ){
              choix= SizedBox( width: 400, height: 50, child: Column(
                children: <Widget>[
                  
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                    key: new GlobalKey<FormState>(),
                    initialValue: value,
                    onChanged: (val){
                     
                        addItem=val;
                    
                    },
                    decoration: InputDecoration(
                        
                        icon: Icon(Icons.list)),
                ),
                  ), Expanded( flex:1,child: buttonDeleteItemList(value,cardInside))]
              ),
            );
                }else if(typeIn==inputsType[1]){
                choix= SizedBox(  width: 400, height: 50,  child: Column(
                children: <Widget>[
                  
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                    key: new GlobalKey<FormState>(),
                    initialValue: value,
                    onChanged: (val){
                     
                        addItem=val;
                    
                    },
                    decoration: InputDecoration(
                        
                        icon: Icon(Icons.radio_button_checked)),
                ),
                  ), Expanded( flex:1,child: buttonDeleteItemList(value,cardInside))]
              ),
            );
          
                }else if(typeIn==inputsType[2]){
                 
                 choix= SizedBox(  width: 400, height: 50, child: Column(
                children: <Widget>[
                  
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: TextFormField(
                      key: new GlobalKey<FormState>(),
                      initialValue: value,
                      onChanged: (val){
                       
                          addItem=val;
                      
                      },
                      decoration: InputDecoration(
                          
                          icon: Icon(Icons.check_circle)),
                ),
                    ),
                  ), Expanded(flex:1, child: buttonDeleteItemList(value,cardInside))]
              ),
            );
                
                } 
                 return  choix; 
  }
   
  Widget buttonDeleteItemList(String item,CardModel cardInside){
return FloatingActionButton(
  child: Icon(Icons.cancel,size: 10,),
  onPressed: (){
deleteItemFromListDB(item,cardInside);
});
  }
    
}
