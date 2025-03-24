import 'package:flutter/material.dart';
import 'dart:math';

class SwainraWaveyScrollList extends StatefulWidget {
  final List<Widget> children;
  final double waveAmplitude;
  final double waveFrequency;
  final double itemHeight;

  const SwainraWaveyScrollList({
    super.key,
    required this.children,
    this.waveAmplitude = 20.0,
    this.waveFrequency = 200.0,
    this.itemHeight = 100.0,
  });

  @override
  State<SwainraWaveyScrollList> createState() => _SwainraWaveyScrollListState();
}

class _SwainraWaveyScrollListState extends State<SwainraWaveyScrollList> {
  final ScrollController _scrollController = ScrollController();
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _offset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.children.length,
      itemExtent: widget.itemHeight,
      itemBuilder: (context, index) {
        final dy = index * widget.itemHeight - _offset;
        final wave = widget.waveAmplitude * sin(dy / widget.waveFrequency);

        return Transform.translate(
          offset: Offset(wave, 0.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: widget.children[index],
          ),
        );
      },
    );
  }
}
