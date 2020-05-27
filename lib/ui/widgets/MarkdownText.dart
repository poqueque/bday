import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  const MarkdownText(this.text, {Key key, this.textAlign = TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextPart> partList = [TextPart(TextType.normal, text)];

    List<TextPart> processedList = partList
        .map((part) {
          List<TextPart> newParts = <TextPart>[];
          RegExp links = RegExp(r"\[(.*?)\]\((.*?)\)");
          print("allMatches : " + links.allMatches(part.text).join(" | "));
          var all = links.allMatches(part.text);
          var pointer = 0;
          for (RegExpMatch match in all) {
            if (match.start > pointer) {
              newParts.add(TextPart(
                  TextType.normal, part.text.substring(pointer, match.start)));
            }
            newParts.add(
                TextPart(TextType.link, match.group(1), other: match.group(2)));
            pointer = match.end;
          }
          if (pointer < part.text.length) {
            newParts
                .add(TextPart(TextType.normal, part.text.substring(pointer)));
          }
          return newParts;
        })
        .expand((element) => element)
        .toList();

    List<TextPart> processedList2 = processedList
        .map((part) {
          if (part.type == TextType.normal) {
            List<TextPart> newParts = <TextPart>[];
            RegExp links = RegExp(r"\*(.*?)\*");
            var all = links.allMatches(part.text);
            var pointer = 0;
            for (RegExpMatch match in all) {
              if (match.start > pointer) {
                newParts.add(TextPart(TextType.normal,
                    part.text.substring(pointer, match.start)));
              }
              newParts.add(TextPart(TextType.bold, match.group(1)));
              pointer = match.end;
            }
            if (pointer < part.text.length) {
              newParts
                  .add(TextPart(TextType.normal, part.text.substring(pointer)));
            }
            return newParts;
          } else {
            return [part];
          }
        })
        .expand((element) => element)
        .toList();

    List<TextPart> processedList3 = processedList2
        .map((part) {
          if (part.type == TextType.normal) {
            List<TextPart> newParts = <TextPart>[];
            RegExp links = RegExp(r"_(.*?)_");
            var all = links.allMatches(part.text);
            var pointer = 0;
            for (RegExpMatch match in all) {
              if (match.start > pointer) {
                newParts.add(TextPart(TextType.normal,
                    part.text.substring(pointer, match.start)));
              }
              newParts.add(TextPart(TextType.italic, match.group(1)));
              pointer = match.end;
            }
            if (pointer < part.text.length) {
              newParts
                  .add(TextPart(TextType.normal, part.text.substring(pointer)));
            }
            return newParts;
          } else {
            return [part];
          }
        })
        .expand((element) => element)
        .toList();

    List<TextPart> processedList4 = processedList3
        .map((part) {
          if (part.type == TextType.normal) {
            List<TextPart> newParts = <TextPart>[];
            RegExp links = RegExp(r"\+(.*?)\+");
            var all = links.allMatches(part.text);
            var pointer = 0;
            for (RegExpMatch match in all) {
              if (match.start > pointer) {
                newParts.add(TextPart(TextType.normal,
                    part.text.substring(pointer, match.start)));
              }
              newParts.add(TextPart(TextType.underlined, match.group(1)));
              pointer = match.end;
            }
            if (pointer < part.text.length) {
              newParts
                  .add(TextPart(TextType.normal, part.text.substring(pointer)));
            }
            return newParts;
          } else {
            return [part];
          }
        })
        .expand((element) => element)
        .toList();

    return RichText(
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
      text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: processedList4.map((e) => e.toSpan()).toList()),
    );
  }
}

enum TextType { link, bold, italic, underlined, normal }

class TextPart {
  final String text;
  final String other;
  final TextType type;

  TextPart(this.type, this.text, {this.other});

  TextSpan toSpan() {
    switch (type) {
      case TextType.link:
        return TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunch(other)) launch(other);
            },
          text: text,
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        );
      case TextType.bold:
        return TextSpan(
          text: text,
          style: TextStyle(fontWeight: FontWeight.bold),
        );
      case TextType.italic:
        return TextSpan(
          text: text,
          style: TextStyle(fontStyle: FontStyle.italic),
        );
      case TextType.underlined:
        return TextSpan(
          text: text,
          style: TextStyle(decoration: TextDecoration.underline),
        );
      default:
        return TextSpan(text: this.text);
    }
  }
}
