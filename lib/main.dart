import 'package:flutter/material.dart';

import 'english_words.dart';
import 'input_widget.dart';
import 'my_home_page.dart';

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
        NewPage.newPageWidget: (context) => NewPage(content: context),
        TipRoute.tipRouteWidget: (context) => const TipRoute(text: "路由配置页传递的参数"),
        EchoPage.echoPageWidget: (context) => const EchoPage(),
        EnglishWords.englishWordWidget: (context) => const EnglishWords(),
        TipPage.tipPageWidget: (context){
          return TipPage(text: ModalRoute.of(context)!.settings.arguments as String);
        },
        MyHomePage.myHomePageWidget: (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        InputPageWidget.inputPageWidget: (context) => const InputPageWidget(),
      },
      home: const InputPageWidget(),

    );
  }
}