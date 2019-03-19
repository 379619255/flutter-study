import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/index/NavigationIconView.dart';
import 'package:flutter_ui_demo/index/home/HomePage.dart';
import 'package:flutter_ui_demo/global_config.dart';
import 'package:flutter_ui_demo/index/my/MyPage.dart';

//有状态的widget
class Index extends StatefulWidget {
  @override
  _IndexState createState() => new _IndexState();
}

//TickerProviderStateMixin提供桩体
class _IndexState extends State<Index> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<StatefulWidget> _pageList;
  StatefulWidget _currentPage;

  ///初始化
  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
          icon: new Icon(Icons.assignment), title: new Text("首页"), vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.all_inclusive),
          title: new Text("想法"),
          vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.add_shopping_cart),
          title: new Text("市场"),
          vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.add_alert), title: new Text("通知"), vsync: this),
      new NavigationIconView(
          icon: new Icon(Icons.perm_identity),
          title: new Text("我的"),
          vsync: this)
    ];

    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild); //增加监听
    }
    _pageList = <StatefulWidget>[
      new HomePage(),
      new HomePage(),
      new HomePage(),
      new HomePage(),
      new MyPage()
    ];
    _currentPage = _pageList[_currentIndex];
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose(); //移除
    }
  }
  ///先执行initState-->build
  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationIconView) =>
              navigationIconView.item)
          .toList(),
      currentIndex: _currentIndex,
      fixedColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
          _currentPage = _pageList[_currentIndex];
        });
      },
    );
    // TODO: implement build
    return MaterialApp(
        home: new Scaffold(//Scaffold 实现了基本的 Material 布局。只要是在 Material 中定义了的单个界面显示的布局控件元素，都可以使用 Scaffold 来绘制
          body: new Center(
            child: _currentPage,
          ),
          bottomNavigationBar: bottomNavigationBar,
        ),
        theme: GlobalConfig.themeData);
  }
}
