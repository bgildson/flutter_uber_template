import 'package:flutter/material.dart';

/// definition of how the [Fragment] have to behave
class Fragment {
  final Duration duration;
  final Curve curve;
  final Widget Function(FragmentorState fragmentor) build;

  const Fragment({
    /// curve used in the fragment transition
    Curve curve,
    /// how much time the transition have to take
    Duration duration,
    /// factory used to create the widget of the fragment
    @required this.build,
  })
    : assert(build != null),
      this.duration = duration ?? const Duration(milliseconds: 150),
      this.curve = curve ?? Curves.ease;
}

/// widget used to group and handle the fragments
class Fragmentor extends StatefulWidget {
  final String initialFragment;
  final Map<String, Fragment> fragments;

  Fragmentor({
    Key key,
    this.initialFragment: '/',
    this.fragments,
  }) : assert(initialFragment != null, 'initialFragment can\'t be null!'),
       assert(fragments.keys.contains(initialFragment), 'initialFragment was not defined in fragments!'),
       super(key: key);

  FragmentorState createState() => FragmentorState();
}

class FragmentorState extends State<Fragmentor> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation get animation => _animationController.view;

  List<String> _history = [];

  String get current => _history.isEmpty
    ? widget.initialFragment
    : _history.last;

  Widget get fragment => _history.length > 0
    ? widget.fragments[current].build(this)
    : Container();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      value: 0,
    )..addListener(() => setState(() {}));

    navigateTo(widget.initialFragment);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  _navigateTo(String fragment) {
    var _leave;
    if (fragment == null) {
      if (this.current == widget.initialFragment)
        throw Exception(
          'Impossible navigate back, because the current fragment is the initial'
        );

      _leave = (_) => setState(() => _history.removeLast());
      fragment = _history[_history.length - 2];
    } else {
      if (!widget.fragments.keys.contains(fragment))
        throw Exception('Fragment \'$fragment\' doesn\'t exists!');

      _leave = (_) => setState(() => _history.add(fragment));
    }

    final Fragment current = widget.fragments[this.current];
    final Fragment next = widget.fragments[fragment];

    // hide old fragment and show the new
    _animationController
      .animateTo(0, curve: current.curve, duration: current.duration)
      .then(_leave)
      .then((_) =>
        _animationController
          .animateTo(1, curve: next.curve, duration: next.duration)
      );
  }

  /// navigate to another fragment
  void navigateTo(String fragment) => _navigateTo(fragment);

  /// navigate to previous fragment
  void navigateBack()  => _navigateTo(null);

  @override
  Widget build(BuildContext context) =>
    WillPopScope(
      onWillPop: () {
        // when is in the initialFragment pass the behavior for the router
        if (current == widget.initialFragment)
          return Future.value(true);

        navigateBack();

        // escape close app
        return Future.value(false);
      },
      child: fragment,
    );
}
