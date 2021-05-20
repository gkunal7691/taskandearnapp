class About {
  String title;
  String gender;
  String phone;
  String dob;
  String skills;
  String introduction;
  double price;

  About({
      this.title,
      this.gender,
      this.phone,
      this.dob,
      this.skills,
      this.introduction,
      this.price,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
    title: json["title"],
    gender: json["gender"],
    phone: json["phone"],
    dob: json["dob"],
    skills: json["skills"],
    introduction: json["introduction"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "gender": gender,
    "phone": phone,
    "dob": dob,
    "skills": skills,
    "introduction": introduction,
    "price": price,
  };
}