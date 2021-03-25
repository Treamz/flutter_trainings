import 'package:flutter/material.dart';

import 'package:unsplash_testapp/misc/interface_image.dart';
import 'package:unsplash_testapp/misc/colors.dart';
import 'fullscreen_widget.dart';

class ImageCard extends StatefulWidget {
  ImageCard({Key key, this.image});

  final IImage image;

  @override
  _ImageCard createState() => _ImageCard(image);
}

class _ImageCard extends State<ImageCard> {
  IImage _image;

  _ImageCard(IImage image) {
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    return imageCard(context, _image);
  }
}

// Navigator.pushNamed(context, FullScreenWidget.routeName
Widget imageCard(context, _image) {
  print(ModalRoute.of(context).settings.name);
  return InkWell(
      onTap: () {
        if (ModalRoute.of(context).settings.name == 'galleryWidget') {
          Navigator.pushNamed(context, FullScreenWidget.routeName,
              arguments: _image);
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Image.network(_image.fullImgUrl),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.ImageCardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 0, left: 8.0),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(_image.authorAvatar, scale: 1.6)),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      _image.authorName,
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ));
}
