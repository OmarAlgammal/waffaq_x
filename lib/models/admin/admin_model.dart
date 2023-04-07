class AdminModel {
  String uid;
  String? email, name;
  bool isHeTheMainController;
  bool abilityToAddCoverComp,
      abilityToRemoveComp,
      abilityToAddMobiles;

  AdminModel(
      {required this.uid,
      this.email,
      this.name,
        this.isHeTheMainController = false,
      this.abilityToAddCoverComp = false,
      this.abilityToRemoveComp = false,
      this.abilityToAddMobiles = false,
      });

  factory AdminModel.fromJson(Map<String, dynamic> map) => AdminModel(
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
