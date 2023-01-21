class CnicModel {
  String cnicBackPicUrl;
  String cnicFrontPicUrl;

  CnicModel({required this.cnicBackPicUrl, required this.cnicFrontPicUrl});

  static CnicModel fromJson(Map<String, dynamic> Json) => CnicModel(
        cnicFrontPicUrl: Json['cnicFrontPicUrl'],
        cnicBackPicUrl:  Json['cnicBackPicUrl']
      );
  Map<String,dynamic> toJson () =>
      {
        'cnicFrontPicUrl': cnicFrontPicUrl,
        'cnicBackPicUrl': cnicBackPicUrl,
      };
}
