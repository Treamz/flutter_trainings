import 'package:testbloc/bloc/article/article_bloc.dart';
import 'package:testbloc/bloc/article/article_event.dart';
import 'package:testbloc/bloc/article/article_state.dart';
import 'package:testbloc/data/model/api_result_model.dart';
import 'package:testbloc/ui/pages/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc articleBloc;
  final TextEditingController _textController = TextEditingController();

  int selected = -1;
  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
                appBar: AppBar(
                  title: Text("Test App"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        articleBloc.add(FetchArticlesEvent());
                      },
                    ),
                  ],
                ),
                body: Column(
                  children: <Widget>[
                    Form(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                controller: _textController,
                                decoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'hint',
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              articleBloc.add(
                                  FilterArticlesEvent(_textController.text));
                            },
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocListener<ArticleBloc, ArticleState>(
                        listener: (context, state) {
                          if (state is ArticleErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<ArticleBloc, ArticleState>(
                          builder: (context, state) {
                            if (state is ArticleInitialState) {
                              return buildLoading();
                            } else if (state is ArticleLoadingState) {
                              return buildLoading();
                            } else if (state is ArticleLoadedState) {
                              return buildArticleList(state.articles);
                            } else if (state is ArticleFilterState) {
                              return buildArticleList(state.filteredArticles);
                            } else if (state is ArticleErrorState) {
                              return buildErrorUi(state.message);
                            }
                            return buildErrorUi("ERR");
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      key: Key('builder ${selected.toString()}'),
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ExpansionTile(
              key: Key(pos.toString()),
              title: Text(articles[pos].title),
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(articles[pos].description),
                      TextButton(
                          onPressed: () {
                            navigateToArticleDetailPage(context, articles[pos]);
                          },
                          child: Text("Подробнее"))
                    ],
                  ),
                )
              ],
              initiallyExpanded: pos == selected,
              onExpansionChanged: (expanded) {
                if (expanded)
                  setState(() {
                    selected = pos;
                  });
                else
                  setState(() {
                    selected = -1;
                  });
              },
            ),
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        article: article,
      );
    }));
  }
}
