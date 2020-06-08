import 'package:flutter/material.dart';
class NewRadio extends StatefulWidget {
  final String inputRadio;
   NewRadio({Key key,this.inputRadio}) : super(key: key) ;
  @override
  NewRadioState createState() => NewRadioState();
}
class NewRadioState extends State<NewRadio> {
    String groupValue;
  
  @override
   
   Widget build(BuildContext context){
     return new   SizedBox(
                     width: 200,
                     height: 100,
       child: Container(
         child:ListTile(
             
                   title: Text(widget.inputRadio),
                    leading: Radio(
                      activeColor: Color.fromRGBO(42, 45, 46, .9) ,
                      value: widget.inputRadio,
                      groupValue: groupValue,
                      onChanged:  (newValue) async{
                        print(newValue);
                        setState(() {
                           groupValue = newValue;
                        });
                        },
              ),
              ),),);
   }

  
}