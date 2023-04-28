
class Userdata {
  String ?email;
  String ?name;
  String ?gender;
  String ?profile_pic_url;
  DateTime ? createdAt;
  Userdata({this.email,this.name,this.gender,this.profile_pic_url,this.createdAt});

  factory Userdata.fromMap(map) {
    return Userdata(
      name: map['name'],
      email: map['email'],
      gender: map['gender'],
      createdAt: map[' createdAt'],
      profile_pic_url: map['profile_pic_url']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
        'gender': gender,
        ' createdAt':createdAt,
      'email': email,
      'profile_pic_url': profile_pic_url
    };
  }
}