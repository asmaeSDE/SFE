import 'package:flutter/material.dart';
class NewListDerol extends StatefulWidget {
   NewListDerol({Key key}) : super(key: key);
  @override
  _NewListDerolState createState() => _NewListDerolState();
}
class _NewListDerolState extends State<NewListDerol> {
  @override
   Widget build(BuildContext context, ){
     return new  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
          children: <Widget>[
                    SizedBox(
                    width: 100,
                    child: inptText(),
                    ),
                            
           
          ]
             );
    
   }
     Widget inptText(){
     return new TextField(
       decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0,)
       )
     );
   }
}