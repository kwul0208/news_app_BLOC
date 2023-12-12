import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class RemoteArticleState extends Equatable{
  final List<ArticleEntity> ? articles;
  final String ? error;
  const RemoteArticleState({this.articles, this.error});

  @override
  List <Object?> get props => [articles!, error!];
}

class RemoteArticleLoading extends RemoteArticleState{
  const RemoteArticleLoading();
}

class RemoteArticleDone extends RemoteArticleState{
  const RemoteArticleDone(List<ArticleEntity> article) : super(articles: article);
}

class RemoteArticleError extends RemoteArticleState{
  const RemoteArticleError(String error) : super(error: error);
}