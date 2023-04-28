class CatagoryRecipie {
  CatagoryRecipie({
    this.name,
    this.cookTime,
    this.recipeImg,
    this.id,
    this.instructions,
    this.ingredients,
    this.about
  });

  String ?name;
  String ?cookTime;
  String ?recipeImg;
  String ?id;
  List<String> ?instructions;
  List<String> ?ingredients;
  String ? about;

  factory CatagoryRecipie.fromMap(Map<String, dynamic> json) => CatagoryRecipie(
    name: json["name"],
    cookTime: json["cook time"],
    recipeImg: json["recipe_img"],
    id: json["id"],
    about: json["about"],
    instructions: List<String>.from(json["Instructions"].map((x) => x)),
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "cook time": cookTime,
    "recipe_img": recipeImg,
    "id": id,
    "about":about,
    "Instructions": List<dynamic>.from(instructions!.map((x) => x)),
    "ingredients": List<dynamic>.from(ingredients!.map((x) => x)),
  };
}
