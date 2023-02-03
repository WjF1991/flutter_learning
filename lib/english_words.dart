import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

/// 随机英文字母
class EnglishWords extends StatefulWidget {

  //路由命名名称
  static const String englishWordWidget = "english_word_widget";

  const EnglishWords({super.key});

  @override
  PicAndSwitchState createState() => PicAndSwitchState();

}



class PicAndSwitchState extends State<EnglishWords> {

  bool isSwitchSelected = false;
  bool isCheckboxChecked = false;

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
            Text(
                rWords,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    height: 1.2,
                    fontFamily: "Courier",
                    background: Paint()..color=Colors.orange,
                    decoration:TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.fingerprint, color: Colors.green),
                Icon(Icons.error, color: Colors.red),
                Icon(Icons.accessible, color: Colors.green),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                    value: isSwitchSelected,
                    onChanged: (value){
                      setState(() {
                        isSwitchSelected = !isSwitchSelected;
                      });
                    }
                ),
                Checkbox(
                  value: isCheckboxChecked,
                  activeColor: Colors.deepOrange,
                  onChanged: (bool? value) {
                    setState(() {
                      isCheckboxChecked = !isCheckboxChecked;
                    });
                  },
                )
              ],
            ),
            Text(take.join(",")),
            /*const Image(
              image: AssetImage("images/come_on.jpg"),
            ),*/
            //Image.asset("images/come_on.jpg"),
            //网络图片加载
            Image.network("https://img2.baidu.com/it/u=3753183140,3501954541&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500")
          ],
        ),
      ),
    );
  }

}
