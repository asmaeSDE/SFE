import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:programe/admin/WidgetProject/newCard.dart';
import 'package:programe/admin/listForms/listForm.dart';
import 'package:programe/services/formService.dart';
import 'package:programe/models/form.dart';
import 'package:programe/models/card.dart';
import 'package:programe/shares/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
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
  Future uploadImage(BuildContext context) async{
     String fileName=_image.path.toString();
     StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(fileName);
     StorageUploadTask uploadTask=firebaseStorageRef.putFile(_image);
     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
     setState(() {
       print("IMAAAAAAAAAAAAAAAAGE");
       Scaffold.of(context).showSnackBar(SnackBar(content: Text('Image de votre formulaire est téléchargée!'),));
     });
   }
  Widget build(BuildContext context){
   Future getImageForm() async{
     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
     setState(() {
       _image=image;
       print('Image pth$_image');
     });
   }
  
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
                 Container(
  height: 160,
  width: 150,
  
  decoration: BoxDecoration(
   
    boxShadow: [
      BoxShadow(
        color:Colors.white,
        blurRadius :5.0,
        
      )
    ],
    
    
   image : DecorationImage(
     
    image: _image == null
        ? AssetImage('images/logo.png')
        : FileImage(_image),
     
     fit: BoxFit.contain,
     
   ) 
  ),
alignment: Alignment.bottomRight,
//child:(_image!=null)?Image.file(_image,fit:BoxFit.fill),
child: IconButton(
  icon: Icon(
    FontAwesomeIcons.camera,
    size: 23.0,
    color:Colors.black54,
  ),
   onPressed: (){
getImageForm();
   }),

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
                  setState(() => formTest.description = val);
                    },
                        ), ],
          ),
        ),
    ),
  ],
),


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

                             String filename=basename(_image.path);
StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
StorageUploadTask uploadTasck = firebaseStorageRef.putFile(_image);
StorageTaskSnapshot taskSnapshot = await uploadTasck.onComplete;
var url = await taskSnapshot.ref.getDownloadURL();
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
                      if(itemKey.currentState.cardModel.inputType=='Paragraphe'){
                        testList.add('');
                         itemKey.currentState.cardModel.listContextInput=testList;
                      }
                      if( itemKey.currentState.cardModel.inputType=='' || itemKey.currentState.cardModel.inputType==null){
                        itemKey.currentState.cardModel.inputType='Paragraphe';
                      }


                      formDAO.createCard(itemKey.currentState.cardModel); 
                      i=true;
                        }
                     }else{
                       i=false;
                    showMyDialog(context);
                     }
                    }
                    if(i==true){
                      formTest.url=url;
                       setState(() {
                 
                     formTest.url=url;
                       });
                      formDAO.createForm(formTest);
                     for(GlobalKey<NewCardState> itemKey in listKeysCard){
                      
                      itemKey.currentState.resetForm();
                    //   itemKey.currentState.listContextInput.clear();
                     }
                     
                     setState(() {
                     listKeysToString.clear();
                     listKeysCard.clear();
                  
                   //  keyForm.currentState.reset();
                     _formKey.currentState.reset();
                    titleController.clear();
                    descriptionController.clear();
                     
                     });
                     
                    
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



