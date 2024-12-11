import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> recommendedBooks = [
    {
      'title': 'The Alchemist',
      'author': 'Paulo Coelho',
      'image': 'assets/book1.png',
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'image': 'assets/book2.png',
    },
    {
      'title': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'image': 'assets/book3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Recommendations"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _showMenu(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search for books...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Book Recommendations Grid
            Expanded(
              child: GridView.builder(
                itemCount: recommendedBooks.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            child: Image.asset(
                              book['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          book['title']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          book['author']!,
                          style: TextStyle(color: Colors.grey),
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

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text("Library"),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Library screen
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Community"),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Community screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings screen
              },
            ),
          ],
        );
      },
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
            // Book Cover
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  book['image']!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Book Title and Author
            Text(
              book['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'by ${book['author']}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),

            // Book Description and Metadata
            Text(
              "Description: A captivating story about ...",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ratings: 4.5/5", style: TextStyle(fontSize: 16)),
                Text("Genre: Fiction", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 16),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add to Library functionality
                  },
                  child: Text("Add to Library"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Write Review screen
                  },
                  child: Text("Write Review"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Read Reviews screen
                  },
                  child: Text("Read Reviews"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}