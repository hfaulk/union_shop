import 'package:flutter/foundation.dart';

@immutable
class Collection {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;

  const Collection({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: (json['id'] ?? json['slug'] ?? '').toString(),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
      imageUrl: json['imageUrl']?.toString() ?? json['image']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        if (description != null) 'description': description,
        if (imageUrl != null) 'imageUrl': imageUrl,
      };

  Collection copyWith(
      {String? id, String? title, String? description, String? imageUrl}) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Collection &&
            other.id == id &&
            other.title == title &&
            other.description == description &&
            other.imageUrl == imageUrl);
  }

  @override
  int get hashCode => Object.hash(id, title, description, imageUrl);
}
