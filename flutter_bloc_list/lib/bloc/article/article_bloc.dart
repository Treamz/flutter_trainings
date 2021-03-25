import 'package:bloc/bloc.dart';
import 'package:testbloc/bloc/article/article_event.dart';
import 'package:testbloc/bloc/article/article_state.dart';
import 'package:testbloc/data/model/api_result_model.dart';
import 'package:testbloc/data/repository/article_repository.dart';
import 'package:meta/meta.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  List<Articles> articles;

  ArticleRepository repository;
  get currentState => state;

  ArticleBloc({@required this.repository}) : super(null);
  @override
  // TODO: implement initialState
  ArticleState get initialState => ArticleInitialState();

  List<Articles> get getArticles {
    return articles;
  }

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield ArticleLoadingState();
      try {
        articles = await repository.getArticles();

        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    } else if (event is FilterArticlesEvent) {
      List<Articles> fArticles = articles.where((article) {
        if (article.title.toLowerCase().contains(event.q.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }).toList();
      yield ArticleFilterState(filteredArticles: fArticles);
    }
  }
}
