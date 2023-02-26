class ContactOption {
  final String name;
  final String url;
  final String image;

  ContactOption(this.name, this.url, this.image);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'image': image,
    };
  }

  Map<String, dynamic> toMap2(int id) {
    return {
      'contact_id': id,
      'name': name,
      'url': url,
      'image': image,
    };
  }

  factory ContactOption.fromJson(dynamic json) {
    return ContactOption(
        json['name'] as String, json['url'] as String, json['image'] as String);
  }

  @override
  String toString() {
    return '{name: $name, url: $url, image: $image}';
  }
}
