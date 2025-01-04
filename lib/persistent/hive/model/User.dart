import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final int age;

  User(this.name, this.age);
}