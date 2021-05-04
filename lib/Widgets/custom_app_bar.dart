import 'package:flutter/material.dart';
import 'package:nima/constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  const CustomAppBar({Key key, this.title, this.appBar, this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: ClipPath(
      clipper: CurvedClipper(),
      child: AppBar(
      title: title,
      backgroundColor: appBarColor,
      actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            )
          ],
      leading: Icon(Icons.menu , color: Colors.white),
      toolbarHeight: 60,
    ),
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