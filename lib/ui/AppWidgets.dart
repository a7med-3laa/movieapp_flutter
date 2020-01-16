import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String imgPath;
  final String imgplaceHolder;
  final double height;
  RoundedImage(
      {@required this.imgPath,
      this.imgplaceHolder = 'images/placeholder.jpg',
      this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: FadeInImage(
        placeholder: AssetImage(imgplaceHolder),
        image: NetworkImage(imgPath),
        fit: BoxFit.fill,
        height: height ?? height,
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
