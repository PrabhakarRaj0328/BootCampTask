import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  String gifUrl = '';
  String api_key = 'SU2h5HxXQllbAjxE1zTd5iRnT4v7vfdO';
  String tag = 'funny';
  String rating = 'pg';
  bool isLoading = true;

  Future<void> fetchGif() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        'https://api.giphy.com/v1/gifs/random?api_key=$api_key&tag=$tag&rating=$rating');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          gifUrl = data['data']['images']['original']['url'];
        });
      } else {
        throw Exception('Failed to load GIF');
      }
    } catch (error) {
      print('Error: $error');
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGif();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.lightGreen,
                ))
              : ClipOval(
                  child: Image.network(
                    gifUrl,
                    width: 250.0,
                    height: 250.0,
                    fit: BoxFit.cover,
                  ),
                ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () {
                fetchGif();
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreen,
                ),
                child: const Center(
                  child: Text(
                    'New GIF',
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontSize: 25,
                      color: Color.fromARGB(255, 239, 204, 4),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
