abstract class RemoteArticlesEvent{
  const RemoteArticlesEvent();
}

class GetArticles extends RemoteArticlesEvent{
  const GetArticles();
}
class RefreshArticle extends RemoteArticlesEvent{
  const RefreshArticle();
}