class Product {
  final String name;
  final String subtitle;
  final String imageUrl;
  final String description;
  final String pdfUrl;
  final String webPageUrl;
  final String year;

  const Product({
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.description,
    required this.pdfUrl,
    required this.webPageUrl,
    this.year = '2024', // default value
  });
}
