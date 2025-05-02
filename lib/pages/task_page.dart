import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for goal categories
    final List<Map<String, dynamic>> goalCategories = [
      {
        'title': 'Daily Habits',
        'count': 5,
        'color': Colors.green,
        'icon': Icons.repeat,
      },
      {
        'title': 'Career Growth',
        'count': 3,
        'color': Colors.purple,
        'icon': Icons.work,
      },
      {
        'title': 'Learning',
        'count': 4,
        'color': Colors.blue,
        'icon': Icons.school,
      },
      {
        'title': 'Health',
        'count': 2,
        'color': Colors.red,
        'icon': Icons.favorite,
      },
      {
        'title': 'Finance',
        'count': 3,
        'color': Colors.amber,
        'icon': Icons.attach_money,
      },
    ];

    // Mock data for in-progress goals
    final List<Map<String, dynamic>> inProgressGoals = [
      {
        'title': 'Read 20 books this year',
        'category': 'Learning',
        'progress': 0.35,
        'detail': '7/20 books',
        'color': Colors.blue,
        'icon': Icons.menu_book,
      },
      {
        'title': 'Exercise 3 times a week',
        'category': 'Health',
        'progress': 0.67,
        'detail': '2/3 this week',
        'color': Colors.red,
        'icon': Icons.fitness_center,
      },
      {
        'title': 'Learn Flutter development',
        'category': 'Career Growth',
        'progress': 0.5,
        'detail': '50% completed',
        'color': Colors.purple,
        'icon': Icons.code,
      },
    ];

    // Mock data for completed goals
    final List<Map<String, dynamic>> completedGoals = [
      {
        'title': 'Complete Flutter basics course',
        'category': 'Learning',
        'completedDate': '2 days ago',
        'color': Colors.blue,
        'icon': Icons.check_circle,
      },
      {
        'title': 'Run 5km without stopping',
        'category': 'Health',
        'completedDate': '1 week ago',
        'color': Colors.red,
        'icon': Icons.directions_run,
      },
    ];

    // Mock data for suggested goals
    final List<Map<String, dynamic>> suggestedGoals = [
      {
        'title': 'Learn a new language',
        'category': 'Learning',
        'description': 'Expand your horizons',
        'color': Colors.blue,
        'icon': Icons.language,
      },
      {
        'title': 'Meditate daily',
        'category': 'Health',
        'description': 'Improve mental wellbeing',
        'color': Colors.red,
        'icon': Icons.self_improvement,
      },
      {
        'title': 'Create a budget plan',
        'category': 'Finance',
        'description': 'Better financial control',
        'color': Colors.amber,
        'icon': Icons.account_balance_wallet,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Spotify dark background
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with greeting
            SliverAppBar(
              backgroundColor: const Color(0xFF121212),
              expandedHeight: 120,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Goals',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Keep pushing forward!',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Goal Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'GOAL CATEGORIES',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF1DB954), // Spotify green
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: goalCategories.length,
                  itemBuilder: (context, index) {
                    final category = goalCategories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFF282828), // Spotify card color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: category['color'].withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  category['icon'],
                                  color: category['color'],
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                category['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${category['count']} goals',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // In Progress Goals
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'IN PROGRESS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF1DB954), // Spotify green
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final goal = inProgressGoals[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF282828), // Spotify card color
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: goal['color'].withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    goal['icon'],
                                    color: goal['color'],
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        goal['title'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        goal['category'],
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearPercentIndicator(
                                    lineHeight: 8.0,
                                    percent: goal['progress'],
                                    backgroundColor: Colors.grey[800],
                                    progressColor: const Color(0xFF1DB954), // Spotify green
                                    barRadius: const Radius.circular(4),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  goal['detail'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: inProgressGoals.length,
              ),
            ),

            // Completed Goals
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'COMPLETED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF1DB954), // Spotify green
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final goal = completedGoals[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF282828), // Spotify card color
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: goal['color'].withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                goal['icon'],
                                color: goal['color'],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    goal['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${goal['category']} • Completed ${goal['completedDate']}',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF1DB954), // Spotify green
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: completedGoals.length,
              ),
            ),

            // Suggested Goals
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: const Text(
                  'SUGGESTED FOR YOU',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: suggestedGoals.length,
                  itemBuilder: (context, index) {
                    final goal = suggestedGoals[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16,),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 160,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF282828), // Spotify card color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: goal['color'].withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  goal['icon'],
                                  color: goal['color'],
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                goal['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                goal['category'],
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                goal['description'],
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 80),
            ),
          ],
        ),
      ),
    );
  }
}
