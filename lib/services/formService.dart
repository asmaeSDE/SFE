import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programe/models/form.dart';
import 'package:programe/models/card.dart';
class FormService 
{
  final CollectionReference formCollection = Firestore.instance.collection("Formulaire");
  final CollectionReference cardCollection = Firestore.instance.collection("card");
   final databaseReference = Firestore.instance;

  void createForm(Formulaire formulaire) async {
 
  DocumentReference ref = await databaseReference.collection("Formulaire")
      .add({
        'title': formulaire.title,
        'idForm': formulaire.idForm,
        'keyCards': formulaire.listCards,
      });
  print(ref.documentID);
}

void createCard(CardModel card) async {
 
  DocumentReference ref = await databaseReference.collection("card")
      .add({
        'idCard': card.idCard,
        'idForm': card.idForm,
        'inputType': card.inputType,
        'listContextInput': card.listContextInput,
        'question': card.question,
      });
  print(ref.documentID);
}
// list Form


List<Formulaire> listFromSnapShot(QuerySnapshot snapshot)
{
  return snapshot.documents.map((doc) {
return Formulaire(
  title: doc.data['title'] ??''
);

  }).toList();
}

Stream<List<Formulaire>> get test 
{
  return formCollection.snapshots()
  .map(listFromSnapShot);
}



/*
List<CardModel> getCardById(List<String> listIdCards)
  {  
    return List(
      cardCollection.document(id)
    )
   List<CardModel> listCards = new List<CardModel>();
 DocumentSnapshot cardId ;
   for(String id in listIdCards)
   cardId = await cardCollection.document(id).get();
      listCards.add(new CardModel(idCard: cardId.documentID ,question: cardId.data['question'],inputType: cardId.data['inputType'],listContextInput: cardId.data['listContextInput'] ));
  return listCards;
}*/
/*
 List<CardModel>_getCardItems(QuerySnapshot snapshot)
{
  return snapshot.documents.map((doc) {
return Test(
  name: doc.data['name'] ??'',
  lastName: doc.data['lastName'] ?? '',
  age: doc.data['age'] ?? 0
);

  }).toList();
}
*/

  Future<CardModel> getCardById(DocumentSnapshot groupDoc , String id){
    return Firestore.instance
        .collection('card')
        .where('idCard', isEqualTo: id)
        .getDocuments()
        .then((usersSnap) {
          CardModel card=new CardModel();
      for (var cardId in usersSnap.documents) {
        card =new CardModel(idCard: cardId.documentID ,question: cardId.data['question'],inputType: cardId.data['inputType'],listContextInput: cardId.data['listContextInput'] );
      }
      return card;
    });


    
  }
















}