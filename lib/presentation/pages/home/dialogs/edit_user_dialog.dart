import 'package:flutter/material.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/params.dart';

class EditUserDialog extends StatefulWidget {
  final AppUser user;

  EditUserDialog(this.user);

  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  late UserRole userRole;

  @override
  void initState() {
    userRole = widget.user.userRole;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => _ListRolesDialog(),
                    ).then((value) {
                      if (value != null && value is UserRole) {
                        setState(() {
                          userRole = value;
                        });
                      }
                    });
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                Text(userRole.toString()),
              ],
            ),
            SizedBox(
              width: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  if (widget.user.userRole != userRole) {
                    Navigator.pop(
                      context,
                      UpdateUserParams(
                        widget.user.id,
                        mapFromUserRole(userRole),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text('Update')),
            SizedBox(
              width: 8,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  DeleteUserParams(widget.user.id),
                );
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListRolesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(UserRole.REGULAR.toString()),
            onTap: () {
              Navigator.pop(context, UserRole.REGULAR);
            },
          ),
          ListTile(
            title: Text(UserRole.OWNER.toString()),
            onTap: () {
              Navigator.pop(context, UserRole.OWNER);
            },
          ),
          ListTile(
            title: Text(UserRole.ADMIN.toString()),
            onTap: () {
              Navigator.pop(context, UserRole.ADMIN);
            },
          ),
        ],
      ),
    );
  }
}
