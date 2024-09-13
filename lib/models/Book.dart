

class Book {
  final String title;
  final String author;
  final String genre;
  final String description;
  final String image;
  final String date;
  final String publisher;

  Book({
    required this.title,
    required this.author,
    required this.genre,
    required this.date,
    required this.description,
    required this.image,
    required this.publisher,
  });
    factory Book.fromJson(Map<String, dynamic> json) {

    return Book(
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      date: json['published'],
      description: json['description'],
      image: json['image'],
      publisher: json['publisher'],
    );
  }

}