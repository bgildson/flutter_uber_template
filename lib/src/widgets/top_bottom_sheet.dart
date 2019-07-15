import 'package:flutter/material.dart';

class TopBottomSheet extends StatefulWidget {
  final Widget topChild;
  final Widget bottomChild;
  final double bottomHeightWhenClosed;

  TopBottomSheet({
    Key key,
    this.topChild,
    this.bottomChild,
    this.bottomHeightWhenClosed: 100,
  }) : super(key: key);

  _TopBottomSheetState createState() => _TopBottomSheetState();
}

class _TopBottomSheetState extends State<TopBottomSheet> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  AnimationController _animationController;

  double _areaToMove = 0;
  bool _opened = false;
  double _moved = 0;

  /// bottom sheet is opened
  bool get opened => _opened;
  double get moved => _moved;
  /// indicate the progress in open/close bottom sheet
  double get progress => _moved / _areaToMove;

  void _moveTo(double value) {
    // certify that the movement will be in the right range
    _moved = value.clamp(0.0, _areaToMove);
    // refresh animation progress
    _animationController.value = progress;
  }

  void _setOpened() {
    _opened = true;
    _moveTo(_areaToMove);
  }

  void _setClosed() {
    _opened = false;
    _moveTo(0);
  }

  /// open the bottom sheet
  TickerFuture open() {
    _setOpened();
    return _animationController.animateTo(progress);
  }

  /// close the bottom sheet
  TickerFuture close() {
    _setClosed();
    return _animationController.animateTo(progress);
  }

  /// invert bottom sheet opened state
  TickerFuture toggle() {
    if (_opened)
      return close();
    return open();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            _setOpened();
          } else if (status == AnimationStatus.dismissed) {
            _setClosed();
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 200),
              curve: Curves.ease
            );
          }
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    Column(
      verticalDirection: VerticalDirection.up,
      children: <Widget>[
        // bottom
        Expanded(
          child: LayoutBuilder(
            builder: (_, constraints) {
              // area that will occur the transition
              _areaToMove = constraints.maxHeight - widget.bottomHeightWhenClosed;
              // area that will occur the transition in 0 <-> 1 relation
              final double areaToMovePosY = _areaToMove / constraints.maxHeight;
              final Animation<Offset> position = Tween<Offset>(
                begin: Offset(0, areaToMovePosY),
                end: Offset(0, 0),
              ).animate(_animationController);

              final Animation<double> bottomWidth = Tween<double>(
                begin: MediaQuery.of(context).size.width - 30,
                end: MediaQuery.of(context).size.width,
              ).animate(_animationController);

              return SlideTransition(
                position: position,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.black26, blurRadius: 4)
                    ],
                  ),
                  width: bottomWidth.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3),
                      topRight: Radius.circular(3),
                    ),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: ConditionalScrollPhysics(
                        scrollCondition: _scrollCondition,
                        finalVelocity: _finalVelocity
                      ),
                      child: widget.bottomChild,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // top
        Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black26, blurRadius: 4)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(3),
            ),
            child: widget.topChild,
          ),
        )
      ],
    );

  bool _scrollCondition(ScrollPositionWithSingleContext position, double value) {
    if (_animationController.value != 1 || (_opened && position.pixels == 0 && value > 0)) {
      // inverted direction, because de source have inverse direction
      _moveTo(_moved - value);
      // indicate to keep the internal scroll in the right place
      return false;
    }
    return true;
  }

  void _finalVelocity(double velocity) {
    if (velocity > 500) {
      _animationController.forward();
    } else if (velocity < -500) {
      _animationController.reverse();
    } else if (progress > 0.8) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}

class ConditionalScrollPhysics extends ScrollPhysics {
  final bool Function(ScrollPositionWithSingleContext position, double value) scrollCondition;
  final void Function(double velocity) finalVelocity;

  const ConditionalScrollPhysics({
    ScrollPhysics parent,
    @required this.scrollCondition,
    @required this.finalVelocity
  }) : super(parent: parent);

  @override
  ConditionalScrollPhysics applyTo(ScrollPhysics ancestor) =>
    ConditionalScrollPhysics(
      parent: buildParent(ancestor),
      scrollCondition: scrollCondition,
      finalVelocity: finalVelocity
    );

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (!scrollCondition(position, offset))
      return 0;
    if (parent == null)
      return offset;
    return parent.applyPhysicsToUserOffset(position, offset);
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) => true;

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    this.finalVelocity(velocity);
    return null;
  }
}
