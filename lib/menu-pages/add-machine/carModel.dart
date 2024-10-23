import 'dart:convert';

class Car {
  final String? imagePath;
  final String title;
  final String description;
  final int year;
  final String? pdfPath;

  Car({
    this.imagePath,
    required this.title,
    required this.description,
    required this.year,
    this.pdfPath,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      imagePath: json['imagePath'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      year: json['year'] as int,
      pdfPath: json['pdfPath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'title': title,
      'description': description,
      'year': year,
      'pdfPath': pdfPath,
    };
  }
}
