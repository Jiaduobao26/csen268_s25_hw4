import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/book.dart';

// define sort type
enum SortType { title, author }

// define events
abstract class BookEvent {}

class LoadBooks extends BookEvent {}

class SortByAuthor extends BookEvent {}

class SortByTitle extends BookEvent {}

// define states
abstract class BookState {
  const BookState();
}

class BookLoading extends BookState {}

class BooksSortedByAuthor extends BookState {
  final List<Book> books;

  const BooksSortedByAuthor(this.books);
}

class BooksSortedByTitle extends BookState {
  final List<Book> books;

  const BooksSortedByTitle(this.books);
}

class BookLoaded extends BookState {
  final List<Book> books;

  const BookLoaded(this.books);
}

class BookError extends BookState {
  final String message;

  const BookError(this.message);
}

// Bloc implementation
class BookBloc extends Bloc<BookEvent, BookState> {
  List<Book> books = [];
  SortType sortType = SortType.author;

  BookBloc() : super(BookLoading()) {
    on<SortByAuthor>(_onSortbyAuthor);
    on<SortByTitle>(_onSortbyTitle);
    on<LoadBooks>(_onLoadBooks);
  }

  void _onSortbyAuthor(SortByAuthor event, Emitter<BookState> emit) {
    books.sort((a, b) => a.author.compareTo(b.author));
    sortType = SortType.author;
    emit(BooksSortedByAuthor(List.from(books)));
  }

  void _onSortbyTitle(SortByTitle event, Emitter<BookState> emit) {
    books.sort((a, b) => a.title.compareTo(b.title));
    sortType = SortType.title;
    emit(BooksSortedByTitle(List.from(books)));
  }

  Future<void> _onLoadBooks(LoadBooks event, Emitter<BookState> emit) async {
    try {
      final data = await rootBundle.loadString('assets/book_list.json');
      final List<dynamic> jsonList = json.decode(data);
      books = jsonList.map((json) => Book.fromJson(json)).toList();
      books.sort((a, b) => a.author.compareTo(b.author)); // default sort by author
      sortType = SortType.author;
      emit(BooksSortedByAuthor(List.from(books)));
    } catch (e) {
      emit(BookError('Failed to load books: $e'));
    }
  }
}