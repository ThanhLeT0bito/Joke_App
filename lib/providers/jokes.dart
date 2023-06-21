import 'package:flutter/material.dart';
import 'package:joke_app/providers/joke.dart';

class Jokes with ChangeNotifier {
  final List<Joke> ListJokes = [
    Joke(
        id: 'jk1',
        title: 'A Joke a day keeps the doctor away',
        sub_title: 'if you joke wrong way, your teeth have to pay. (Serious)',
        content:
            'A child asked his father, "How were people born?" So his father said, "Adam and Eve made babies, then their babies became adults anda made babies, and so on." The child then went to his mother, asked her the same question and she told him, "We were mon- keys then he evolved to become like we are now." The child ran back to his father and said, "You lied to me!" His father replied, "No, your mom was talking about her side of the family.'),
    Joke(
        id: 'jk2',
        title: 'A Joke a day keeps the doctor away',
        sub_title: 'if you joke wrong way, your teeth have to pay. (Serious)',
        content:
            'Teacher: "Kids,what does the chicken give you?" Student: "Meat!" Teacher: "Very good! Now what does the pig give you?" Student: "Bacon!" Teacher: "Great! And what does the fat cow give you?" Student: "Homework!"'),
    Joke(
      id: 'jk3',
      title: 'A Joke a day keeps the doctor away',
      sub_title: 'if you joke wrong way, your teeth have to pay. (Serious)',
      content:
          'The teacher asked Jimmy, "Why is your cat at school today Jimmy?" Jimmy replied crying, "Because I heard my daddy tell my mommy, I am going to eat that pussy once Jimmy leaves for school today!"',
    ),
    Joke(
        id: 'jk3',
        title: 'A Joke a day keeps the doctor away',
        sub_title: 'if you joke wrong way, your teeth have to pay. (Serious)',
        content:
            'A housewife, an accountant and a lawyer were asked "How much is 2+2?" The housewife replies: "Four!". The accountant says: "I think its either 3 or 4. Let me run those figures through my spreadsheet one more time." The lawyer pulls the drapes, dims the lights and asks in a hushed voice, "How much do you want it to be?"'),
  ];

  List<Joke> get listJokes {
    return [...ListJokes];
  }

  // void setVotingCookie() {
  //   CookieJar cookieJar = CookieJar();
  //   Dio dio = Dio();
  //   dio.interceptors.add(CookieManager(cookieJar));
  //   final cookie = Cookie('voted', 'true');
  //   cookie.path = '/';
  //   cookie.expires = DateTime.now().add(Duration(days: 7));
  //   cookieJar.saveFromResponse(Uri.parse('https://example.com'), [cookie]); // Lưu cookie vào CookieJar

  // }
}
