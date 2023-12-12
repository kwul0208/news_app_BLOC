import 'dart:io';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/resources/exeption.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article_model.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';


class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this.newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    try {
      final result = await newsApiService.getNewsArticle();

      return DataSuccess(result as List<ArticleModel>);
    }
     on ServerException {
      return DataFailed("error");
    } on SocketException {
      return DataFailed("error");
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles(){
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article){
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article){
    print("repo");
    print(article);
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}

