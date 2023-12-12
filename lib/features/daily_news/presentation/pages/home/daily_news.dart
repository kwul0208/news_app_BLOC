import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widget/news_card.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(context) {
    return AppBar(
      title: Text("Daily News",
        style: TextStyle(
          color: Colors.black
        ),
      ),
      actions: [
        GestureDetector(
            onTap: () => _onShowSavedArticlesViewTapped(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.bookmark, color: Colors.black),
            ),
          ),
      ],
    );
  }
  _buildBody(){
    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
      builder: (context, state){
        if(state is RemoteArticleLoading){
          return const Center(child: CupertinoActivityIndicator(),);
        }
        if (state is RemoteArticleError) {
          return Center(child: Column(
            children: [
              GestureDetector(
                child: Icon(Icons.refresh),
                onTap: (){
                  context.read<RemoteArticlesBloc>()..add(RefreshArticle());
                },
              ),
              Text("${state.error}")
            ],
          ),);
        }
        if (state is RemoteArticleDone) {
          return ListView.builder(
            itemCount: state.articles!.length,
            itemBuilder: (context, index){
              return ArticleWidget(
                article: state.articles![index] ,
                onArticlePressed: (article) => _onArticlePressed(context,article),

              );
            },
          );
        }
        return SizedBox();
      }
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
  
}