import 'dart:math';

class Cursor {
  int line = 0;
  int column = 0;

  // for selecting text
  int anchorLine = -1;
  int anchorColumn = 0;

  void moveCursor(int line, int column, bool keepAnchor) {
    if (keepAnchor && anchorLine < 0) {
      anchorLine = this.line;
      anchorColumn = this.column;
    }

    if (line >= 0 && column >= 0) {
      this.line = line;
      this.column = column;
    }
  }

  void moveCursorLeft(bool keepAnchor) {
    if (keepAnchor && anchorLine < 0) {
      anchorColumn = column;
    }
    column -= 1;
  }

  void moveCursorRight(bool keepAnchor) {
    if (keepAnchor && anchorLine < 0) {
      anchorColumn = column;
    }
     column += 1;
  }

  void clearSelection() {
    anchorLine = -1;
  }
}

class Document {
  List<String> lines = [];
  var cursor = Cursor();

  void validateCursor() {
    cursor.column = min(max(cursor.column, 0), lines[cursor.line].length);
  }

  String selectedString() {
    String str = "";
    if (cursor.anchorLine != -1) {
      int startingLine = min(cursor.anchorLine, cursor.line);
      int endingLine = max(cursor.anchorLine, cursor.line);
      int startingColumn = startingLine == cursor.anchorLine ? cursor.anchorColumn : cursor.column;
      int endingColumn = endingLine == cursor.anchorLine ? cursor.anchorColumn : cursor.column;
      
      for (int i = startingLine; i <= endingLine; i++) {
        int start = i == startingLine ? startingColumn : 0;
        int end = i == endingLine ? endingColumn : lines[i].length;
        str += lines[i].substring(start, end);
      }
    }
    return str;
  }
}
