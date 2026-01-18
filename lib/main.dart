import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RequestClass(),
    );
  }
}

class RequestClass extends StatefulWidget {
  const RequestClass({super.key});

  @override
  State<RequestClass> createState() => _RequestClassState();
}

class _RequestClassState extends State<RequestClass> {
  final Dio dio = Dio();
  final url = 'https://api.escuelajs.co/api/v1/products/';
  String message = '';

  Future<void> postData() async {
    final Map<String, dynamic> productsData = {
      'title': 'Dipesh Product',
      'price': 700,
      'description': 'Dipesh New Product',
      'categoryId': 1,
      'images': ['https://placehold.co/600x400'],
    };

    try {
      final response = await dio.post(url, data: productsData);
      setState(() {
        message = 'Product created Successfully ID: ${response.data['id']}';
      });
    } on DioException catch (e) {
      message = 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio POST Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  postData();
                },
                child: Text('Create Product')),
                SizedBox(
                    height: 30,
                ),
                Text(message),
          ],
        ),
      ),
    );
  }
}
