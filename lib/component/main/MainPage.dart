import 'dart:ui';

import 'package:airoute/airoute.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
//import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sample/component/main/main_view_model.dart';
import 'package:flutter_app_sample/global_view_model.dart';
import 'package:provider/provider.dart';

import '../../common/helper/tip_helper.dart';
import '../../common/helper/tip_type.dart';

///主页面
///
/// 增加："演示主页"、"小游戏"、"TO DO的底部切换标签
/// 增加：点击底部已选中的标签会触发刷新机制
///
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

///
/// _MainState
class _MainState extends State<MainPage> {
  ///
  /// 底部导航标签的图标集合
  List<Widget> _bottomNavigationIcons = [
    Icon(Icons.slideshow),
    Icon(Icons.games),
    Icon(Icons.title),
  ];

  ///
  /// 底部导航标签的标题文字集合
  List<String> _bottomNavigationTitles = [
    "演示主页",
    "小游戏",
    "TODO",
  ];

  ///
  /// 底部选中的导航标签索引项
  int _bottomNavigationSelectedIndex = 0;

  ///
  /// 获取示例列表的显示的描述
  List<String> _getSortTitles() {
    List<String> _sortTitles = [
      "Animation",
      "Communication",
      "Drag list grid...",
      "Tip message...",
      "Chart: bar line pie...",
      "Picker",
      "WebView",
      "3D Widget",
      "Curved Navigation Bar",
      "Clip",
      "Ink",
      "RichText",
      "Progress",
      "Segment",
      "DropDown",
      "Popup",
      "Wave",
      "IconAnim",
      "Overlay",
      "Loading",
    ];
    return _sortTitles;
  }

  ///
  /// 获取示例列表的跳转的路由名字集合
  List<String> _getSortRouteNames() {
    List<String> _sortRouteNames = [
      "/MainAnimSortPage",
      "/CardMainPage",
      "/DragListPage",
      "/FlushBarPage",
      "/ChartPage",
      "/MainPickerPage",
      "/FlutterWebPage",
      "/ListWheelScrollViewPage",
      "/CurvedNavigationBarPage",
      "/ClipMainPage",
      "/InkPage",
      "/RichTextPage",
      "/MainProgressPage",
      "/SegmentPage",
      "/DropDownPage",
      "/MainPopupPage",
      "/MainWavePage",
      "/MainIconAnimPage",
      "/MainOverlayPage",
      "/MainLoadingPage",
    ];
    return _sortRouteNames;
  }

  ///
  /// 是否：开启右侧侧滑
  bool _drawerOpenedRight = false;

  ///
  /// 获取底部导航标签的对应的显示视图
  List<Widget> getBottomNavigationWidgets() {
    List<Widget> _bottomNavigationWidgets = [
      _getListView(),
//      Center(
//        child: SizedBox(
//          height: 64.0,
//          child: FlipClock.simple(
//            startTime: DateTime.now(),
//            digitColor: Colors.white,
//            backgroundColor: Colors.black,
//            digitSize: 48.0,
//            borderRadius: const BorderRadius.all(Radius.circular(3.0)),
//          ),
//        ),
//      ),
      Center(
        child: Text("TODO"),
      ),
    ];

    return _bottomNavigationWidgets;
  }

  _setState(bool value) {
    _drawerOpenedRight = value;
    MainViewModel.getInstance().notify();
  }

  ///
  ///获取列表
  ListView _getListView() {
    List<String> sortTitles = _getSortTitles();

    ListView listView = ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Airoute.pushNamedWithAnimation(
              routeName: _getSortRouteNames().elementAt(index),
              routePageAnimation: AirouteTransition.Slide,
            );
          },
          child: Card(
            color: Colors.lightGreen,
            elevation: 3.0,
            margin: EdgeInsets.all(5),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  "${sortTitles.elementAt(index).substring(0, 1)}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                "${sortTitles.elementAt(index)}",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
      itemCount: sortTitles.length,
    );

