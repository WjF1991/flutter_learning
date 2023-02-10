import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class ListViewOfWords extends StatefulWidget{

  //路由命名名称
  static const String listViewOfWordsWidget = "list_view_words_widget";

  const ListViewOfWords({super.key, required this.onChanged, required this.controller});
  final ValueChanged<double> onChanged;
  final ScrollController controller;
  


  @override
  ListViewAndWordsState createState()  => ListViewAndWordsState(onChanged, controller);
}

class ListViewAndWordsState extends State<ListViewOfWords> {

  static const loadingTag = "##loading##";
  var words = <String>[loadingTag];
  double offset = 0;
  ScrollController controller = ScrollController();
  final ValueChanged<double> onChanged;

  ListViewAndWordsState(this.onChanged, this.controller);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      onChanged(controller.offset);
    });
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: .0),
        itemCount: words.length,
        shrinkWrap: true,
        controller: controller,
        itemBuilder: (context, index) {
          if(words[index] == loadingTag) {
            if(words.length - 1 < 100) {
              _retrieveData();
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0,),
                ),
              );
            } else {
              //已经加载了100条数据，不再获取数据。
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }
          //显示单词列表项
          return ListTile(title: Text(words[index]));
        },
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(milliseconds: 500)).then((e) {
      setState(() {
        //重新构建列表
        words.insertAll(
          words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
        );
      });
    });
  }

}
