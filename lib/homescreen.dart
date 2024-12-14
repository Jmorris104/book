import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON parsing
import 'package:http/http.dart' as http; // For API requests

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> recommendedBooks = []; // Stores fetched book data
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Fetch books on screen load
  }

  Future<void> fetchBooks([String query = '']) async {
    try {
      // Replace with a valid API URL
      final url = Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=${query.isEmpty ? "fiction" : query}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          // Convert API data into List<Map<String, String>>
          recommendedBooks = (data['items'] as List).map<Map<String, String>>((item) {
            final volumeInfo = item['volumeInfo'] as Map<String, dynamic>? ?? {};
            final imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>? ?? {};

            return {
              'title': (volumeInfo['title'] ?? 'Unknown Title').toString(),
              'author': (volumeInfo['authors'] != null
                      ? (volumeInfo['authors'] as List).join(', ')
                      : 'Unknown Author')
                  .toString(),
              'image': (imageLinks['thumbnail'] ?? '').toString(),
            };
          }).toList();
        });
      } else {
        print('Failed to fetch books: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching books: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Recommendations"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search for books...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
                fetchBooks(value); // Fetch books based on search query
              },
            ),
            const SizedBox(height: 20),

            // Book Recommendations Grid
            recommendedBooks.isEmpty
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      itemCount: recommendedBooks.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final book = recommendedBooks[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailsScreen(book: book),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: book['image']!.isNotEmpty
                                      ? Image.network(
                                          book['image']!,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          color: Colors.grey[200],
                                          child: const Center(
                                            child: Icon(Icons.book, size: 50),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                book['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                book['author']!,
                                style: const TextStyle(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final Map<String, String> book;

  const BookDetailsScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            book['image']!.isNotEmpty
                ? Center(
                    child: Image.network(
                      book['image']!,
                      height: 200,
                    ),
                  )
                : const Center(child: Icon(Icons.book, size: 100)),
            const SizedBox(height: 16),
            Text(
              book['title']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'by ${book['author']}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              "Description: This is a placeholder description. You can fetch more details from the API here.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
