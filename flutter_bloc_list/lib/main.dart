import 'package:testbloc/bloc/article/article_bloc.dart';
import 'package:testbloc/data/repository/article_repository.dart';
import 'package:testbloc/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      home: BlocProvider(
        create: (context) => ArticleBloc(repository: ArticleRepositoryImpl()),
        child: HomePage(),
      ),
    );
  }
}
