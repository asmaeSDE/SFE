import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:programe/models/user.dart';

class DatabaseService 
{

final String uid;

DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection("user");
  
  final CollectionReference _userCollection = Firestore.instance.collection("user");

Future createUserData(User user)
async {
 try {
      await _userCollection.document(user.uid).setData(user.toJson());
    } catch (e) {
      return e.message;
    }


}

Future updateUserData(String name ,String lastName , int age)
async {
 return await userCollection.document(uid).setData({
   'name' : name,
   'lastName' : lastName,
   'age' : age
 });

}

updateUserAccess(String selectedDocument, newValue)
 async {
 Firestore.instance
 .collection('user')
 .document(selectedDocument)
 .updateData({"access": newValue});
}

 Future getUsers() async{
        var firestore = Firestore.instance;
       QuerySnapshot query = await  firestore.collection('user').getDocuments();
  return query.documents;
  
   }

}