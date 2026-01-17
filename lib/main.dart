import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String message = '';

  Future<void> createProduct() async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/products/');

    final Map<String, dynamic> productData = {
      "title": "My New Product",
      "price": 500,
      "description": "This is a test product",
      "categoryId": 1,
      "images": ["https://placehold.co/600x400"]
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(productData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setState(() {
          message = "Product Created! ID:${data['id']}";
        });
      } else {
        setState(() {
          message = 'Failed to create product. Status:${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        message = "Error:$e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HTTP Post"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    createProduct();
                  },
                  child: Text('Create Product')),
              SizedBox(
                height: 22,
              ),
              Text(message),
            ],
          ),
        ));
  }
}
