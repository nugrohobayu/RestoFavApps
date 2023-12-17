class RequestReviewModel {
  String id;
  String name;
  String review;

  RequestReviewModel({
    required this.id,
    required this.name,
    required this.review,
  });

  factory RequestReviewModel.fromJson(Map<String, dynamic> json) =>
      RequestReviewModel(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
