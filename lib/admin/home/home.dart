
import 'package:flutter/material.dart';
import 'package:programe/admin/WidgetProject/newForm.dart';
import 'package:programe/services/auth.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:programe/admin/listForms/listForm.dart';
import 'package:programe/admin/ListUsers/listUser.dart';
class Home extends StatefulWidget  {
  
     @override
     _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  int _screen = 0;
  @override
  Widget build(BuildContext context) {
    
    const List<String> tabNames = const<String>[
     'Accueil', 'Utilisateurs','Formulaires'
];
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        bottomAppBarColor: Color.fromRGBO(42, 45, 46, .9),
        scaffoldBackgroundColor:  Color.fromRGBO(253, 235, 208 , .9),
      ),
    home: Scaffold(
      appBar: AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(253, 235, 208 , .9),
      title: Text('Espace Administrateur',style: TextStyle(color: Color.fromRGBO(92, 150, 113 , .9),fontFamily: 'Oswald')),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list,color: Color.fromRGBO(25, 111, 61 , .9),),
          onPressed: () {},
        )
      ],
    ),

   
       body: Container(
         child: new DefaultTabController(
           length: tabNames.length,
           child: new Scaffold(
             
             body: new TabBarView(
               children: new List<Widget>.generate(tabNames.length, (int index) {
                 switch (_screen) {
                   case 0: return Center(
                     child: new  Container(
              height: 500,
              width: 500,
             decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Slide1.png"),
            fit: BoxFit.cover,
          ),
        ),
                   ));
                   case 1: return new Center(
                     child: ListUsers(),
                   );
                    case 2: return new  Column(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child:
                         SizedBox(width: 500.0,
                        height: 100.0,
                        child: ListForms(),)),
                        Expanded(child: 

                        Center(
                          child: RaisedButton.icon( 
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text('Ajouter un nouveau formulaire', 
                          style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.forum, color:Colors.white,), 
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Color.fromRGBO(25, 111, 61 , .9),
         onPressed: (){
                Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return new NewForm();
                }));
              },
      ),
                        ),
   ),
                  
      ],
                   );
                    
                 }
               }),
             ),

             bottomNavigationBar: 
             new Theme(
    data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor:   Color.fromRGBO(25, 111, 61 , .9),
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.white,
          textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.white24))), // sets the inactive color of the `BottomNavigationBar`
   child : new Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 new BottomNavigationBar(
                   
                   currentIndex: _screen,
                   onTap: (int index) {
                   setState(() {
                       _screen = index;
                   });
                     
                   
                   },
                   items: [
                     new BottomNavigationBarItem(
                       icon: new Icon(Icons.home),
                       title: new Text('Accueil'),
                     ),
                     new BottomNavigationBarItem(
                       icon: new Icon(Icons.contacts),
                       title: new Text('Utilisateurs'),
                     ),
                      new BottomNavigationBarItem(
                       icon: new Icon(Icons.filter_list),
                       title: new Text('Formulaires'),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ),
    ),
       )
    )
      );
    
  }
}
