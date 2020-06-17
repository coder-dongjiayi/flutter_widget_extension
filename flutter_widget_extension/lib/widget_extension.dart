/*
 * Created by 董家祎 on 2020/6/17.
 * email: smile.own@qq.com
 */
import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Padding padding({Key key, EdgeInsets insets}) {
    return Padding(
      key: key,
      padding: insets,
      child: this,
    );
  }

  Container margin({Key key, EdgeInsets insets}) {
    return Container(
      key: key,
      margin: insets,
      child: this,
    );
  }

  AspectRatio aspectRatio({Key key, double aspectRatio}) {
    return AspectRatio(key: key, child: this, aspectRatio: aspectRatio);
  }

  Expanded expanded({Key key, int flex = 1}) {
    return Expanded(key: key, flex: flex, child: this);
  }

  Container container(
      {Key key,
      Alignment alignment: Alignment.center,
      EdgeInsets padding: const EdgeInsets.all(0),
      Decoration decoration,
      num width,
      num height,
      Color color,
      BoxConstraints constraints,
      EdgeInsets margin: const EdgeInsets.all(0),
      Matrix4 transform}) {
    return Container(
      key: key,
      color: color,
      alignment: alignment,
      decoration: decoration,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      transform: transform,
      child: this,
    );
  }

  /// 用于添加边和圆角 一般情况下 边框颜色和圆角都是同时设置
  /// 1. 不要圆角可以 不给 borderRadius的值
  /// 2. 不要边框可以不给 width 或者  color
  Widget border(
      {Key key,
      Color color = null,
      double width = 0,
      BorderRadius borderRadius = null}) {
    /// 直接返回圆角
    if ((color == null || width == 0) && borderRadius != null) {
      return circular(key: key, borderRadius: borderRadius);
    }

    if (color != null) {
      return Container(
        key: key,
        child: this,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: color, width: width)),
      );
    }
  }

  ClipRRect circular({Key key, BorderRadius borderRadius}) {
    return ClipRRect(
      key: key,
      borderRadius: borderRadius,
      child: this,
    );
  }

  ClipRRect circularAll({Key key, double radius}) {
    return circular(
        key: key, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
