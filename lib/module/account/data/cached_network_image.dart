
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final String errorText;

  const CachedNetworkImageWidget(
      {Key? key, required this.imageUrl, this.errorText = 'error'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      placeholder: (context, url) => Center(
          child: Container(
              decoration: const ShapeDecoration(
                color: Color.fromRGBO(200, 200, 200, 1),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color.fromRGBO(200, 200, 200, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
              ),
              child: Center(child: CircularProgressIndicator(color: kPrimaryColor,)))),
      errorWidget: (context, url, error) => Center(
          child: Container(
              decoration: const ShapeDecoration(
                color: Color.fromRGBO(250, 250, 250, 1),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color.fromRGBO(250, 250, 250, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error),
                    Text("${errorText}"),
                  ],
                ),
              ))),
    );
  }
}
