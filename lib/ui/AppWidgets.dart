import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/resources/AppColors.dart';

class RoundedImage extends StatelessWidget {
  final String imgPath;
  final String imgPlaceHolder;
  final double height;
  final double width;

  RoundedImage(
      {@required this.imgPath,
      this.imgPlaceHolder = 'images/placeholder.jpg',
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: 200),
        fadeOutDuration: Duration(milliseconds: 200),
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
              color: AppColors.COLOR_DARK_PRIMARY,
              border: Border.all(color: AppColors.TEXT_COLOR)),
          child: Center(
            child: ProgressBar(),
          ),
        ),
        imageUrl: imgPath,
        fit: BoxFit.fill,
        height: height ?? height,
        width: width ?? width,
        errorWidget: (context, url, error) => Image.asset(
          imgPlaceHolder,
          fit: BoxFit.fill,
        ),
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
