import 'package:flutter/material.dart';
import 'package:programe/models/card.dart';
import 'package:programe/admin/WidgetProject/newCheck.dart';
class CardResponse extends StatefulWidget {
  final String inputRadio;
  final CardModel cardInside;
   CardResponse({Key key,this.inputRadio,this.cardInside}) : super(key: key) ;
  @override
  CardResponseState createState() => CardResponseState();
}
class CardResponseState extends State<CardResponse> {
  
   final inptTextController= TextEditingController();
    List<String> inputsType = ['Liste Déroulante', 'Choix multiples', 'Cases à cocher', 'Paragraphe'];
    String groupValue;
    String valInput='';
    List<String> listResponses=[];
    String inputListDeroulante;
    List<GlobalKey<NewCheckState>> listKeysCheck=[];
    bool _isChecked = false;
    final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
  List<CheckboxListTile> checkList = [];
  CardModel cardOther;
  void initState() {
    super.initState();

    setState(() {
      for (String item in widget.cardInside.listContextInput) {
        checkList.add(CheckboxListTile(
          key: new GlobalKey<FormState>(),
           title: Text(item),
          value: _isChecked,
          onChanged: (val){    
            print(item);
             if(listResponses.contains(item)){
              listResponses.remove(item);
            }else{
            if(val==true){
            listResponses.add(item);
            }
            }
           
           setState(() {
          _isChecked = val;
        });
            },
        ),);
      }
    });
  }
  @override

   
   Widget build(BuildContext context){
          inputListDeroulante=widget.cardInside.listContextInput[0];
          cardOther =widget.cardInside;
     return new SingleChildScrollView(
        
      child: Card(
                           child:Form(
                             key: _formKey,
                             child: Container(
                              color : Colors.green[100],

                               child: 
                               SizedBox(
                                  width: 100.0,
                                      height: 250.0,
                                 child: Column(
                     
                    children: <Widget>[

                   SizedBox(height: 50.0),
                          Expanded(
                          flex:0,
                          child: SizedBox(
                                  width: 400.0,
                                      height: 50.0,
                                  child: Container(

                                    child: Text(widget.cardInside.question,style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,),
                                    
                                    
                                    ),
                                    
                                  ),
                          ),
                          ),
                         Expanded(
                          flex:2,
                          child: Container(
                                  child: testTypeInput(widget.cardInside,new GlobalKey<FormState>()),
                          ),
                          ),
                           

                    ]
                    ),
                               ),
                             ),
                           ),
                            ) ,

                              
                            );
   }
Widget testTypeInput(CardModel cardInside,Key key){
  Widget choix = SizedBox();
     if(cardInside.inputType==inputsType[0]){
              choix= SizedBox(width: 200.0,
                      height: 200.0, child: listDeroulante(new GlobalKey<FormState>(),cardInside),);
                }else if(cardInside.inputType==inputsType[1]){
                choix= SizedBox( width: 200.0,
                      height: 200.0,child:  radioWidget(new GlobalKey<FormState>(),cardInside));
          
                }else if(cardInside.inputType==inputsType[2]){
               
                 choix=  SizedBox( width: 200.0,
                      height: 200.0, child: newCheck(new GlobalKey<FormState>(),cardInside),);
                
                }else{choix=SizedBox(
                   width: 200.0,
                      height: 200.0,child: inptText(new GlobalKey<FormState>()));}
                 return  choix; 
}
   Widget listDeroulante(Key key,CardModel cardInside){
     return  new DropdownButton<String>(
       key: new GlobalKey<FormState>(),
                hint: Text(inputListDeroulante),
                items: cardInside.listContextInput.map((String value) {
                 return new DropdownMenuItem<String>( 
                  
                   value: value, 
                   child: new Text(value), 
                   ); 
                   }).toList(), 
                onChanged:  (val) async{
                  print(val);
                setState(() {
                    inputListDeroulante=val;
                    print(inputListDeroulante);
                    listResponses.add(val);
                });
                
              }, 
              
              );
   }
   
   Widget radioWidget(Key key,CardModel cardInside){
   
         return Column(
            children: <Widget>[
              for(String item in cardInside.listContextInput)
               Expanded(
                flex:4,
               child:  SizedBox(
                     width: 200,
                     height: 100,
            child: Container(
              child:ListTile(
             
                   title: Text(item),
                    leading: Radio(
                      
                      key: new GlobalKey<FormState>(),
                      activeColor: Color.fromRGBO(42, 45, 46, .9) ,
                      value: item,
                      groupValue: groupValue,
                      onChanged:  (newValue) async{
                        print(newValue);
                        setState(() {
                           groupValue = newValue;
                           listResponses.clear();
                           listResponses.add(newValue);
                        });
                        
                        },
              ),
              ),),)
              ,)
              
              ]
         );
   }
  

Widget newCheck(Key key,CardModel cardInside){
 
     return new  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: checkList
             );
   }
  
   
   Widget inptText(Key key){
     return new Theme(
          data: new ThemeData(
            primaryColor: Color.fromRGBO(164, 203, 93, .9),
            primaryColorDark: Color.fromRGBO(164, 203, 93, .9),
            
          ),
          child: TextFormField(
           controller: inptTextController,
       key: key,
     onChanged: (value){
    
         valInput=value;
    
     },
       decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0,),
       )
     ),);
     
   }
   addInputToResponsesText(){
     setState(() {
         listResponses.add(valInput);
     });
   }
  
}


