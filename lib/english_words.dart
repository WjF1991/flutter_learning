import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

/// 随机英文字母
class EnglishWords extends StatelessWidget {

  //路由命名名称
  static String englishWordWidget = "english_word_widget";

  const EnglishWords({super.key});

  @override
  Widget build(BuildContext context) {
    var take = nouns.take(5);
    String rWords = WordPair.random().asCamelCase;
    String args = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(args),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(take.join(",")),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        builder: (context) => Text(rWords), onClosing: () {  },
      ),
    );
  }
}
