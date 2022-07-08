enum UserRole { REGULAR, OWNER, ADMIN }

UserRole mapToUserRole(int i) {
  return _map[i]!;
}

final _map = {
  1: UserRole.REGULAR,
  2: UserRole.OWNER,
  3: UserRole.ADMIN,
};
