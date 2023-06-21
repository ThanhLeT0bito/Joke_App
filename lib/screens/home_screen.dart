import 'package:flutter/material.dart';
import 'package:joke_app/providers/jokes.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cookie_jar/cookie_jar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexJokes = 0;

  CookieJar? cookieJar;

  List<String> cookies = [];

  @override
  void initState() {
    super.initState();
    cookieJar = CookieJar();
    clearSharedPreferences();
  }

  void setCookies(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      cookies.add(rawCookie.split(';')[0]);
    }
  }

  Future<void> voteForJoke() async {
    final url = Uri.parse(
        'http://buymuaphones.somee.com/vote?jokeId=123'); // Replace with your voting endpoint

    final response =
        await http.get(url, headers: {'cookie': cookies.join('; ')});

    setCookies(response);
  }

  bool hasVoted() {
    return cookies.any((cookie) => cookie.contains('voted=true'));
  }

  // lưu id joke vào SharedPreferences
  void saveToSharedPreferences(String idjoke, bool funny) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(idjoke, funny);
    print('Succes');
  }

  void checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool voted = prefs.getBool('jk1') ?? false;

    if (voted) {
      print('Giá trị "joke 1=true" đã được lưu trong SharedPreferences.');
    } else {
      print('Không tìm thấy giá trị "joke 1=true" trong SharedPreferences.');
    }
  }

  ///clear all in SharedPreferences
  void clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Jokes>(context);
    final listJokes = data.listJokes;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeXUYryynbElDuBKQlgFBRDpUWLDefKDo8Eg&usqp=CAU',
            fit: BoxFit.cover,
            height: 80,
          ),
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Handicrafted by",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Text(
                    'JimHLS',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              ClipOval(
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2018/09/02/18/39/sunflower-3649508_1280.jpg',
                  fit: BoxFit.cover,
                  height: 60,
                ),
              )
            ],
          )
        ]),
      ),
      body: listJokes.length > indexJokes
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.green,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listJokes[indexJokes].title,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(listJokes[indexJokes].sub_title,
                              style: const TextStyle(color: Colors.white))
                        ]),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      listJokes[indexJokes].content,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            saveToSharedPreferences(
                                listJokes[indexJokes].id, true);
                            setState(() {
                              ++indexJokes;
                            });
                            checkSharedPreferences();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  const BoxDecoration(color: Colors.blue),
                              child: const Text(
                                'This is Funny!',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ))),
                      const SizedBox(width: 20),
                      TextButton(
                          onPressed: () {
                            saveToSharedPreferences(
                                listJokes[indexJokes].id, false);
                            setState(() {
                              ++indexJokes;
                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  const BoxDecoration(color: Colors.green),
                              child: const Text(
                                'This is not funny.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )))
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'This appis created as part of Hlsolutions program. The materials con- tained on this website are provided for general information only and do not constitute any form of advice. HLS assumes no responsibility for the accuracy of any particular statement and accepts no liability for any loss or damage which may arise from reliance on the infor- mation contained on this site.',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Text(
                    "Copyright 2021 HLS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            )
          : const Center(
              child:
                  Text('Thats all the jokes for today! Come back another day!'),
            ),
    );
  }
}
