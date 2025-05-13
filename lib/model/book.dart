// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  final String title;
  final String author;
  final String imageUrl;
  final String description;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
  });

  Book copyWith({
    String? title,
    String? author,
    String? imageUrl,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'description': description,
    };
  }


  factory Book.fromJson(Map<String, dynamic> json) {
  return Book(
    title: json['title'] as String,
    author: json['author'] as String,
    description: json['description'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

  String toJson() => json.encode(toMap());

  
  @override
  String toString() {
    return 'Book(title: $title, author: $author, imageUrl: $imageUrl, description: $description)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.author == author &&
      other.imageUrl == imageUrl &&
      other.description == description;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      author.hashCode ^
      imageUrl.hashCode ^
      description.hashCode;
  }
}
