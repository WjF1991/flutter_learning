import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'english_words.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: (RouteSettings rs){
        String? routeName = rs.name;
        if(routeName == "MyHomePage") {
            return MaterialPageRoute(builder: (context) {
                  return const MyHomePage(title: '新的开始界面');
                }
            );
        }
        return null;
      },
      //定义路由
      routes: {
        "new_page": (context) => NewPage(content: context),
        "tip_route": (context) => const TipRoute(text: "路由配置页传递的参数"),
        "echo_page": (context) => const EchoPage(),
        EnglishWords.englishWordWidget: (context) => const EnglishWords(),
        "tip_page": (context){
          return TipPage(text: ModalRoute.of(context)!.settings.arguments as String);
        },
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'You have pushed the button this many times:',
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
                      context, "tip_route"
                  );
                },
                child: const Text("打开提示页2")
            ),
            ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(
                      context, "echo_page",
                      arguments: "hi"
                  );
                },
                child: const Text("EchoPage按钮"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, "tip_page",
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
              child: const Text("TipPage按钮"),
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
