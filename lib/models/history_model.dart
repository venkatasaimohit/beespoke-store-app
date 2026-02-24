class HistoryItem {
  final String title;
  final String image;
  final String url;

  HistoryItem({
    required this.title,
    required this.image,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'url': url,
    };
  }

  factory HistoryItem.fromMap(Map map) {
    return HistoryItem(
      title: map['title'],
      image: map['image'],
      url: map['url'],
    );
  }
}