
import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resources/exeption.dart';
import 'package:news_app/features/daily_news/data/models/article_model.dart';
import 'package:retrofit/retrofit.dart';

@RestApi(baseUrl: newsApiBaseUrl)
abstract class NewsApiService{
    Future<List<ArticleModel>> getNewsArticle();

}

class NewsApiServiceImpl implements NewsApiService{
  final Dio client;
  NewsApiServiceImpl({required this.client});

  @override
  Future <List<ArticleModel>> getNewsArticle()async{
    try {
      final response = await client.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=ff957763c54c44d8b00e5e082bc76cb0&category=general');
    
      if (response.statusCode == 200) {

        return ArticleModel.fromSnapshot(response.data['articles']);
        
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
    
  }
}