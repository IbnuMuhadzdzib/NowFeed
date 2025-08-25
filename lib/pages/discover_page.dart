import 'package:flutter/material.dart';
import '../models/discover_item.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
  
}

  final TextEditingController _searchController = TextEditingController();


class _DiscoverPageState extends State<DiscoverPage> {
  List<DiscoverItem> allItems = [
    DiscoverItem(
      title: "Tech Innovations 2025",
      category: "Technology",
      content: "Teknologi terbaru 2025 akan menghadirkan AI lebih canggih...",
      image: "https://picsum.photos/400/200?random=1",
    ),
    DiscoverItem(
      title: "Travel Destinations You Must Visit",
      category: "Travel",
      content: "Beberapa destinasi traveling terbaik untuk liburan...",
      image: "https://picsum.photos/400/200?random=2",
    ),
    DiscoverItem(
      title: "Healthy Food Habits",
      category: "Health",
      content: "Cara hidup sehat dengan pola makan yang baik...",
      image: "https://picsum.photos/400/200?random=3",
    ),
    DiscoverItem(
      title: "Space Exploration Updates",
      category: "Science",
      content: "Update terbaru dari eksplorasi ruang angkasa...",
      image: "https://picsum.photos/400/200?random=4",
    ),
    DiscoverItem(
      title: "Minimalist Home Decor",
      category: "Lifestyle",
      content: "Tips mendekor rumah minimalis tapi aesthetic...",
      image: "https://picsum.photos/400/200?random=5",
    ),
  ];

  List<DiscoverItem> displayedItems = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    displayedItems = allItems;
  }

  void search(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      displayedItems = allItems
          .where((item) =>
              item.title.toLowerCase().contains(searchQuery) ||
              item.category.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  void openDetail(DiscoverItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscoverDetailPage(item: item),
      ),
    );
  }

   void clearSearch() {
    setState(() {
      _searchController.clear(); // 🔑 kosongin textfield
      searchQuery = "";
      displayedItems = allItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search Discover...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              search(value); // realtime filter
            },
            onSubmitted: (value) {
              search(value); // filter saat tekan enter
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  searchQuery = "";
                  displayedItems = allItems; // reset list
                });
              },
            ),
          ],
        ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: displayedItems.length,
        itemBuilder: (context, index) {
          final item = displayedItems[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => openDetail(item),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      item.image,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.category,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DiscoverDetailPage extends StatelessWidget {
  final DiscoverItem item;
  const DiscoverDetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.image,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              item.category,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 8),
            Text(
              item.content,
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
