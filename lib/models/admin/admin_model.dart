class UserModel {
  String uid;
  String? email, name;
  bool isHeTheMainController;
  bool abilityToAddCoverComp,
      abilityToRemoveComp,
      abilityToAddMobiles;

  UserModel(
      {required this.uid,
      this.email,
      this.name,
        this.isHeTheMainController = false,
      this.abilityToAddCoverComp = false,
      this.abilityToRemoveComp = false,
      this.abilityToAddMobiles = false,
      });

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        isHeTheMainController: map['isHeTheMainController'] as bool,
        abilityToAddCoverComp: map['addCoverComp'],
        abilityToRemoveComp: map['removeCom'] ,
        abilityToAddMobiles: map['addMobiles'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'email': email,
        'name': name,
        'isHeTheMainController': isHeTheMainController,
        'addCoverComp': abilityToAddCoverComp,
        'removeCom': abilityToRemoveComp,
        'addMobiles': abilityToAddMobiles,
      };
}
