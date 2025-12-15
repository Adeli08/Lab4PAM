import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @override
  @JsonKey(name: 'name')
  final String name;

  @override
  @JsonKey(name: 'profile_image')
  final String profileImage;

  @override
  @JsonKey(name: 'notification_count')
  final int notificationCount;

  UserModel({
    required this.name,
    required this.profileImage,
    required this.notificationCount,
  }) : super(
          name: name,
          profileImage: profileImage,
          notificationCount: notificationCount,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}