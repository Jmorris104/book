import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, String>> topics = [
    {'title': 'Analysis of "The Cask of Amontillado"', 'author': 'User1', 'replies': '15'},
    {'title': 'Harry Potter Theories', 'author': 'User2', 'replies': '8'},
    {'title': 'Themes in "To Kill a Mockingbird"', 'author': 'User3', 'replies': '23'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredTopics = topics.where((topic) {
      final query = searchQuery.toLowerCase();
      return topic['title']!.toLowerCase().contains(query) ||
          topic['author']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search topics or books',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTopics.length,
              itemBuilder: (context, index) {
                final topic = filteredTopics[index];
                return ListTile(
                  title: Text(topic['title'] ?? ''),
                  subtitle: Text('Author: ${topic['author']} • Replies: ${topic['replies']}'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => navigateToDiscussionDetails(context, topic),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void navigateToDiscussionDetails(BuildContext context, Map<String, String> topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscussionDetailsScreen(topic: topic),
      ),
    );
  }
}

class DiscussionDetailsScreen extends StatelessWidget {
  final Map<String, String> topic;

  DiscussionDetailsScreen({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic['title'] ?? 'Discussion Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Topic: ${topic['title']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Started by: ${topic['author']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Replies:', style: TextStyle(fontSize: 14)),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  Text('This is a placeholder for replies to this topic.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
