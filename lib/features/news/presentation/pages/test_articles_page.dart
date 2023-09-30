// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_test/features/news/domain/usecase/get_article.dart';
import 'package:flutter_tdd_clean_test/injection_container.dart';

class ArticleTestPage extends StatefulWidget {
  const ArticleTestPage({super.key});

  @override
  State<ArticleTestPage> createState() => _ArticleTestPageState();
}

class _ArticleTestPageState extends State<ArticleTestPage> {
  List<Todo> todo = Todo.initTodoList();
  GetArticle getArticle = sl<GetArticle>();

  GetArticleParams getArticleParams = GetArticleParams(
    q: 'tesla',
    from: '2023-10-01',
    to: '2023-09-30',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListViewBuilder'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: todo.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(todo[index].title),
                  trailing: Checkbox(
                    value: todo[index].isChecked,
                    onChanged: (value) {
                      setState(() {
                        todo[index].isChecked = value!;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Todo {
  String title;
  bool isChecked;
  Todo({
    required this.title,
    required this.isChecked,
  });

  static List<Todo> initTodoList() {
    return [
      Todo(
        title: 'Todo 1',
        isChecked: false,
      ),
      Todo(
        title: 'Todo 2',
        isChecked: false,
      ),
      Todo(
        title: 'Todo 3',
        isChecked: false,
      ),
    ];
  }
}
