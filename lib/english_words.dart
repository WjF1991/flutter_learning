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



class PicAndSwitchState extends State<EnglishWords>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  bool isSwitchSelected = false;
  bool isCheckboxChecked = false;

  @override
  void initState() {
    //动画执行时间3秒
    _animationController = AnimationController(
      vsync: this, //注意State类需要混入SingleTickerProviderStateMixin（提供动画帧计时/触发器）
      duration: const Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var take = nouns.take(5);
    String rWords = WordPair.random().asCamelCase;
    String args = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(args),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton( //悬浮按钮
          onPressed:_onAdd, //悬浮按钮
          child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: () {  },),
            const SizedBox(), //中间位置空出
            IconButton(icon: const Icon(Icons.business), onPressed: () {  },),
          ], //均分底部导航栏横向空间
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Text(
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
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.fingerprint, color: Colors.green),
                  Icon(Icons.error, color: Colors.red),
                  Icon(Icons.accessible, color: Colors.green),
                ],
              ),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 28,top: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const LinearProgressIndicator(
                    backgroundColor: Colors.lightGreen,
                    valueColor: AlwaysStoppedAnimation(Colors.orange),
                    minHeight: 15,
                  ),
                  LinearProgressIndicator(
                    backgroundColor: Colors.lightGreen[200],
                    valueColor: ColorTween(
                        begin: Colors.grey, end: Colors.lightGreen[800]
                    ).animate(_animationController),
                    minHeight: 20,
                    value: _animationController.value,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28,top: 28),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  <Widget>[
                      const CircularProgressIndicator(
                        backgroundColor: Colors.lightGreen,
                        valueColor: AlwaysStoppedAnimation(Colors.orange),
                        strokeWidth: 15,
                      ),
                      CircularProgressIndicator(
                        backgroundColor: Colors.lightGreen[200],
                        valueColor: ColorTween(
                            begin: Colors.grey, end: Colors.lightGreen[800]
                        ).animate(_animationController),
                        strokeWidth: 20,
                        value: _animationController.value,
                      ),
                    ],
                  ),
            ),
            /*const Image(
              image: AssetImage("images/come_on.jpg"),
            ),*/
            Image.asset("images/come_on.jpg",height: 100,
              width: 100),
            //网络图片加载
            /*Image.network(
              "https://img2.baidu.com/it/u=3753183140,3501954541&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
              height: 100,
              width: 100,
            )*/
          ],
        ),
      ),
    );
  }


  void _onAdd() {
  }
}
