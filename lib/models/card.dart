class CardModel {
  String idCard;
  String idForm;
  String question;
  String inputType;
  List<String> listContextInput;
  List<String> listResponses; 
  CardModel({this.idCard,this.question,this.inputType,this.listContextInput,this.idForm,this.listResponses});
}