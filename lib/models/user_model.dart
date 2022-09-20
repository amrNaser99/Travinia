class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? token;
  final String? createdAt;
  final String? updatedAt;
  final String? image;
  final String? googleId;


  UserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.token,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.googleId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      token: json['token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['image'],
      googleId: json['google_id'],
    );
  }
}
