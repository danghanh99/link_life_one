import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Assets {
  static const String LOGO_LINK = './assets/images/link_logo.png';
  static const String COMMENT_ICON = './assets/images/comment_icon.png';
  static const String NEWS_ICON = './assets/images/news_icon.png';

  static const String polygonLeft = './assets/images/polygon_left.png';
  static const String polygonRight = './assets/images/polygon_right.png';
  static const String rectangle = './assets/images/rectangle.png';

  static const String icCalendar = './assets/images/ic_calendar.png';

  static const String icDown = './assets/images/down.png';

  static const String icDropdown = './assets/images/ic_dropdown.png';

  static const String gettingMessage = '読み込み中です。';
  static const String emptyMessage = 'データはありません。';

  static ImageProvider blankImage = MemoryImage(const Base64Codec()
      .decode("R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"));
}
