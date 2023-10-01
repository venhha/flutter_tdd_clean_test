part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetNewsEvent extends NewsEvent {
  final GetArticleParams params;
  const GetNewsEvent(this.params);

  @override
  List<Object> get props => [params];
}
