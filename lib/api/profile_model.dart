class UserProfile {
  int? id;
  String? avatarid;
  String? name;
  String? email;
  int? userVerified;
  String? createdAt;
  String? updatedAt;

  UserProfile({
    this.id,
    this.avatarid,
    this.name,
    this.email,
    this.userVerified,
    this.createdAt,
    this.updatedAt,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatarid = json['avatarid'];
    name = json['name'];
    email = json['email'];
    userVerified = json['user_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatarid'] = this.avatarid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['user_verified'] = this.userVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
