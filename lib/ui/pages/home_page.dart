import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/journals/journals_bloc.dart';
import 'package:flutter_frontend/bloc/journalsCategory/category_journal_bloc.dart';
import 'package:flutter_frontend/bloc/user/user_bloc.dart';
import 'package:flutter_frontend/core/core.dart';
import 'package:flutter_frontend/ui/dialogs/add_journal_dialogs.dart';
import 'package:flutter_frontend/ui/pages/detail_journal_page.dart';
import 'package:flutter_frontend/utils/session_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await SessionManager().getUserId();
    if (id == null) {
      print('User ID belum ada di SharedPreferences.');
      return;
    }

    setState(() {
      userId = id;
    });

    context.read<UserBloc>().add(GetUserById(id: id));
    context.read<JournalsBloc>().add(LoadJournals(userId: id));
    context.read<CategoryJournalBloc>().add(LoadCategoryJournal());
  }

  @override
  Widget build(BuildContext context) {
    // Data for playlists
    final List<Map<String, dynamic>> data = [
      {
        'title': 'Tujuan hidup',
        'color': Colors.purple,
        'icon': Icons.lightbulb_outline,
      },
      {
        'title': 'Rasa syukur',
        'color': Colors.orange,
        'icon': Icons.favorite_border,
      },
      {
        'title': 'Pelajaran',
        'color': Colors.teal,
        'icon': Icons.school_outlined,
      },
      {
        'title': 'Inspirasi',
        'color': Colors.blue,
        'icon': Icons.emoji_objects_outlined,
      },
      {
        'title': 'Motivasi',
        'color': Colors.red,
        'icon': Icons.trending_up,
      },
      {
        'title': 'Refleksi',
        'color': Colors.green,
        'icon': Icons.self_improvement_outlined,
      },
    ];

    // Recently played data
    final List<Map<String, dynamic>> recentlyPlayed = [
      {
        'title': 'Motivasi Pagi',
        'type': 'Daily Motivation',
        'imageUrl': '/placeholder.svg?height=150&width=150',
        'color': Colors.orange,
      },
      {
        'title': 'Quotes Inspiratif',
        'type': 'Collection',
        'imageUrl': '/placeholder.svg?height=150&width=150',
        'color': Colors.purple,
      },
      {
        'title': 'Meditasi Malam',
        'type': 'Relaxation',
        'imageUrl': '/placeholder.svg?height=150&width=150',
        'color': Colors.indigo,
      },
      {
        'title': 'Affirmasi Harian',
        'type': 'Self-improvement',
        'imageUrl': '/placeholder.svg?height=150&width=150',
        'color': Colors.teal,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with profile and actions
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    // Profile avatar with notification dot
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.surface,
                          backgroundImage:
                              const AssetImage('assets/images/dev.jpg'),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColors.spotifyGreen,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.backgroundDark,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),

                    // Filter buttons
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterButton('Semua', true),
                            const SizedBox(width: 8),
                            _buildFilterButton('Note', false),
                            const SizedBox(width: 8),
                            _buildFilterButton('Goals', false),
                            const SizedBox(width: 8),
                            _buildFilterButton('Quotes', false),
                          ],
                        ),
                      ),
                    ),

                    // Logout button
                  ],
                ),
              ),

              // Greeting section with gradient
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is UserLoaded) {
                          final name = state.data.name;
                          return Text(
                            'Good Morning ${name}',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (state is UserError) {
                          print(state.message);
                          return Center(
                              child: Text(
                            state.message,
                            style: TextStyle(color: AppColors.white),
                          ));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'What would you like to note today?',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Top playlists grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<CategoryJournalBloc, CategoryJournalState>(
                  builder: (context, state) {
                    if (state is CategoryJournalLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CategoryJournalLoaded) {
                      final playlists = state.categoryJournal;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2.8,
                        ),
                        itemCount: playlists.length,
                        itemBuilder: (context, index) {
                          final datas = playlists[index];
                          return InkWell(
                            onTap: () {
                              print(datas.id);
                              try {
                                showDialog(
                                  context: context,
                                  builder: (context) => AddJournalDialogs(
                                    categoryId: datas.id,
                                    categoryTitle: datas.title,
                                  ),
                                );
                                print("Dialog shown successfully");
                              } catch (e) {
                                print("Error showing dialog: $e");
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: data[index]['color'],
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        bottomLeft: Radius.circular(4),
                                      ),
                                    ),
                                    child: Icon(
                                      data[index]['icon'],
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      playlists[index].title,
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is CategoryJournalError) {
                      print(state.message);
                      return Center(child: Text(state.message));
                    } else {
                      return SizedBox(height: 0);
                    }
                  },
                ),
              ),

              // Recently played section
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Recently Played',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: recentlyPlayed.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: recentlyPlayed[index]['color'],
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(
                                    recentlyPlayed[index]['imageUrl']),
                                fit: BoxFit.cover,
                                opacity: 0.7,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                _getIconForType(recentlyPlayed[index]['type']),
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 150,
                            child: Text(
                              recentlyPlayed[index]['title'],
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              recentlyPlayed[index]['type'],
                              style: TextStyle(
                                color: AppColors.lightGray,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Daily notes section
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'My Journals',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<JournalsBloc, JournalsState>(
                  builder: (context, state) {
                if (state is JournalsLoading) {
                  return Center(child: const CircularProgressIndicator());
                } else if (state is JournalsLoaded) {
                  final data = state.journals;
                  if (data.isEmpty) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: AppColors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Kamu belum menambahkan journal',
                              style: TextStyle(
                                  color: AppColors.lightGray,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            // Hapus bagian leading
                            title: Text(
                              data[index].title,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  data[index].desc,
                                  style: TextStyle(
                                    color: AppColors.lightGray,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  data[index]
                                      .category
                                      .title, // Menampilkan category.title
                                  style: TextStyle(
                                    color: AppColors.lightGray.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  data[index].createdAt.toString(),
                                  style: TextStyle(
                                    color: AppColors.lightGray.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: AppColors.lightGray,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailJournalPage(
                                      id: data[index].id,
                                      title: data[index].title,
                                      desc: data[index].desc,
                                      categoryId: data[index].category.id,
                                      categoryTitle: data[index].category.title,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is JournalsError) {
                  print(state.message);
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: AppColors.white),
                    ),
                  );
                } else {
                  return Container();
                }
              }),

              const SizedBox(height: 80), // Space for bottom navigation bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isActive) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? AppColors.spotifyGreen : AppColors.surface,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        minimumSize: const Size(0, 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? AppColors.black : AppColors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Daily Motivation':
        return Icons.emoji_emotions_outlined;
      case 'Collection':
        return Icons.collections_bookmark_outlined;
      case 'Relaxation':
        return Icons.nightlight_round;
      case 'Self-improvement':
        return Icons.psychology_outlined;
      default:
        return Icons.note_outlined;
    }
  }
}
