import 'package:digitalis_restaurant_app/module/account/data/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String? _image;
  final String _text;

  const ProfilePicture({
    Key? key,
    String? image,
    String text = 'JD',
  })  : _image = image,
        _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return _sampleImage();
    }

    return SizedBox(
      width: 120,
      height: 120,
      child: ClipRRect(
          child: CachedNetworkImageWidget(
        imageUrl: _image!,
      )),
    );
  }

  Widget _sampleImage() {
    return Container(
      width: 120,
      height: 120,
      color: Colors.blue,
      child: ClipRRect(
        child: Center(
          child: Text(_text),
        ),
      ),
    );
  }
}
