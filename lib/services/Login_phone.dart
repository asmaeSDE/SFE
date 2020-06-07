import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programe/USER/screens/home/home.dart';
import 'package:programe/shares/constant.dart';
import 'package:programe/admin/home/home.dart';


class Login_phone extends StatefulWidget {
  @override
  _Login_phoneState createState() => _Login_phoneState();
}

class _Login_phoneState extends State<Login_phone> {
  @override

  String email ='';
 String password ='';
 final _formKey = GlobalKey<FormState>();
String phoneNo;
String smsCode;
String verificationId;
  bool codeSent = false;

Future<void> sendCodeToPhoneNumber() async {
final PhoneCodeAutoRetrievalTimeout autoRetreive = (String verId)
{
  this.verificationId =verId;
};
final PhoneCodeSent smsCodeSent =(String verId,[int forceCodeResend])
{
  this.verificationId = verId;
  this.codeSent =true;

};

final PhoneVerificationCompleted verifiedSuccess = ( AuthCredential user)
{
print('verified');
};

final PhoneVerificationFailed verificationFaild =(AuthException exception)
{

print( '${exception.message}');
};

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      
         codeAutoRetrievalTimeout: autoRetreive,
         codeSent:  smsCodeSent,
         timeout: const Duration(seconds: 5),
         verificationCompleted: verifiedSuccess,
         verificationFailed:  verificationFaild,
         );
    
}


Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  final userID =   await FirebaseAuth.instance.signInWithCredential(credential);

     var result = await Firestore.instance
      .collection("user")
      .where("ID_user", isEqualTo: userID.user.uid)
      .getDocuments();
  result.documents.forEach((res) {
   if(res.data['Telephone']==phoneNo)
   {

                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => home()));
              

   }else
   {
    
               print('zmr');
              
 
   }
  });
      
  }


Future<void>  smsCodeDialogue(BuildContext context)
{
  return showDialog(context: context,
  barrierDismissible:  false,
  builder: (BuildContext context)
  {
    return new AlertDialog(
      title:Text('Enter sms Code'),
      content: TextField(
        onChanged : (value)
        {
          this.smsCode = value;
        },
      ),
       actions: <Widget>[
      FlatButton(
            child: Text("Connecter"),
            onPressed: () {
FirebaseAuth.instance.currentUser().then((user){
                  if(user !=null){

                    signIn(smsCode);
                     Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => home()));
                  }else{
                    Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => Login_phone())); 
                  }


            }
            
          );
            }
      ),
            
    
           FlatButton(
            child: Text("Renvoyer"),
            onPressed: () {
              //Put your code here which you want to execute on No button click.
             sendCodeToPhoneNumber();

            },
          ),
      
       ],
      
    );
  }
  );
  
}

String numberValidator(String value) {
  if(value == null) {
    return null;
  }
  final n = num.tryParse(value);
  if(n == null) {
    return '"$value" is not a valid number';
  }
  return null;
}

  Widget build(BuildContext context) {
  
    return  Scaffold(
      resizeToAvoidBottomPadding: false ,
      backgroundColor: Colors.green[255],

body: Container(
  decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.green, Colors.orange])),
  padding: EdgeInsets.symmetric(vertical:10.0,horizontal:50.0),
  child : Form( 
    key: _formKey,
    child: Column(
children: <Widget>[
       SizedBox(height: 200.0),

  SizedBox(
          height: 120.0,
          child: Image.asset(
            "images/logo.png",
            fit: BoxFit.contain,
          ),
        ),
 SizedBox(height: 30.0),
TextFormField(
  keyboardType: TextInputType.phone,
 decoration: InputDecoration(
             
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0,15.0),
              hintText: "+212",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
                  borderSide:  BorderSide(color: Colors.orange, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(borderSide:  BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.circular(32.0)) ,
                focusColor: Colors.green,
                fillColor: Colors.green,
                  ),
   validator: (val) => numberValidator(phoneNo),
  
onChanged: (val)
{
setState(() => phoneNo = val);
},
),


SizedBox(height:30.0),

 new FloatingActionButton.extended(
        onPressed: () {
smsCodeDialogue(context);
sendCodeToPhoneNumber();
        },
        tooltip: 'get code',
        icon: Icon(Icons.send),
        label: Text('Envoyer Code '),
        backgroundColor: Colors.green[200],
      ), // This trailing comma makes auto-formatting nicer for build methods.

],
    ), 
  
  ),

  
),
    );


  }
      
}

