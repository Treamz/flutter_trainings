import 'dart:io';

import 'package:flutter/material.dart';

import 'package:unsplash_testapp/api/unsplash_image.dart';
import 'package:unsplash_testapp/api/unsplash_api.dart';
import 'package:unsplash_testapp/views/image_card.dart';

import 'package:unsplash_testapp/misc/colors.dart';

class GalleryWidget extends StatefulWidget {
  GalleryWidget({Key key}) : super(key: key);

  static const String routeName = 'galleryWidget';

  @override
  _GalleryWidget createState() => _GalleryWidget();
}

class _GalleryWidget extends State<GalleryWidget> {
  List<ImageCard> _imgs = <ImageCard>[];
  UnsplashAPI _api = UnsplashAPI();

  final int _countOfPictures = 10;

  bool _isLoading = true;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMore();
  }

  void _loadMore() {
    _isLoading = true;
    _api.getPictures(_countOfPictures).then((List<UnsplashImage> fetchedList) {
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          for (var i in fetchedList) {
            _imgs.add(ImageCard(image: i));
          }
        });
      }
    });
  }

  Widget _noConnectionWidget(String error) {
    return Column(children: <Widget>[
      Icon(Icons.error_outline, color: AppColors.ErrorColor, size: 60),
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Text('Error: ' + error),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // InternetAddress.lookup(UnsplashAPI.baseUrl).then((value) {
    //   if (value.isEmpty && value[0].rawAddress.isEmpty) {
    //     return _noConnectionWidget('Could not connection to Unsplash');
    //   }
    // });
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/unsplash_logo.png', scale: 8.5),
          centerTitle: true,
          backgroundColor: AppColors.PrimaryColor,
        ),
        body: FutureBuilder<List<UnsplashImage>>(
          future: _api.getPictures(_countOfPictures),
          builder: (BuildContext context,
              AsyncSnapshot<List<UnsplashImage>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: _noConnectionWidget(snapshot.error));
            } else if (!snapshot.hasData) {
              return Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              AppColors.LoadingColor),
                        ),
                        width: 60,
                        height: 60,
                      ),
                    ]),
              );
            }

            return Center(
              child: ListView.builder(
                  itemCount: _hasMore ? _imgs.length + 1 : _imgs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= _imgs.length) {
                      if (!_isLoading) {
                        _loadMore();
                      }

                      return Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 25,
                          width: 25,
                        ),
                      );
                    }

                    return Container(
                      child: _imgs[index],
                    );
                  }),
            );
          },
        ));
  }
}
