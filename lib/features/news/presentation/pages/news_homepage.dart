import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/usecase/get_article.dart';
import 'package:flutter_tdd_clean_test/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_tdd_clean_test/features/news/presentation/widgets/article_item.dart';
import 'package:flutter_tdd_clean_test/features/news/presentation/widgets/custom_widgets.dart';
import 'package:flutter_tdd_clean_test/injection_container.dart';

class NewsHomePage extends StatelessWidget {
  const NewsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: buildBody());
  }

  BlocProvider<NewsBloc> buildBody() {
    return BlocProvider(
      create: (_) => sl<NewsBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Top part --display search bar
              const NewsControl(),

              const SizedBox(
                height: 30,
              ),

              // bottom part --display list of articles
              BlocBuilder<NewsBloc, NewsState>(builder: (_, state) {
                if (state is NewsInitialState) {
                  return const Text('NewsInitialState');
                } else if (state is NewsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsLoadedState) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        return ArticleItem(article: state.articles[index]);
                      },
                    ),
                  );
                } else if (state is NewsErrorState) {
                  return Text(state.message.toString());
                }
                return const Text('Some thing went wrong!!!');
              }),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('News App'),
    );
  }
}

class NewsControl extends StatefulWidget {
  const NewsControl({
    super.key,
  });

  @override
  State<NewsControl> createState() => _NewsControlState();
}

class _NewsControlState extends State<NewsControl> {
  String q = '';
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'Enter search term',
      ),
      onChanged: (value) {
        setState(() {
          q = value;
        });
      },
      onSubmitted: (value) {
        debugPrint('onSubmitted: $value');
        BlocProvider.of<NewsBloc>(context)
            .add(GetNewsEvent(GetArticleParams(q: q)));
      },
    );
  }
}
