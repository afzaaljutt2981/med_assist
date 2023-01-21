class IdConfirmationModel {
  String idConfirmation;

  IdConfirmationModel({required this.idConfirmation});

  Map<String, dynamic> toJson() => {
    'idConfirmation': idConfirmation
  };

  static IdConfirmationModel fromJson(Map<String, dynamic> Json) =>
      IdConfirmationModel(idConfirmation: Json['idConfirmation']);
}
