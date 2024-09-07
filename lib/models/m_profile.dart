class ProfileModel {
  ProfileModel({
    this.name,
    this.phoneNumber,
    this.gender,
    this.email,
  });

  // PersonalInformationModel.fromJson(dynamic json) {
  //   phoneNumber = json['phoneNumber'];
  //   companyName = json['companyName'];
  //   pictureUrl = json['pictureUrl'];
  //   businessCategory = json['businessCategory'];
  //   language = json['language'];
  //   countryName = json['countryName'];
  // }
  String? name;
  dynamic phoneNumber;
  String? gender;
  String? email;
}
