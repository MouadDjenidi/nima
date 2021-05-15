import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CustomText title;
  final AppBar appBar;
  const CustomAppBar({Key key, this.title, this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
     // clipper: CurvedClipper(),
      child: AppBar(
      title: title,
      backgroundColor: Colors.white,
      actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.blue[400]),
              onPressed: () {},
            )
          ],
      leading: Icon(Icons.menu , color: Colors.blue[400]),
      toolbarHeight: 60,
    ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
       size.width / 2, size.height, size.width, size.height - 30);
   path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}