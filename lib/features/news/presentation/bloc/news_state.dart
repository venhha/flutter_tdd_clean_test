part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitialState extends NewsState {}

final class NewsLoadingState extends NewsState {}

final class NewsLoadedState extends NewsState {
  final List<ArticleEntity> articles;
  const NewsLoadedState({required this.articles});
  @override
  List<Object> get props => [articles];
}

final class NewsErrorState extends NewsState {
  final String message;
  const NewsErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
