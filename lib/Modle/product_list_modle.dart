
class ProductListModel {
    String? title;
    String? description;
    List<String>? ingredients;
    String? image;
    int? id;

    ProductListModel({this.title, this.description, this.ingredients, this.image, this.id});

    ProductListModel.fromJson(Map<String, dynamic> json) {
        title = json["title"];
        description = json["description"];
        ingredients = json["ingredients"] == null ? null : List<String>.from(json["ingredients"]);
        image = json["image"];
        id = json["id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["title"] = title;
        _data["description"] = description;
        if(ingredients != null) {
            _data["ingredients"] = ingredients;
        }
        _data["image"] = image;
        _data["id"] = id;
        return _data;
    }

    static List getProductList(List result){
      return result.map((e) => ProductListModel.fromJson(e)).toList();
    }
}