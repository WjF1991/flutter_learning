import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'list_view_of_words.dart';


class ListViewPage extends StatefulWidget{

  //路由命名名称
  static const String listViewPageWidget = "list_view_page";



  const ListViewPage({super.key});



  @override
  ListViewPageState createState() => ListViewPageState();


}

class ListViewPageState extends State<ListViewPage>{
  final ScrollController _controller = ScrollController();
  bool showToTopBtn = false;//是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();

  }

  void _setScrollOffset(double offset){
    if (offset < 1000 && showToTopBtn) {
      setState(() {
        showToTopBtn = false;
      });
    } else if (offset >= 1000 && showToTopBtn == false) {
      setState(() {
        showToTopBtn = true;
      });
    }
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("ListViewPage"),
      ),
      body: Scrollbar(
        child: Column(
          children: <Widget>[
            const ListTile(
              title:Text("名词组合列表"),

            ),
            Expanded(
              child: ListViewOfWords(
                onChanged: _setScrollOffset,
                controller: _controller,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
          child: const Icon(Icons.arrow_upward),
          onPressed: () {
            //返回到顶部时执行动画
            _controller.animateTo(
              .0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
            );
          }
      ),
    );

  }

}