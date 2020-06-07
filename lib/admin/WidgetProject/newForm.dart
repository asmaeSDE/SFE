import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:programe/admin/WidgetProject/newCard.dart';
import 'package:programe/services/formService.dart';
import 'package:programe/models/form.dart';
import 'package:programe/models/card.dart';
import 'package:programe/shares/constant.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//var myCard= NewCard();
final keyCard = new GlobalKey<NewCardState>();
final List<GlobalKey<NewCardState>> listKeysCard=[];

class NewForm extends StatefulWidget {
  @override
NewFormState createState() => new NewFormState();
}
class NewFormState extends State<NewForm>{
  File _image;
  final titleController= TextEditingController();
  final descriptionController= TextEditingController();
  int newVal=1;  
  int lastVal=0;
  List<Key> listKeys=[];
  CardModel testModel ;
  List<String> testList;
  String inputTest;
  final FormService formDAO = new FormService();
List<String> listKeysToString=[];
int valInt=0;

    final _formKey = GlobalKey<FormState>();
  Formulaire formTest= new Formulaire();
    @override
  


Future getImage() async{
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  setState(()
  {
    _image =image;
    print('Image path $_image');

  });
  return image;
  } 
  Widget build(BuildContext context){
   
    return new Scaffold(
   backgroundColor: Color.fromRGBO(25, 111, 61 , .9),
      appBar: new AppBar(
        title: Text('Nouveau Formulaire',style: TextStyle(color:Color.fromRGBO(25, 111, 61 , .9)),),
        
         backgroundColor: Color.fromRGBO(253, 235, 208 , .9),
      ),
      
      body: Form(
        key: _formKey,
        child: new Center(
        
          child: new ListView(
            
           children: <Widget>[
             Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Row(),
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 32.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child:CircleAvatar(radius: 100,
                backgroundColor: Color.fromRGBO(25, 111, 61 , .9),
                child: ClipOval(
                  child:SizedBox(
                    width: 120,
                    height: 120.0,
                    child: _image == null
        ? AssetImage('images/icon.png')
        : FileImage(_image),
                   
                    ),
                ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:80.0,left: 0),
                child: IconButton(icon: Icon(Icons.camera_alt,size:25.0,color: Colors.white,), 
                onPressed: (){
                 getImage();
                }
                
                ),
              ),
              ]),
             
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,12.0),
                child: Text("Nom de formulaire", style: TextStyle(fontSize: 20.0, color: Colors.white),),
              ),
              TextFormField(decoration: inputFormulaire,
               controller: titleController,
                  onChanged: (val)
                    {
                    setState(() => formTest.title = val);
                    },
                    validator: (value) {
    if (value.isEmpty) {
        return 'remplir ce champs';
    }
    return null;
  },
                        ),
                        
              Text("Ajouter une description", style: TextStyle(color: Colors.white),),
             TextFormField(
               controller: descriptionController,
               decoration: inputDescription,
                  onChanged: (val)
                    {
                   // setState(() => formTest.title = val);
                    },
                        ), ],
          ),
        ),
    ),
  ],
),
               Text('Title Form:',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),), 
            
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
                    flex: 1,
                    child: Container(
                      // tag: 'hero',
                      child:  SizedBox(
                    //   height: 20,
                       width: 10,
                        child : IconButton(
                         icon:  Icon(Icons.delete,size: 30,color: Color.fromRGBO(208, 211, 212  , .9)),
                         
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
             Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
    
          child:  buttonRegisterForm(context) ,
             ),
            ],         
          )
        ),
      ),
       floatingActionButton: FloatingActionButton(
       
          backgroundColor: Color.fromRGBO(253, 235, 208 , .9),
       onPressed: (){
            counter();
            },
        child: Icon(Icons.add,color: Color.fromRGBO(25, 111, 61 , .9),),
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
  
  Widget buttonRegisterForm(BuildContext context){
    return  SizedBox(
             // width: double.infinity,
             width: 50,
              child:  RaisedButton(
                 
                          onPressed: () async{
                          //  uploadImage(context);
              // if (_formKey.currentState.validate()) {
                bool i=false;
                setState(() {
                  for(GlobalKey<NewCardState> itemKey in listKeysCard){
                  listKeysToString.add(itemKey.toString()); 
                   }
                   });
                  
                   formTest.listCards=listKeysToString;
                   var keyForm = new GlobalKey<FormState>();
                   formTest.idForm= keyForm.toString();
                    for(GlobalKey<NewCardState> itemKey in listKeysCard){ 
                      itemKey.currentState.validateAndSave();
                     if(itemKey.currentState.validateform()==true){
                        if (_formKey.currentState.validate()) {
                      print(itemKey.currentState.cardModel.question);
                      itemKey.currentState.listContextInput.add(itemKey.currentState.inputTest);
                     setState(() {
                      testList=itemKey.currentState.listContextInput;
                      
                     });
                      itemKey.currentState.cardModel.listContextInput=testList;
                      itemKey.currentState.cardModel.listContextInput.removeWhere((value) => value == null);
                      itemKey.currentState.cardModel.idForm= formTest.idForm;
                      formDAO.createCard(itemKey.currentState.cardModel); 
                      i=true;
                        }
                     }else{
                       i=false;
                    showMyDialog(context);
                     }
                    }
                    if(i==true){formDAO.createForm(formTest);
                     for(GlobalKey<NewCardState> itemKey in listKeysCard){
                      itemKey.currentState.resetForm();
                    //   itemKey.currentState.listContextInput.clear();
                     }
                     
                     setState(() {
                     listKeysToString.clear();
                     listKeysCard.clear();
                     });
                     keyForm.currentState.reset();
                     _formKey.currentState.reset();
                    }
                  
                  
                 //  }
                   
               },
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(50, 111, 30 , .9),
                                  Colors.greenAccent
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                                'Enregistrer',
                                style: TextStyle(fontSize: 15,color: Colors.black)
                            ),
                          ),
                        )
            );
  } 
    counter(){ setState(() {
               listKeysCard.add(new GlobalKey<NewCardState>());
             });}
  
}



