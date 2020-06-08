import 'package:flutter/material.dart';
import 'package:programe/services/formService.dart';
import 'package:programe/models/card.dart';

class NewCard extends StatefulWidget {

   NewCard({Key key}) : super(key: key);
  @override 
  NewCardState createState() => NewCardState();
}

class NewCardState extends State<NewCard> {
  final questionController= TextEditingController();
   final inptTextController= TextEditingController();
int i=1;
  @override
  
 static String question ='';
 static String typeInput ='';
 static String typeInput2=''; //textInput !!
  List<String> listContextInput=[''];
 int nbr=0;


  final FormService formDAO = new FormService();
    final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
  final CardModel cardModel = new CardModel(); 
 
  List<Key> listKeys=[];                                                          
  List<String> listValues=['Input Text'];
  List<String> inputsType = ['Liste Déroulante', 'Choix multiples', 'Cases à cocher', 'Paragraphe'];

  String inputTest;
 

  void resetForm() {
    setState(() {
      _formKey.currentState.reset();
    });
  }
  bool validateform() {
    bool test=false;
    if (_formKey.currentState.validate()) {
      test=true;
     print(_formKey.currentState.validate());
    }else{test=false;}
    return test;
  }
 void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

 
   Widget build(BuildContext context) {
     
    return new SingleChildScrollView(
      child:   new Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
             
                child : new Container(
                 decoration: BoxDecoration(color:Color.fromRGBO(253, 235, 208 , .9)),
                child:  Form( 
                key: _formKey,
                child: new Column(
          children: <Widget>[
            Row(
            children: <Widget>[
           
              Expanded(
                flex: 10,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: textQuestion(),),
              )
            ],
          ),

            
            listChoix(),   
            SizedBox(
                    child: inputTextOnly(),
                   ) ,
               for(Key key in listKeys )
                newInputSelected(typeInput,key),
       
           
            
             buttonAdd(),
          ],
          
        ) ,
                ),
              ),
             
            ),
            
    );
  }

   Widget textQuestion(){
     return new  Theme(
          data: new ThemeData(
            primaryColor: Color.fromRGBO(164, 203, 93, .9),
            primaryColorDark: Color.fromRGBO(164, 203, 93, .9),
            
          ),
          child: TextFormField(
             
              // decoration: InputFormulaire,
               controller: questionController,
              decoration: InputDecoration(
                  
                  icon: Icon(Icons.question_answer,color: Color.fromRGBO(42, 45, 46, .9),),
                  hintText: "Question",
                  hintStyle: TextStyle( color: Color.fromRGBO(42, 45, 46, .9)),
              
             
                 
                ),
                style: TextStyle(
                fontSize: 15.0,
                color: Color.fromRGBO(42, 45, 46, .9)    
              ),
                
                onChanged : (val)
                {
             setState(() => cardModel.question=val);
                }, validator: (value) {
                if (value.isEmpty) {
                  return 'remplir ce champs';
                }
                return null;
              },
              ),);

   }

  
   Widget listChoix(){
     return  new DropdownButton<String>(
                hint: Text(typeInput),
                items: inputsType.map((String value) {
                 return new DropdownMenuItem<String>( 
                   value: value, 
                   child: new Text(value), 
                   ); 
                   }).toList(), 
                onChanged:  (val) async{
                    setState(() { typeInput=val;
                     typeInput2=val;
                      cardModel.inputType=val;
                     cardModel.idCard=widget.key.toString();
                   listContextInput.clear();
                    });
                 testValue(val);
                 addInputToList(typeInput);
              }, 
              
              );
   }



    Widget newInputSelected(String value, Key key) {
      Widget choix = SizedBox();

     if(value==inputsType[0]){
              choix= SizedBox( child: newListDeroul(key),);
                }else if(value==inputsType[1]){
                choix= SizedBox( child:  newRadioButton(key));
          
                }else if(value==inputsType[2]){
                  setState(() { i++; });
                 choix=  SizedBox( child: newCheck(key),);
                 i++;
                
                } 
                 return  choix; 
  }

  
  Widget inputTextOnly(){
    Widget choix= SizedBox();
if(typeInput2==inputsType[3]){
                 choix= SizedBox(child: TextField( enabled: false,  decoration: new InputDecoration(
                hintText: 'Rédiger un text',
              ),) );
                }
   return choix;
  }

   Widget buttonAdd() {
     return new RaisedButton(
               child:  Icon(Icons.add),
               color:Color.fromRGBO(130, 224, 170  , .9),
               onPressed: () async{
                counter();
               },
              );
   }

   //***************SIMPLE FUNCTIONS *********************
    counter(){ setState(() {
           listKeys.add(UniqueKey());
             });}

    addInputToList(String inpt){ setState(() {
      listValues.add(inpt);
    });}
    
    addInputContext(String inpt){ setState(() {
      listContextInput.add(inpt);
    });}

    testValue(String value){
      if(listValues[listValues.length-1]!=value){
        listKeys.clear();
       // listContextInput.clear();
      }
    }

    ///*********CHECKKKKK */
      Widget newCheck(Key key){
     return new  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: <Widget>[
             Row(
            children: <Widget>[
              Expanded(
                 flex: 1,
                 child: Container(
                   child:  SizedBox(
                  width: 100,
                  child: Icon(Icons.check_box, color: Color.fromRGBO(42, 45, 46, .9),),
                  ),
                 ),
              ),
              Expanded(
                flex: 5,
                 child: Container(
                  child: SizedBox(
                    width: 100,
                    child:  inptText(key) ,
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
             );
   }

  
   Widget inptText(Key key){
     return new Theme(
          data: new ThemeData(
            primaryColor: Color.fromRGBO(164, 203, 93, .9),
            primaryColorDark: Color.fromRGBO(164, 203, 93, .9),
            
          ),
          child: TextFormField(
          // controller: inptTextController,
       key: key,
     onChanged: (value){
       setState(() {
         inputTest=value;
        
       });
     },
     validator: (value) {
    if (value.isEmpty) {
      return 'remplir ce champs';
    }
    return null;
  },
      onTap: () async{
        listContextInput.add(inputTest);
       // listContextInput.add(value);
      },
       decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0,),
      hintText: 'Option  ',//+ i.toString(),
       )
     ),);
     
   }
  

 ///******************RADIO BUTTON */
 Widget newRadioButton(Key key){
     return new  Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: <Widget>[
             Row(
            children: <Widget>[
             Expanded(
                   flex: 0,
                    child: SizedBox(
                width: 200,
                child:  radioWidget(key),
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
             ),]
             );
   }

   Widget radioWidget(Key key){
         return new  ListTile(
           
                 title: inptText(key),
                  leading: Radio(
                    activeColor: Color.fromRGBO(42, 45, 46, .9) ,
                    value: key,
                    groupValue: key,
                    onChanged: (val) {
                      },
            ),
            );
   }

/////********LIST DEROULANTE */
 Widget newListDeroul(Key key){
     return new Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: <Widget>[
             Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(Icons.indeterminate_check_box, color: Color.fromRGBO(42, 45, 46, .9),)),

                   Expanded(
                     flex: 5,
                     child:  SizedBox(
                    width: 100,
                    child: inptText(key),
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
                            
           
          ]),]
             );
    
   }
    

}


  