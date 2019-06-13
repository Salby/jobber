import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class LoadingTransition extends ImplicitlyAnimatedWidget {
  LoadingTransition({
    this.child,
  }) : super(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );

  final Widget child;

  @override
  _LoadingTransitionState createState() => _LoadingTransitionState();
}

class _LoadingTransitionState
    extends AnimatedWidgetBaseState<LoadingTransition> {
  LoadingTransitionOpacityTween _opacityTween;
  LoadingTransitionChildTween _childTween;

  @override
  Widget build(BuildContext context) {
      return Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: _childTween.evaluate(animation),
      );
  }

  @override
  void forEachTween(visitor) {
    visitor(_opacityTween, 1.0,
        (opacity) => LoadingTransitionOpacityTween(begin: opacity));
    visitor(_childTween, widget.child,
        (child) => LoadingTransitionChildTween(begin: child));
  }
}

@visibleForTesting
class LoadingTransitionOpacityTween extends Tween<double> {
  LoadingTransitionOpacityTween({
    double begin,
    double end,
  }) : super(begin: begin, end: end);

  double lerp(double t) {
    return t < 0.5
        ? lerpDouble(1.0, 0.0, t * 2)
        : lerpDouble(0.0, 1.0, (t - 0.5) * 2);
  }
}

@visibleForTesting
class LoadingTransitionChildTween extends Tween<Widget> {
  LoadingTransitionChildTween({
    Widget begin,
    Widget end,
  }) : super(begin: begin, end: end);

  Widget lerp(double t) {
    return t < 0.5 ? begin : end;
  }
}
