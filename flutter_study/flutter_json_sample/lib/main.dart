import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? resultCd;
  String? resultMsg;
  bool isData = true;

  //String url = "https://api.montessori.co.kr/api/addr_sido/";
  String url = "http://200.0.0.20:5003/test/";

  FetchJSON() async {
    var Response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
    );

    if (Response.statusCode == 200) {
      String responseBody = Response.body;
      var responseJSON = json.decode(responseBody);
      resultCd = responseJSON['resultCd'];
      resultMsg = responseJSON['resultMsg'];
      isData = false;

      print(Response.statusCode);
      print(responseJSON);

      setState(() {
        print('Data Load Success!');
      });
    } else {
      print('Data Load failed.\nResponse Code : ${Response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    FetchJSON();
  }

  Widget myui() {
    return ListView(
      children: [
        Image.network(
          'https://img.montessori.co.kr/logo_200.jpg',
          width: 100,
          height: 100,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
        Text(
          'resultCd : $resultCd',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
        Text(
          'resultMsg : $resultMsg',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('JSON Load 테스트'),
        ),
        body: Column(
          children: [
            Center(
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  FetchJSON();
                },
                child: const Text('ReLoad'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: isData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : myui(),
            ),
          ],
        ));
  }
}
