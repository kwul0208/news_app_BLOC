
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecase/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState>{

  final GetArticleUseCase _getArticleUseCase;
  
  RemoteArticlesBloc(this._getArticleUseCase) : super(const RemoteArticleLoading()){
    on <GetArticles> (onGetArticles);
    on <RefreshArticle> (onRefreshArticle);
  }

  void onGetArticles(GetArticles event, Emitter<RemoteArticleState> emit)async{
    final dataState = await _getArticleUseCase();
    // emit(RemoteArticleLoading());

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // print("dataState.data");
      // print(dataState.data);
      emit(RemoteArticleDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteArticleError(dataState.error!));
    }
  }

  void onRefreshArticle(RefreshArticle event, Emitter<RemoteArticleState> emit)async{
    emit(RemoteArticleLoading());
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // print("dataState.data");
      // print(dataState.data);
      emit(RemoteArticleDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteArticleError(dataState.error!));
    }
  }
}