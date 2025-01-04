import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@collection
class UserModel {
  @HiveField(0)
  Id id = Isar.autoIncrement;

  @HiveField(1)
  String? name;

  @HiveField(2)
  int? age;

  @HiveField(3)
  String? email;

  UserModel({
    this.name,
    this.age,
    this.email,
  });
} 