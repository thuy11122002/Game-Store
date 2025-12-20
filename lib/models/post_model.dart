class Post {
  String image, heading, title, subtitle, description, type;
  int game_id;

  Post(
      {required this.image,
      required this.heading,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.type,
      required this.game_id});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        image: json['image'],
        heading: json['heading'],
        title: json['title'],
        subtitle: json['subtitle'],
        description: json['description'],
        type: json['type'],
        game_id: json['game_id']);
  }
}
