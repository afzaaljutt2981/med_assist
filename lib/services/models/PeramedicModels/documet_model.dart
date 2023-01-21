class DocumentModel {
  String documentPic;

  DocumentModel({required this.documentPic});
  Map<String,dynamic> toJson () =>
      {
        'documentPic': documentPic
      };

  static DocumentModel fromJson(Map<String, dynamic> Json) =>
      DocumentModel(documentPic: Json['documentPic']);



}
