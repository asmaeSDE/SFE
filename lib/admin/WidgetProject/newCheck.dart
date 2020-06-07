import 'package:flutter/material.dart';
class NewCheck extends StatelessWidget {
  final int increment;
   String inputCheck;
   NewCheck({Key key,this.increment, this.inputCheck}) : super(key: key);
  @override
   
   Widget build(BuildContext context){
     return new  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: <Widget>[
            SizedBox(
  width: 100,
  child: inptText(this.increment),
   ),
            SizedBox(
  width: 100,
  child:  newCheckbox(),
   ),
           
          ]
             );
   }

   Widget newCheckbox(){
   return new Checkbox(
                   value: false,
                    onChanged: (val) {
                     
                      },
                  );
   }
   Widget inptText(int i){
     return new TextField(
       onChanged: (val){
         this.inputCheck=val;
       },
       decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0,),
      hintText: 'Option  '+ i.toString(),
       )
     );
   }
  
  
}