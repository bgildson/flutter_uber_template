import 'dart:ui' show lerpDouble;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CircleRouteTransition extends PageRouteBuilder {
  final Widget page;

  CircleRouteTransition({this.page})
    : super(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation
      ) => page,
      transitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child
      ) => ExpandCircleTransition(
        transition: animation,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: child,
      )
    );
}

class ExpandCircleTransition extends SingleChildRenderObjectWidget {
  final Animation<double> transition;
  final bool alwaysIncludeSemantics;
  final double height;
  final double width;

  const ExpandCircleTransition({
    Key key,
    @required this.transition,
    this.alwaysIncludeSemantics = false,
    @required this.height,
    @required this.width,
    Widget child,
  }) : assert(transition != null),
       super(key: key, child: child);

  @override
  RenderAnimatedExpandCircle createRenderObject(BuildContext context) {
    return RenderAnimatedExpandCircle(
      transition: transition,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      height: height,
      width: width,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderAnimatedExpandCircle renderObject) {
    renderObject
      ..transition = transition
      ..alwaysIncludeSemantics = alwaysIncludeSemantics;
  }
}

class RenderAnimatedExpandCircle extends RenderProxyBox {
  double _progress;
  double height;
  double width;

  bool get alwaysIncludeSemantics => _alwaysIncludeSemantics;
  bool _alwaysIncludeSemantics;
  set alwaysIncludeSemantics(bool value) {
    if (value == _alwaysIncludeSemantics)
      return;
    _alwaysIncludeSemantics = value;
    markNeedsSemanticsUpdate();
  }

  Animation<double> get transition => _transition;
  Animation<double> _transition;
  set transition(Animation<double> value) {
    assert(value != null);
    if (_transition == value)
      return;
    if (attached && _transition != null)
      _transition.removeListener(_updateTransition);
    _transition = value;
    if (attached)
      _transition.addListener(_updateTransition);
    _updateTransition();
  }

  RenderAnimatedExpandCircle({
    @required Animation<double> transition,
    bool alwaysIncludeSemantics = false,
    @required this.height,
    @required this.width,
    RenderBox child,
  }) : assert(transition != null),
       assert(alwaysIncludeSemantics != null),
       _alwaysIncludeSemantics = alwaysIncludeSemantics,
       super(child) {
    this.transition = transition;
  }

  @override
  bool get alwaysNeedsCompositing => child != null && _currentlyNeedsCompositing;
  bool _currentlyNeedsCompositing;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _transition.addListener(_updateTransition);
    _updateTransition();
  }

  @override
  void detach() {
    _transition.removeListener(_updateTransition);
    super.detach();
  }

  void _updateTransition() {
    final double oldProgress = _progress;
    _progress = _transition.value.clamp(0, 1);
    if (oldProgress != _progress) {
      final bool didNeedCompositing = _currentlyNeedsCompositing;
      _currentlyNeedsCompositing = _progress > 0 && _progress < 1;
      if (child != null && didNeedCompositing != _currentlyNeedsCompositing)
        markNeedsCompositingBitsUpdate();
      markNeedsPaint();
      if (oldProgress == 0 || _progress == 0)
        markNeedsSemanticsUpdate();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // calculate the maximum distance from left/top
    final double maxDistanceLeft = width / 2;
    final double maxDistanceTop = height / 2;

    // calculate the hipotenusa to transition
    final double hip = math.sqrt(math.pow(maxDistanceTop, 2) + math.pow(maxDistanceLeft, 2));

    // calculate the transition in hip to left/top
    final double _left = lerpDouble(maxDistanceLeft, maxDistanceLeft - hip, _progress);
    final double _top = lerpDouble(maxDistanceTop, maxDistanceTop - hip, _progress);

    // calculate the current size
    final double heightWidth = hip * 2 * _progress;

    // create current rect
    final Rect rect = Rect.fromLTWH(_left, _top, heightWidth, heightWidth);

    // apply rect with radius
    context.pushClipRRect(
      needsCompositing,
      offset,
      rect,
      RRect.fromRectAndRadius(rect, Radius.circular(heightWidth)),
      super.paint
    );
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (child != null && (_progress != 0 || false))
      visitor(child);
  }
}
