class User
{

  final String uid;
  final String nom; 
  final String prenom;
  final String email;
  final String cine;
  final String url;
  final bool access;
  final String role;
  final String telephone;
  

User({this.uid,this.nom,this.prenom,this.email,this.cine,this.url,this.access,this.role,this.telephone});


User.fromData(Map<String,dynamic> data)
:uid = data['uid'], nom =data['nom'], prenom=data['prenom'] ,email=data['email'], cine =data['cine'] , url =data['image'] , access=data['access'], role=data['role'],telephone=data['Telephone'];


Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nom': nom,
      'prenom':prenom,
      'email': email,
      'cine': cine,
      'image' :url,
      'access' :access,
      'role' : role,
      'Telephone':telephone,
    };
  }

}

