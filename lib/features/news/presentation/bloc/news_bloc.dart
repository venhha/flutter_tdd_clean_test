import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/entities/article.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/usecase/get_article.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetArticleUseCase _getNewsUseCase;

  NewsBloc(this._getNewsUseCase) : super(NewsInitialState()) {
    on<GetNewsEvent>((event, emit) async {
      emit(NewsLoadingState());

      final resultEither = await _getNewsUseCase(event.params);

      resultEither.fold(
        (failure) {
          emit(NewsErrorState(message: failure.message.toString()));
        },
        (articles) {
          emit(NewsLoadedState(articles: articles));
        },
      );
    });
  }
}
