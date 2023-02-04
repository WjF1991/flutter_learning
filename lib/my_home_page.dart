import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'english_words.dart';
import 'my_drawer.dart';

class MyHomePage extends StatefulWidget {

  //路由命名名称
  static const String myHomePageWidget = "my_home_page";

  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class NewPage extends StatelessWidget {

  //路由命名名称
  static const String newPageWidget = "new_page";

  const NewPage({super.key, required this.content});
  final BuildContext content;

  @override
  Widget build(BuildContext context) {

    Type c = content.runtimeType;

    return Scaffold(
      appBar: AppBar(
        title: const Text("新路由界面"),
      ),
      body: Center(
        child: Text(c.toString()),
      ),
    );

  }
}

class TipRoute extends StatelessWidget {

  //路由命名名称
  static const String tipRouteWidget = "tip_route";

  const TipRoute({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("提示"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(text),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, "我是返回值-TipRoute"),
                  child: const Text("返回"))
            ],
          ),
        ),
      ),
    );

  }
}

class EchoPage extends StatelessWidget{

  //路由命名名称
  static const String echoPageWidget = "echo_page";

  const EchoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //获取使用路由命名传递过来的参数
    Object? args = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("EchoPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, "我是返回值-EchoPage"),
              child: Text(args.toString()),
            ),
          ],
        ),
      ),
    );
  }
}

class TipPage extends StatelessWidget{

  //路由命名名称
  static const String tipPageWidget = "tip_page";

  const TipPage({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("TipPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, "我是从TipPage返回的值"),
                child: const Text("上面是父页面传递过来的参数，点击按钮返回"))
          ],
        ),
      ),
    );

  }

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 1;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    String uid = ModalRoute.of(context)?.settings.arguments as String;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[ //导航栏右侧菜单
          IconButton(
              icon: const Icon(Icons.back_hand),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
        ],
      ),
      drawer: const MyDrawer(), //抽屉
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "欢迎你 $uid",
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(onPressed: (){
              //push方法返回的Future对象，包含着NewPage页面出栈时返回的数据
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return NewPage(content: context);
                  })
              );
            }, child: const Text("新路由：既跳转界面")),
            //带参数的页面跳转，TipRoute页面出栈时回传数据，并且在控制台打印回传值
            ElevatedButton(
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return const TipRoute(
                      text: "我是参数xxx-xxx",
                    );
                  }),
                );
                if (kDebugMode) {
                  print("路有返回值：$result");
                }
              },
              child: const Text("打开提示页"),
            ),
            ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(
                      context, TipRoute.tipRouteWidget
                  );
                },
                child: const Text("打开提示页2")
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context,
                    EchoPage.echoPageWidget,
                    arguments: "hi"
                );
              },
              child: const Text("EchoPage按钮"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context,
                    TipPage.tipPageWidget,
                    arguments: "tip_page's hi"
                );
              },
              child: const Text("TipPage按钮"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context,
                    EnglishWords.englishWordWidget,
                    arguments: "english_word_widget's hi"
                );
              },
              child: const Text("EnglishWords按钮"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
