import 'package:flutter/material.dart';

void main() => runApp(LibraryApp());

class LibraryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LibraryScreen(),
    );
  }
}

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  // Updated book data
  final List<Map<String, String>> books = [
    {'title': 'The Cask of Amontillado', 'author': 'Edgar Allan Poe', 'category': 'Reading'},
    {'title': 'Harry Potter and the Chamber of Secrets', 'author': 'J.K. Rowling', 'category': 'To Read'},
    {'title': 'To Kill a Mockingbird', 'author': 'Harper Lee', 'category': 'Finished'},
  ];

  String selectedCategory = 'Reading';
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    final filteredBooks = books.where((book) => book['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.grid_view : Icons.list),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category tabs
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Reading', 'To Read', 'Finished'].map((category) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: Text(category),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCategory == category ? Colors.red : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ),
          // Book display
          Expanded(
            child: isGridView
                ? GridView.builder(
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, index) {
                      return BookCard(
                        book: filteredBooks[index],
                        onTap: () => navigateToBookDetails(context, filteredBooks[index]),
                      );
                    },
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, index) {
                      return BookCard(
                        book: filteredBooks[index],
                        isListView: true,
                        onTap: () => navigateToBookDetails(context, filteredBooks[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void navigateToBookDetails(BuildContext context, Map<String, String> book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(book: book),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Map<String, String> book;
  final bool isListView;
  final VoidCallback onTap;

  BookCard({required this.book, this.isListView = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8),
        child: isListView
            ? ListTile(
                title: Text(book['title'] ?? ''),
                subtitle: Text(book['author'] ?? ''),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, size: 50, color: Colors.green),
                  SizedBox(height: 10),
                  Text(book['title'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(book['author'] ?? ''),
                ],
              ),
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final Map<String, String> book;

  BookDetailsScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title'] ?? 'Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${book['title']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Author: ${book['author']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Description: \nThis is a placeholder for the book description.',
                style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
