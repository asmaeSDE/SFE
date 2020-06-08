import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:programe/models/card.dart';
import 'package:programe/admin/WidgetProject/newCheck.dart';
import 'package:programe/admin/WidgetProject/newRadioButton.dart';
import 'package:programe/USER/screens/home/cardResponse.dart';


class FormUser extends StatefulWidget {
  final String idForm ;
  final String nomForm;

FormUser({Key key, this.idForm,this.nomForm}) : super(key: key);


     @override
     _FormUserState createState() => new _FormUserState();
}


class _FormUserState extends State<FormUser> {

Future getCards() async{
       QuerySnapshot query = await  Firestore.instance.collection('card').where('idForm', isEqualTo: widget.idForm).getDocuments();
      
             return query.documents;
  
   }
   
List<String> listQuestion=[];
GlobalKey<CardResponseState> questionKey;
List<GlobalKey<CardResponseState>> listQuestionKeys=[];
  @override

      
  Widget build(BuildContext context) {
    String test=widget.nomForm;
    return Scaffold(
  
      resizeToAvoidBottomPadding: false ,
      backgroundColor: Colors.green[255],

      appBar: AppBar(

        backgroundColor: Colors.green,
        elevation: 0.0,
        title: Text(
        '$test',style: TextStyle(fontSize:14),
        ),
        actions: <Widget>[
        
        ],

              ),

    body:  Column(
      children: <Widget>[
        Container(

          child: Expanded(
            flex:5,
            child: SizedBox(
              height: 100,
              width: 500,
              child: FutureBuilder(
                   future: getCards(),
                    builder:
                        (_,snapshot) {
 Widget list=Column(children: <Widget>[],);
                     if(snapshot.connectionState == ConnectionState.waiting){

                      list = Center(child: Text('Loading ... '),);
                      
                    }
                    else {
                      list= ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_,index) {
                          questionKey= new GlobalKey<CardResponseState> ();
                          listQuestionKeys.add(questionKey);
                           CardModel cardInside=new CardModel(idCard: snapshot.data[index].documentID,idForm:  widget.idForm,question: snapshot.data[index].data['question'],listContextInput: List<String>.from(snapshot.data[index].data['listContextInput']),listResponses: 
                            List<String>.from(snapshot.data[index].data['listResponses']), inputType: snapshot.data[index].data['inputType'] );
         
                              
                         return new CardResponse(cardInside: cardInside,key: questionKey);
                        },
                      );
                    }
                    return list;
                        } 
                    ),
            ),
          ),
          
        ),
        Expanded(
                flex:0,
                child: RaisedButton(
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
                  onPressed: () async{
                    
                   for(GlobalKey<CardResponseState> item in listQuestionKeys ){
                  
                   
                      if(item.currentState.cardOther.inputType=='Paragraphe'){
                       print(item.currentState.cardOther.inputType);
                       item.currentState.addInputToResponsesText();
                       
                     }

                     // print(item.currentState.listResponses);
                     List<String> newListResponses =[];
                     print( item.currentState.cardOther.listResponses);
                     newListResponses=item.currentState.cardOther.listResponses;
                     for(String input in item.currentState.listResponses ){
                    newListResponses.add(input);
                     }
                     Firestore.instance.collection('card').document(item.currentState.cardOther.idCard)
                     .setData({'idCard': item.currentState.cardOther.idCard,
                     'idForm':item.currentState.cardOther.idForm,
                     'listContextInput': item.currentState.cardOther.listContextInput,
                     'question':item.currentState.cardOther.question,
                     'inputType': item.currentState.cardOther.inputType,
                     'listResponses':newListResponses});
                     setState(() {
                      // Scaffold.of(context).showSnackBar(SnackBar(content: Text('vos réponses sont envoyées avec succés'),));
     
                     });
      
                    }
               
                     
                  }),)
      ],
    ),
    );
}



}