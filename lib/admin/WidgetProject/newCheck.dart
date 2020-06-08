import 'package:flutter/material.dart';
class NewCheck extends StatefulWidget {

   String inputCheck;
   
   NewCheck({Key key, this.inputCheck}) : super(key: key);
  @override
  NewCheckState createState() => NewCheckState();
}

class NewCheckState extends State<NewCheck> {
  
  bool checkedValue=false;
  List<String> responses=[];
   Widget build(BuildContext context){
     return SizedBox(
                     width: 200,
                     height: 100,
       child: Container(
         child: new CheckboxListTile(
    title: Text(widget.inputCheck),
    value: checkedValue,
    onChanged: (newValue) { 
                   setState(() {
                     checkedValue = newValue; 
                   }); 
    if(newValue==true){
    setState(() {
      responses.add(widget.inputCheck);
    }); 
    }
                 },
    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
  ),
       ),
     );
   }

  
}