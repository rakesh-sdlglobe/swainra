import 'package:flutter/material.dart';

class SwainraTypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration speed;

  const SwainraTypewriterText({
    super.key,
    required this.text,
    this.style,
    this.speed = const Duration(milliseconds: 100),
  });

  @override
  State<SwainraTypewriterText> createState() => _SwainraTypewriterTextState();
}

class _SwainraTypewriterTextState extends State<SwainraTypewriterText> {
  String _displayedText = '';
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    Future.doWhile(() async {
      await Future.delayed(widget.speed);
      if (_index < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_index];
          _index++;
        });
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayedText, style: widget.style);
  }
}
