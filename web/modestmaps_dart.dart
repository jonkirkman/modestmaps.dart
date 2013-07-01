import 'dart:html';
import '../lib/modestmaps.dart' as mm;

void main() {
  query("#sample_text_id")
    ..text = "Click me!"
    ..onClick.listen(reverseText);

  var blah = new mm.Point(0,0);
  print(blah);

  var mappy = new mm.Map(query("#mappy"));
}

void reverseText(MouseEvent event) {
  var text = query("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  query("#sample_text_id").text = buffer.toString();
}
