import 'package:flutter/material.dart';

import 'package:unsplash_testapp/views/gallery_widget.dart';
import 'package:unsplash_testapp/views/fullscreen_widget.dart';

void main() {
  runApp(MaterialApp(initialRoute: GalleryWidget.routeName, routes: {
    GalleryWidget.routeName: (context) => GalleryWidget(),
    FullScreenWidget.routeName: (context) => FullScreenWidget(),
  }));
}
