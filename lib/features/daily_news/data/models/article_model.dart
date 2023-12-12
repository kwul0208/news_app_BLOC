import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

@Entity(tableName: 'article', primaryKeys: ['url'])
class ArticleModel extends ArticleEntity{
  

  const ArticleModel({
    // String ? id,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      // id:  map['id'] ?? 1,
      // name: map['source']['name'] ?? '',
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'] ?? '',
    );
  }
  static List<ArticleModel> fromSnapshot(List snapshot){
    return snapshot.map((e){
      return ArticleModel.fromJson(e);
    }).toList();
  }

    ArticleModel toEntity() => ArticleModel(
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content,
      );
      
        @override
        // TODO: implement props
        List<Object?> get props => [
          author,
          title,
          description,
          url,
          urlToImage,
          publishedAt,
          content,
        ];
  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
      // id:  map['id'] ?? 1,
      // name: map['source']['name'] ?? '',
      author: entity.author,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
    );
  }

}