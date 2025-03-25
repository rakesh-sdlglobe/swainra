import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

enum SwainraTextAnimation { fadeIn, slideUp, typewriter }

class SwainraRichTextAnimator extends StatefulWidget {
  final String htmlLikeText;
  final SwainraTextAnimation animation;
  final TextStyle baseStyle;
  final Duration duration;
  final Gradient gradient;

  const SwainraRichTextAnimator(
    this.htmlLikeText, {
    super.key,
    this.animation = SwainraTextAnimation.fadeIn,
    this.baseStyle = const TextStyle(fontSize: 18),
    this.duration = const Duration(milliseconds: 1000),
    this.gradient = const LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
  });

  @override
  State<SwainraRichTextAnimator> createState() =>
      _SwainraRichTextAnimatorState();
}

class _UrlHandler {
  static Future<void> openUrl(String url) async {
    try {
      final finalUrl = url.startsWith('http') ? url : 'https://$url';
      final uri = Uri.parse(finalUrl);

      if (!await launcher.launchUrl(
        uri,
        mode: launcher.LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      )) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Failed to launch URL: $e');
    }
  }
}

class _SwainraRichTextAnimatorState extends State<SwainraRichTextAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<InlineSpan> _spans;
  final List<String> _linkStack = [];

  @override
  void initState() {
    super.initState();
    _spans = _parseText(widget.htmlLikeText);
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  List<InlineSpan> _parseText(String text) {
    text = text.replaceAllMapped(
        RegExp(r'\*\*(.*?)\*\*'), (m) => '<b>${m[1]}</b>');
    text = text.replaceAllMapped(RegExp(r'\*(.*?)\*'), (m) => '<i>${m[1]}</i>');
    
    final RegExp tagRegex = RegExp(
      r"<(\/?)(b|i|u|g|s|link|c|size)(?: url='([^']+)'| color='(#[A-Fa-f0-9]{6})'|=(\d+))?>",
    );

    final List<InlineSpan> spans = [];
    final List<TextStyle> styleStack = [widget.baseStyle];
    final List<String?> linkStack = [];

    int lastIndex = 0;
    final matches = tagRegex.allMatches(text).toList();

    for (final match in matches) {
      final fullMatch = match.group(0)!;
      final isClosing = match.group(1) == '/';
      final tag = match.group(2)!;
      final linkUrl = match.group(3);
      final customColor = match.group(4);
      final customSize = match.group(5);

      if (match.start > lastIndex) {
        final segment = text.substring(lastIndex, match.start);
        final currentStyle = styleStack.last;
        final currentLink = linkStack.isNotEmpty ? linkStack.last : null;

        spans.add(TextSpan(
          text: segment,
          style: currentStyle,
          recognizer: currentLink != null
              ? (TapGestureRecognizer()
                ..onTap = () => _UrlHandler.openUrl(currentLink))
              : null,
        ));
      }

      if (!isClosing) {
        var newStyle = styleStack.last;

        switch (tag) {
          case 'b':
            newStyle =
                newStyle.merge(const TextStyle(fontWeight: FontWeight.bold));
            break;
          case 'i':
            newStyle =
                newStyle.merge(const TextStyle(fontStyle: FontStyle.italic));
            break;
          case 'u':
            newStyle = newStyle
                .merge(const TextStyle(decoration: TextDecoration.underline));
            break;
          case 's':
            newStyle = newStyle.merge(TextStyle(shadows: [
              Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 3,
                  offset: Offset(1, 1))
            ]));
            break;
          case 'g':
            newStyle = newStyle.merge(TextStyle(
              foreground: Paint()
                ..shader = widget.gradient.createShader(
                  const Rect.fromLTWH(0, 0, 200, 70),
                ),
            ));
            break;
          case var t when t.startsWith('link'):
            newStyle = newStyle.merge(const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ));
            linkStack.add(linkUrl);
            break;
          case var t when t.startsWith('c'):
            newStyle = newStyle.merge(TextStyle(
              color: Color(int.parse(customColor!.replaceFirst('#', '0xff'))),
            ));
            break;
          case var t when t.startsWith('size'):
            newStyle = newStyle.merge(TextStyle(
              fontSize: double.parse(customSize!),
            ));
            break;
        }

        styleStack.add(newStyle);
      } else {
        if (tag.startsWith('link') && linkStack.isNotEmpty) {
          linkStack.removeLast();
        }
        if (styleStack.length > 1) {
          styleStack.removeLast();
        }
      }

      lastIndex = match.end;
    }

    // Final remaining text
    if (lastIndex < text.length) {
      final segment = text.substring(lastIndex);
      final currentStyle = styleStack.last;
      final currentLink = linkStack.isNotEmpty ? linkStack.last : null;

      spans.add(TextSpan(
        text: segment,
        style: currentStyle,
        recognizer: currentLink != null
            ? (TapGestureRecognizer()
              ..onTap = () => _UrlHandler.openUrl(currentLink))
            : null,
      ));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        Widget richText = RichText(text: TextSpan(children: _spans));

        switch (widget.animation) {
          case SwainraTextAnimation.fadeIn:
            return Opacity(opacity: _animation.value, child: richText);
          case SwainraTextAnimation.slideUp:
            return Transform.translate(
              offset: Offset(0, 20 * (1 - _animation.value)),
              child: Opacity(opacity: _animation.value, child: richText),
            );
          case SwainraTextAnimation.typewriter:
            final count = (_spans.length * _animation.value).floor();
            return RichText(
              text: TextSpan(children: _spans.take(count).toList()),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
