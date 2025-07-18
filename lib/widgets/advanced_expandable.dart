import 'package:flutter/material.dart';

class AdvancedExpandable extends StatefulWidget {
  final Widget Function(bool isExpanded) headerBuilder;
  final Widget expandedContent;
  final Widget? collapsedContent;
  final bool initiallyExpanded;
  final Duration animationDuration;
  final Curve animationCurve;
  final EdgeInsetsGeometry contentPadding;

  const AdvancedExpandable({
    Key? key,
    required this.headerBuilder,
    required this.expandedContent,
    this.collapsedContent,
    this.initiallyExpanded = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.contentPadding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  _AdvancedExpandableState createState() => _AdvancedExpandableState();
}

class _AdvancedExpandableState extends State<AdvancedExpandable>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    );
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with toggle
        InkWell(
          onTap: _toggleExpanded,
          hoverColor: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: widget.headerBuilder(_isExpanded),
        ),
        
        // Optional collapsed content
        if (!_isExpanded && widget.collapsedContent != null)
          widget.collapsedContent!,
        
        // Animated expanded content
        SizeTransition(
          sizeFactor: _animation,
          child: Padding(
            padding: widget.contentPadding,
            child: widget.expandedContent,
          ),
        ),
      ],
    );
  }
}