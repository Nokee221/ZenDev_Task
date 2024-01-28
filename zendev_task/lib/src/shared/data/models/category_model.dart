class Category {
  final String title;

  Category({
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}

List<Category> tempCategories = [
  Category(title: 'all'),
  Category(title: 'electronics'),
  Category(title: 'jewelery'),
  Category(title: 'men\'s clothing'),
  Category(title: 'women\'s clothing'),
];
