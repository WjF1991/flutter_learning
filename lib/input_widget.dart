import 'package:flutter/material.dart';
import 'package:sramoon/my_home_page.dart';


/// 随机英文字母
class InputPageWidget extends StatelessWidget {

  //路由命名名称
  static const String inputPageWidget = "input_page_widget";

  const InputPageWidget({super.key});

  void login(BuildContext context, String uid, String pwd){
    if(uid.isNotEmpty && pwd.isNotEmpty){
      Navigator.pushNamed(
        context,
        MyHomePage.myHomePageWidget,
        arguments: uid
      );
    } else {
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text("提示"),
          content: const Text("用户名密码不能为空"),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("确定")
            )
          ],
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    TextEditingController tecUid = TextEditingController();
    TextEditingController tecPwd = TextEditingController();

    //获取使用路由命名传递过来的参数
    //Object? args = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("InputPageWidget"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: tecUid,
                  decoration: const InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入用户名",
                    prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (value) {
                    tecUid.text = value;
                  },
                ),
                TextField(
                  controller: tecPwd,
                  decoration: const InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    tecPwd.text = value;
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async => login(context, tecUid.text, tecPwd.text),
              child: const Text("登录"),
            ),
          ],
        ),
      ),
    );
  }

}