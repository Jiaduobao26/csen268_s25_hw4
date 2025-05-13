import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/book_bloc.dart';
import '../model/book.dart';
import '../widgets/book_list_widget.dart';


  @override
  class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouter.of(context).location;

    // according to the route, dispatch the corresponding event
    if (location.contains('/byAuthor')) {
      context.read<BookBloc>().add(SortByAuthor());
    } else if (location.contains('/byTitle')) {
      context.read<BookBloc>().add(SortByTitle());
    }

    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        List<Book> books = [];
        String title = "";

        // according to the route, get the corresponding state
        if (location.contains('/byAuthor')) {
          title = "Sorted By Author";
          if (state is BooksSortedByAuthor) {
            books = state.books;
          }
        } else if (location.contains('/byTitle')) {
          title = "Sorted By Title";
          if (state is BooksSortedByTitle) {
            books = state.books;
          }
        }

        // handle loading and error states
        if (state is BookLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BookError) {
          return const Center(child: Text("Failed to load books"));
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                Expanded(
                  child: books.isNotEmpty
                      ? BookListWidget(books: books, routerName: location == '/byAuthor' ? 'byAuthorDetail' : 'byTitleDetail')
                      : const Center(child: Text("Empty List")),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
