class Searchrescpie {
  List<String> ?rescpieimg;
  List<String> ?rescpiename;

  Searchrescpie({
    this.rescpieimg,
    this.rescpiename,
  });

  factory Searchrescpie.fromMap(Map<String, dynamic> json) => Searchrescpie(
    rescpieimg: List<String>.from(json["rescpieimg"].map((x) => x)),
    rescpiename: List<String>.from(json["rescpiename"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "rescpieimg": List<dynamic>.from(rescpieimg!.map((x) => x)),
    "rescpiename": List<dynamic>.from(rescpiename!.map((x) => x)),
  };
}
