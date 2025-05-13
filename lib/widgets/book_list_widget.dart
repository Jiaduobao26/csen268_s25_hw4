import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/book.dart';

class BookListWidget extends StatelessWidget {
  final List<Book> books;
  final String routerName;

  const BookListWidget({
    super.key,
    required this.books,
    required this.routerName,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () {
            
            context.goNamed(routerName, extra: book);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  book.author,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}