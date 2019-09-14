import 'package:flutter/material.dart';

class RefreshButton extends StatefulWidget {
  RefreshButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  _RefreshButtonState createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
        }
      });
    _rotation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: RotationTransition(
        turns: _rotation,
        child: Icon(Icons.refresh),
      ),
      tooltip: 'Refresh',
      onPressed: widget.onPressed != null
          ? () => _handlePressed()
          : null,
    );
  }

  void _handlePressed() {
    _controller.forward();
    widget.onPressed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