    return listView;
  }

  ///
  /// 底部导航的点击事件处理
  _bottomNavigationTap(int index) {
    /*
    Render
     */
    setState(() {
      /*
      如果已经选中当前项，此时再选择此项则视为刷新当前页面
       */
      if (_bottomNavigationSelectedIndex == index) {
        TipHelper.showTip(
          context: context,
          tipType: TipType.INFO,
          message:
              "${_bottomNavigationTitles.elementAt(_bottomNavigationSelectedIndex)}触发刷新机制",
        );
      }
      _bottomNavigationSelectedIndex = index;
    });
  }

  ///
  /// 获取底部导航项集合
  List<TabItem> _getBottomNavigationBar() {
    List<TabItem> items = [];

    for (int i = 0; i < getBottomNavigationWidgets().length; i++) {
      items.add(
        TabItem(
          icon: _bottomNavigationIcons.elementAt(i),
          title: "${_bottomNavigationTitles.elementAt(i)}",
        ),
      );
    }

    return items;
  }

  Drawer _getDrawer({bool leftDraw = true}) {
    return Drawer(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Airoute.pushNamed(routeName: "/UserInfoPage");
              },
              child: Container(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/avatar.jpg",
                        fit: BoxFit.cover,
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5,
                          sigmaY: 5,
                        ),
                        child: Container(
                          width: 1,
                          height: 1,
                          color: Colors.black.withOpacity(0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 100,
                        height: 100,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/avatar.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              child: Text(
                                "Air",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.blue,
              ),
              title: Text("个人中心"),
              onTap: () {
                Airoute.pushNamed(routeName: "/UserInfoPage");
              },
              trailing: Icon(Icons.arrow_right),
            ),
//            Divider(),
//            ListTile(
//              leading: Icon(
//                Icons.more_horiz,
//                color: Colors.blue,
//              ),
//              title: Text("更多功能"),
//              subtitle: Text(
//                "紧急上线中...",
//              ),
//              onTap: () {
//                TipHelper.showTip(
//                    context: context,
//                    tipType: TipType.WARN,
//                    message: "紧急上线中...");
//              },
//              trailing: Icon(Icons.arrow_right),
//            ),
            Divider(),
            ExpansionTile(
              title: Text("小标签"),
              children: <Widget>[
                Wrap(
                  spacing: 10,
                  children: <Widget>[
                    Chip(
                      avatar: ClipOval(
                        child: Image.asset("assets/avatar.jpg"),
                      ),
                      label: Text("Air"),
                    ),
                    Chip(
                      avatar: ClipOval(
                        child: Image.asset("assets/avatar.jpg"),
                      ),
                      label: Text("男"),
                    ),
                    Chip(
                      avatar: Icon(
                        Icons.date_range,
                        color: Colors.green[300],
                      ),
                      label: Text("2020"),
                    ),
                    Chip(
                      avatar: Icon(
                        Icons.face,
                        color: Colors.blue[300],
                      ),
                      label: Container(
                        width: 25,
                        height: 25,
                        child: ClipOval(
                          child: Image.asset("assets/avatar.jpg"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text("小工具"),
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    IgnorePointer(
                      ignoring: (!leftDraw && _drawerOpenedRight),
                      child: (!leftDraw && _drawerOpenedRight)
                          ? ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.grey, BlendMode.srcIn),
                              child: ListTile(
                                onTap: () {
                                  _setState(!_drawerOpenedRight);
                                },
                                leading: Text("开启右侧侧滑"),
                                trailing: Switch(
                                  value: _drawerOpenedRight,
                                  onChanged: (bool value) {
                                    _setState(value);
                                  },
                                ),
                              ),
                            )
                          : ListTile(
                              onTap: () {
                                _setState(!_drawerOpenedRight);
                              },
                              leading: Text("开启右侧侧滑"),
                              trailing: Switch(
                                value: _drawerOpenedRight,
                                onChanged: (bool value) {
                                  _setState(value);
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text("样式"),
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        setState(() {
                          GlobalViewModel.getInstance().toggleDarkThemeMode();
                        });
                      },
                      leading: Text("Dark"),
                      title: Text("Dark"),
                      subtitle: Text("暗色模式"),
                      trailing: Switch(
                        value: GlobalViewModel.getInstance().isDarkTheme,
                        onChanged: (bool value) {
                          setState(() {
                            GlobalViewModel.getInstance().toggleDarkThemeMode();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          GlobalViewModel.getInstance().toggleLightThemeMode();
                        });
                      },
                      leading: Text("Light"),
                      title: Text("Light"),
                      subtitle: Text("浅色模式"),
                      trailing: Switch(
                        value: GlobalViewModel.getInstance().isLightTheme,
                        onChanged: (bool value) {
                          setState(() {
                            GlobalViewModel.getInstance()
                                .toggleLightThemeMode();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          GlobalViewModel.getInstance().toggleSystemThemeMode();
                        });
                      },
                      leading: Text("System"),
                      title: Text("System"),
                      subtitle: Text("跟随系统"),
                      trailing: Switch(
                        value: GlobalViewModel.getInstance().isSystemTheme,
                        onChanged: (bool value) {
                          setState(() {
                            GlobalViewModel.getInstance()
                                .toggleSystemThemeMode();
                          });
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            ExpansionTile(
              title: Text("敏感项"),
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    ListTile(
                        onTap: () {
                          setState(() {
                            TipHelper.showTip(
                                context: null, message: "努力开发中...");
                          });
                        },
                        title: Text("常亮"),
                        trailing: IgnorePointer(
                          ignoring: true,
                          child: Switch(
                            value: false,
                            onChanged: (bool value) {
                              setState(() {});
                            },
                          ),
                        )),
                    ListTile(
                      onTap: () {
                        Airoute.pushNamed(
                          routeName: "/AirLicensePage",
                        );
                      },
                      leading: Text("版权/证书"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      onTap: () {
                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text("退出登陆"),
                                content: Text("确定退出登陆"),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Airoute.pop();
                                    },
                                    child: Text("取消"),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Airoute.pushNamedAndRemoveUntil(
                                          newRouteName: "/LoginPage");
                                    },
                                    child: Text("确定"),
                                  ),
                                ],
                              );
                            });
                      },
                      leading: Text("退出登陆"),
                      trailing: Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => MainViewModel.getInstance()),
      ],
      child: Consumer<MainViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "${_bottomNavigationTitles.elementAt(_bottomNavigationSelectedIndex)}"),
            ),
            drawer: _getDrawer(leftDraw: true),
            endDrawer: _drawerOpenedRight ? _getDrawer(leftDraw: false) : null,
            body: Center(
              child: getBottomNavigationWidgets()
                  .elementAt(_bottomNavigationSelectedIndex),
            ),
            bottomNavigationBar: ConvexAppBar(
//              showSelectedLabels: true,
//              showUnselectedLabels: true,
              elevation: 5.0,
              style: TabStyle.reactCircle,
              initialActiveIndex: _bottomNavigationSelectedIndex,
              items: _getBottomNavigationBar(),
              onTap: _bottomNavigationTap,
            ),
          );
        },
      ),
    );
  }
}
