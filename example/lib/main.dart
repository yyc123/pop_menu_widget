import 'package:flutter/material.dart';
import 'package:pop_menu_widget/pop_menu_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "测试",
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  bool showMenu = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试顶部弹出'),
      ),
      body: PopMenuWidget(
        direction: Direction.top,
        child: _buildContentView(),
        show: showMenu,
        menu: _buildPopView(() {
          setState(() {
            showMenu = !showMenu;
          });
        }),
      ),
    );
  }

  Widget _buildContentView() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  showMenu = !showMenu;
                });
              },
              child: Text("点击弹出菜单"),
            ),
            FlatButton(
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (_) {
                  return SecondPage();
                });
                Navigator.push(context, route);
              },
              child: Text("进入下一页测试底部弹出"),
            ),
          ],
        ),
      ),
    );
  }
}

///弹出界面
Widget _buildPopView(callBack) {
  return Container(
      height: 300,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("仓单编号"),
              Expanded(
                child: TextField(),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("商品名称"),
              Expanded(
                child: TextField(),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("客户名称"),
              Expanded(
                child: TextField(),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("仓单编号"),
              Expanded(
                child: TextField(),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: 45,
              width: double.infinity,
              child: FlatButton(
                color: Colors.blue,
                child: Text(
                  "搜索",
                  style: TextStyle(color: Colors.white),
                ),
                shape: StadiumBorder(),
                onPressed: () {
                  callBack();
                },
              ),
            ),
          ),
        ],
      ));
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试底部弹出'),
      ),
      body: PopMenuWidget(
        direction: Direction.bottom,
        child: _buildContentView(),
        show: showMenu,
        menu: _buildPopView(() {
          setState(() {
            showMenu = !showMenu;
          });
        }),
      ),
    );
  }

  Widget _buildContentView() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  showMenu = !showMenu;
                });
              },
              child: Text("点击弹出菜单"),
            ),
          ],
        ),
      ),
    );
  }
}
