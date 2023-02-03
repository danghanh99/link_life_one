import 'package:hive_flutter/hive_flutter.dart';
import 'package:link_life_one/models/user.dart';


class BoxManager {
  static User get user => Hive.box<User>('userBox').values.last;
}