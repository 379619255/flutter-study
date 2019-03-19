import 'package:flutter/material.dart';

class NavigationIconView {
  /**
   * static
      类似java中的staitc，表示一个成员属于类而不是对象
      final
      类似java中的final，必须初始化，初始化后值不可变，编译时不能确定值。
      const
      编译时可确定，并且不能被修改
   */
  final BottomNavigationBarItem item;
  final AnimationController controller;

  NavigationIconView({Widget icon, Widget title, TickerProvider vsync})
      : item = new BottomNavigationBarItem(
          icon: icon,
          title: title,
        ),

        ///当创建一个AnimationController时，需要传递一个vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
        controller = new AnimationController(
            duration: kThemeAnimationDuration, vsync: vsync);
}
