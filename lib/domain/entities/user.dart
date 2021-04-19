class AppUser {
  final String id;
  final UserRole userRole;

  AppUser({
    required this.userRole,
    required this.id,
  });
  factory AppUser.fromMap(String id ,Map<String, dynamic> data) => AppUser(
        id: id,
        userRole: mapToUserRole(data['role']),
      );

  bool get isOwner => userRole == UserRole.OWNER;
  bool get isRegular => userRole == UserRole.ADMIN;
  bool get isAdmin => userRole == UserRole.ADMIN;
}

enum UserRole { REGULAR, OWNER, ADMIN }

UserRole mapToUserRole(int i) {
  final role = _map[i] ?? UserRole.REGULAR;
  return role;
}

final _map = {
  1: UserRole.REGULAR,
  2: UserRole.OWNER,
  3: UserRole.ADMIN,
};
