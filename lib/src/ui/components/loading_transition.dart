import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';

class LoadingTransition extends ImplicitlyAnimatedWidget {
  LoadingTransition({
    @required this.contentChild,
    @required this.loadingChild,
    @required this.loading,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
    curve: Curves.easeInOut,
    duration: duration,
  );

  final Widget contentChild;
  final Widget loadingChild;
  final bool loading;
  final Duration duration;

  Widget get child => loading ? loadingChild : contentChild;

  @override
  _LoadingTransitionState createState() => _LoadingTransitionState();
}

class _LoadingTransitionState
    extends AnimatedWidgetBaseState<LoadingTransition> {
  LoadingTransitionOpacityTween opacityTween;
  LoadingTransitionChildTween childTween;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacityTween.evaluate(animation),
      child: childTween.evaluate(animation),
    );
  }

  @override
  void forEachTween(visitor) {
    opacityTween = visitor(opacityTween, 1.0,
            (opacity) => LoadingTransitionOpacityTween(begin: opacity));
    childTween = visitor(childTween, widget.child,
            (child) => LoadingTransitionChildTween(begin: child));
  }
}

@visibleForTesting
class LoadingTransitionOpacityTween extends Tween<double> {
  LoadingTransitionOpacityTween({double begin, double end})
      : super(begin: begin, end: end);

  double lerp(double t) {
    if (t < 0.5) {
      return lerpDouble(1.0, 0.0, t * 2);
    } else {
      return lerpDouble(0.0, 1.0, (t - 0.5) * 2);
    }
  }
}

@visibleForTesting
class LoadingTransitionChildTween extends Tween<Widget> {
  LoadingTransitionChildTween({Widget begin, Widget end})
      : super(begin: begin, end: end);

  Widget lerp(double t) {
    if (t < 0.5) {
      return begin;
    } else {
      return end;
    }
  }
}