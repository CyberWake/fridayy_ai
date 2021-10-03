class UserModel {
  UserModel({
    this.userName,
    this.countryCode,
    this.mobile,
    this.googleId,
    this.email,
    this.imageUrl,
    this.isActive,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'] as String;
    countryCode = json['countryCode'] as String;
    mobile = json['mobile'] as String;
    googleId = json['googleId'] as String?;
    email = json['email'] as String?;
    imageUrl = json['imageUrl'] as String?;
    isActive = json['isActive'] as bool?;
  }

  String? userName;
  String? countryCode;
  String? mobile;
  String? googleId;
  String? email;
  String? imageUrl;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = this.userName;
    data['countryCode'] = this.countryCode;
    data['mobile'] = this.mobile;
    return data;
  }
}
