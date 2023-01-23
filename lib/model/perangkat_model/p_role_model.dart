class UserModel {
  final int kdRole;
  final String nmRole;

  UserModel(this.kdRole, this.nmRole);

  factory UserModel.fromJson(Map dataMap) {
    return UserModel(
      dataMap['kd_role'],
      dataMap['nm_role'],
    );
  }
}
