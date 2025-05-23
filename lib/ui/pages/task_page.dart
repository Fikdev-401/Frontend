import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/goals/goals_bloc.dart';
import 'package:flutter_frontend/bloc/goalsCategory/category_goal_bloc.dart';
import 'package:flutter_frontend/core/constants/colors.dart';
import 'package:flutter_frontend/ui/dialogs/add_goal_dialogs.dart';
import 'package:flutter_frontend/ui/pages/detail_goal_page.dart';
import 'package:flutter_frontend/utils/session_manager.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await SessionManager().getUserId();
    setState(() {
      userId = id;
    });

    // fetch data goals berdasarkan user
    context.read<GoalsBloc>().add(LoadGoals(userId: id ?? 0));
    context.read<CategoryGoalBloc>().add(LoadCategoryGoal());
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for goal categories
    final List<Map<String, dynamic>> tambahanCategoryGoal = [
      {
        'color': Colors.green,
        'icon': Icons.repeat,
      },
      {
        'color': Colors.purple,
        'icon': Icons.work,
      },
      {
        'color': Colors.blue,
        'icon': Icons.school,
      },
      {
        'color': Colors.red,
        'icon': Icons.favorite,
      },
      {
        'color': Colors.amber,
        'icon': Icons.attach_money,
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
              child: BlocBuilder<CategoryGoalBloc, CategoryGoalState>(
                builder: (context, state) {
                  if (state is CategoryGoalLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CategoryGoalLoaded) {
                    final goalCategories = state.dataCategoryGoals;
                    return SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: goalCategories.length,
                        itemBuilder: (context, index) {
                          final category = goalCategories[index];
                          final tambahan = tambahanCategoryGoal[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AddGoalDialog(
                                    categoryId: category.id,
                                    categoryTitle:
                                        category.title, // <-- kirim id-nya
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xFF282828), // Spotify card color
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: tambahan['color'],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        tambahan['icon'],
                                        color: AppColors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      category.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is CategoryGoalError) {
                    print(state.message);
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
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
            SliverToBoxAdapter(
              child: BlocBuilder<GoalsBloc, GoalsState>(
                builder: (context, state) {
                  if (state is GoalsLoading) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF1DB954), // Spotify green
                        ),
                      ),
                    );
                  } else if (state is GoalsLoaded) {
                    final data = state.goals;
                    final goalInProgress = data
                        .where((goal) => goal.status.name == 'proses')
                        .toList();
                    if (goalInProgress.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'ga ada goal yang started',
                              style: TextStyle(
                                color: AppColors.lightGray,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return SizedBox(
                      height: goalInProgress.length * 130.0,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: goalInProgress.length,
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
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                title: Text(
                                  goalInProgress[index].title,
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
                                      goalInProgress[index].desc,
                                      style: const TextStyle(
                                        color: AppColors.lightGray,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Category : " +
                                          goalInProgress[index].category.title,
                                      style: TextStyle(
                                        color: AppColors.lightGray
                                            .withOpacity(0.7),
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
                                    // Show options menu
                                    final goal = goalInProgress[index];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailGoalPage(
                                          id: goal.id,
                                          title: goal.title,
                                          status: goal.status.name,
                                          desc: goal.desc,
                                          categoryId: goal.category.id,
                                          categoryTitle: goal.category.title,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is GoalsError) {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: AppColors.white),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
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
                      'BELUM START',
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
              child: BlocBuilder<GoalsBloc, GoalsState>(
                builder: (context, state) {
                  if (state is GoalsLoading) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF1DB954), // Spotify green
                        ),
                      ),
                    );
                  } else if (state is GoalsLoaded) {
                    final data = state.goals;
                    final goalNotStart = data
                        .where((goal) => goal.status.name == 'belum')
                        .toList();
                    if (goalNotStart.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'ga ada goal yang belum di mulai',
                              style: TextStyle(
                                color: AppColors.lightGray,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return SizedBox(
                      height: goalNotStart.length * 130.0,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: goalNotStart.length,
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
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                title: Text(
                                  goalNotStart[index].title,
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
                                      goalNotStart[index].desc,
                                      style: const TextStyle(
                                        color: AppColors.lightGray,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Category : " +
                                          goalNotStart[index].category.title,
                                      style: TextStyle(
                                        color: AppColors.lightGray
                                            .withOpacity(0.7),
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
                                    // Show options menu
                                    final goal = goalNotStart[index];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailGoalPage(
                                          id: goal.id,
                                          title: goal.title,
                                          status: goal.status.name,
                                          desc: goal.desc,
                                          categoryId: goal.category.id,
                                          categoryTitle: goal.category.title,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is GoalsError) {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: AppColors.white),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),

            // Suggested Goals
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: const Text(
                  'TELAH SELESAI',
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
                child: BlocBuilder<GoalsBloc, GoalsState>(
                  builder: (context, state) {
                    if (state is GoalsLoaded) {
                      final data = state.goals;
                      final goalCompleted = data
                          .where((goal) => goal.status.name == 'selesai')
                          .toList();
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: goalCompleted.length,
                        itemBuilder: (context, index) {
                          final datas = goalCompleted[index];
                          Map<String, dynamic> getIconWithCategory (String category){
                            if(category == 'Daily Habits'){
                              return tambahanCategoryGoal[0];
                            } else if (category == 'Career Growth'){
                              return tambahanCategoryGoal[1];
                            } else if (category == 'Learning'){
                              return tambahanCategoryGoal[2];
                            } else if (category == 'Health'){
                              return tambahanCategoryGoal[3];
                            } else if (category == 'Finance'){
                              return tambahanCategoryGoal[4];
                            } else {
                              return tambahanCategoryGoal[0];
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: 16,
                            ),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 160,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xFF282828), // Spotify card color
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: getIconWithCategory(datas.category.title)['color'].withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        getIconWithCategory(datas.category.title)['icon'],
                                        color: getIconWithCategory(datas.category.title)['color'],
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      datas.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      datas.category.title,
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      datas.desc,
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
                      );
                    } else if (state is GoalsError) {
                      print(state.message);
                      return SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(state.message),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
