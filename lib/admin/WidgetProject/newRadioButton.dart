import 'package:flutter/material.dart';
class NewRadio extends StatefulWidget {
   NewRadio({Key key}) : super(key: key) ;
  @override
  _NewRadioState createState() => _NewRadioState();
}
class _NewRadioState extends State<NewRadio> {
   String inputRadio ='';
  
  @override
   
   Widget build(BuildContext context){
     return new  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
             SizedBox(
  width: 200,
  child:  radioWidget(),
   ),
        
          ]
             );
   }

   Widget radioWidget(){
         return new  ListTile(
                  title: TextField(
                    onChanged: (val)
                {
              setState(() => inputRadio = val);
                },
                  ),
                  leading: Radio(
                    value: inputRadio,
                    groupValue: inputRadio,
                    onChanged: (val) {
                      },
            ),
            );
   }
  
  
}