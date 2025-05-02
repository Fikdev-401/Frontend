import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  
  // Dummy data for notes
  List<Map<String, dynamic>> dummyResults = [
    {
      'title': 'Belajar jadi seseorang yang baik',
      'category': 'Personal Development',
      'date': '2 days ago',
      'imageUrl': '/placeholder.svg?height=56&width=56',
    },
    {
      'title': 'Investasi untuk masa depan',
      'category': 'Finance',
      'date': '1 week ago',
      'imageUrl': '/placeholder.svg?height=56&width=56',
    },
    {
      'title': 'Cara jadi ultraMan',
      'category': 'Self Improvement',
      'date': '3 days ago',
      'imageUrl': '/placeholder.svg?height=56&width=56',
    },
    {
      'title': 'Warren Buffett principles',
      'category': 'Finance',
      'date': '5 days ago',
      'imageUrl': '/placeholder.svg?height=56&width=56',
    },
    {
      'title': 'Kisah kisah kehidupan',
      'category': 'Reflections',
      'date': '1 day ago',
      'imageUrl': '/placeholder.svg?height=56&width=56',
    },
  ];

  // Categories for browsing
  List<Map<String, dynamic>> browseCategories = [
    {
      'name': 'Personal Goals',
      'color': Colors.pink,
      'imageUrl': '/placeholder.svg?height=150&width=150',
      'icon': Icons.flag,
    },
    {
      'name': 'Daily Reflections',
      'color': Colors.orange,
      'imageUrl': '/placeholder.svg?height=150&width=150',
      'icon': Icons.auto_stories,
    },
    {
      'name': 'Finance',
      'color': Colors.green,
      'imageUrl': '/placeholder.svg?height=150&width=150',
      'icon': Icons.attach_money,
    },
    {
      'name': 'Health',
      'color': Colors.purple,
      'imageUrl': '/placeholder.svg?height=150&width=150',
      'icon': Icons.favorite,
    },
    {
      'name': 'Career',
      'color': Colors.blue,
      'imageUrl': '/placeholder.svg?height=150&width=150',
      'icon': Icons.work,
    },
    {
      'name': 'Learning',
      'color': Colors.teal,
      'imageUrl': '/placeholder.svg?height=150&width=150',
      'icon': Icons.school,
    },
    {
      'name': 'Quotes',
      'color': Colors.indigo,
      'imageUrl': '/placeholder.svg?height=150&width=150',
      'icon': Icons.format_quote,
    },
    {
      'name': 'Gratitude',
      'color': Colors.amber,
      'imageUrl': '/placeholder.svg?height=150&width=150',
      'icon': Icons.volunteer_activism,
    },
  ];

  // Recent searches
  List<Map<String, dynamic>> recentSearches = [
    {
      'title': 'Tujuan hidup',
      'type': 'Goal',
      'imageUrl': '/placeholder.svg?height=60&width=60',
      'icon': Icons.flag,
    },
    {
      'title': 'Rasa syukur',
      'type': 'Note',
      'imageUrl': '/placeholder.svg?height=60&width=60',
      'icon': Icons.favorite,
    },
    {
      'title': 'Pelajaran',
      'type': 'Collection',
      'imageUrl': '/placeholder.svg?height=60&width=60',
      'icon': Icons.school,
    },
  ];

  List<Map<String, dynamic>> filteredResults = [];

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _isSearching = false;
        filteredResults = [];
      } else {
        _isSearching = true;
        filteredResults = dummyResults
            .where((note) =>
                note['title']!.toLowerCase().contains(query.toLowerCase()) ||
                note['category']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background color
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Search for Notes & Goals...',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.search, color: Colors.black),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, color: Colors.black),
                                  onPressed: () {
                                    _searchController.clear();
                                    _onSearchChanged('');
                                  },
                                )
                              : const Icon(Icons.mic, color: Colors.black),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onChanged: _onSearchChanged,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                      // Camera search functionality for scanning text
                    },
                  ),
                ],
              ),
            ),
            
            // Content area
            Expanded(
              child: _isSearching ? _buildSearchResults() : _buildBrowseContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (filteredResults.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        final note = filteredResults[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: 56,
              height: 56,
              color: _getCategoryColor(note['category']),
              child: Icon(
                _getCategoryIcon(note['category']),
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          title: Text(
            note['title'],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            '${note['category']} • ${note['date']}',
            style: TextStyle(color: Colors.grey[400]),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {
              // Show options menu
            },
          ),
          onTap: () {
            // Open note
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Opening note: ${note['title']}')),
            );
          },
        );
      },
    );
  }

  Widget _buildBrowseContent() {
    return ListView(
      children: [
        // Recent searches section
        if (recentSearches.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              'Recent searches',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentSearches.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final item = recentSearches[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _getTypeColor(item['type']),
                          borderRadius: BorderRadius.circular(item['type'] == 'Goal' ? 30 : 4),
                        ),
                        child: Icon(
                          item['icon'],
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 80,
                        child: Text(
                          item['title'],
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        item['type'],
                        style: TextStyle(color: Colors.grey[400], fontSize: 11),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],

        // Browse all section
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
          child: Text(
            'Browse categories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: browseCategories.length,
          itemBuilder: (context, index) {
            final category = browseCategories[index];
            return InkWell(
              onTap: () {
                // Get filtered notes for this category
                final categoryNotes = dummyResults
                    .where((note) => note['category'] == category['name'] || 
                                     _relatedCategories(note['category'], category['name']))
                    .toList();
                
                // Navigate to category detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryDetailPage(
                      categoryName: category['name'],
                      categoryColor: category['color'],
                      categoryIcon: category['icon'],
                      notes: categoryNotes,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: category['color'],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Icon(
                      category['icon'],
                      color: Colors.white.withOpacity(0.5),
                      size: 40,
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Text(
                      category['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Personal Development':
        return Colors.purple;
      case 'Finance':
        return Colors.green;
      case 'Self Improvement':
        return Colors.orange;
      case 'Reflections':
        return Colors.blue;
      default:
        return Colors.teal;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Personal Development':
        return Icons.person;
      case 'Finance':
        return Icons.attach_money;
      case 'Self Improvement':
        return Icons.trending_up;
      case 'Reflections':
        return Icons.auto_stories;
      default:
        return Icons.note;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Goal':
        return Colors.orange;
      case 'Note':
        return Colors.purple;
      case 'Collection':
        return Colors.teal;
      default:
        return Colors.blue;
    }
  }

  // Add this method to the _SearchPageState class
  bool _relatedCategories(String noteCategory, String browseCategory) {
    // Map note categories to browse categories
    final Map<String, List<String>> categoryMapping = {
      'Personal Goals': ['Personal Development', 'Self Improvement'],
      'Daily Reflections': ['Reflections'],
      'Finance': ['Finance'],
      'Health': ['Self Improvement'],
      'Career': ['Personal Development'],
      'Learning': ['Self Improvement'],
      'Quotes': ['Reflections'],
      'Gratitude': ['Reflections'],
    };
    
    // Check if the note category is related to the browse category
    final relatedCategories = categoryMapping[browseCategory] ?? [];
    return relatedCategories.contains(noteCategory);
  }
}

// Placeholder for CategoryDetailPage
class CategoryDetailPage extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;
  final IconData categoryIcon;
  final List<Map<String, dynamic>> notes;

  const CategoryDetailPage({
    Key? key,
    required this.categoryName,
    required this.categoryColor,
    required this.categoryIcon,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: categoryColor,
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note['title'] ?? 'No Title'),
            subtitle: Text(note['category'] ?? 'No Category'),
          );
        },
      ),
    );
  }
}
