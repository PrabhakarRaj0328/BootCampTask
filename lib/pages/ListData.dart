import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dev_boot/models/Book.dart';
import 'package:flutter/material.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  bool isLoading = true;
  List<Book> books = [];

  Future<void> fetchBooks() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('https://fakerapi.it/api/v2/books?_quantity=10');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          books = (data['data'] as List).map((bookJson) {
            return Book.fromJson(bookJson);
          }).toList();
        });
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        print(books[0].author);
      } else {
        throw Exception('Failed to load books');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator(
              color: Colors.lightGreen,
            )
          : ListView(
              children: books.map<Widget>((book) {
              return Column(children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      Text('Title: ${book.title}'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Author: ${book.author}'),
                      Row(
                        children: [
                          Expanded(
                              child: Text('Description: ${book.description}'))
                        ],
                      ),
                      Text('Publisher: ${book.publisher}'),
                      Text('Pubished: ${book.date}')
                    ])),
                const SizedBox(
                  height: 20,
                )
              ]);
            }).toList()),
    );
  }
}
