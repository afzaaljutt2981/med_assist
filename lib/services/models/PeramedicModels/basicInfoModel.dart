class BasicInfoModel {
  String fname;
  String lName;
  int dob;
  String? email;
  String profileImage;

  BasicInfoModel(
      {required this.fname,
      required this.lName,
      required this.dob,
      this.email,
      required this.profileImage});
  Map<String,dynamic> toJson () =>
      {
        "firstName": fname,
        "lastName": lName,
        "dob": dob,
        "email": email,
        "profilePic": profileImage
      };
  static BasicInfoModel fromJson(Map<String, dynamic> Json) => BasicInfoModel(
      fname: Json['firstName'],
      lName: Json['lastName'],
      dob: Json['dob'],
      email: Json['email'],
      profileImage: Json["profilePic"]);


}
