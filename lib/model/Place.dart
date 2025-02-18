class Place {
  final int id;
  final String name;
  final String description;
  final String? imageUrl;

  Place({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    const baseUrl = 'http://zabron.space/uploads/'; // замените на адрес вашего сервера
    String? rawImageUrl = json['image'];
    String? fullImageUrl = "";
    // Если приходит локальный путь, дополняем его базовым URL-ом
    if (rawImageUrl != null) {
      fullImageUrl = rawImageUrl.startsWith('http')
          ? rawImageUrl
          : '$baseUrl$rawImageUrl';
    }

    return Place(
      id: json['ID'],
      name: json['Name'],
      description: json['Location'],
      imageUrl: fullImageUrl,
    );
  }
}