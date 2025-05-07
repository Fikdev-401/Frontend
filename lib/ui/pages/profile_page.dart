import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/auth/login/login_bloc.dart';
import 'package:flutter_frontend/core/constants/colors.dart';
import 'package:flutter_frontend/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user data
    final Map<String, dynamic> userData = {
      'name': 'Fikdev',
      'username': '@dev',
      'joinDate': 'developer since January 2023',
      'avatar': '/placeholder.svg?height=100&width=100',
      'premium': true,
      'stats': {
        'completedGoals': 24,
        'currentGoals': 5,
        'streak': 16,
      },
      'achievements': [
        {
          'name': 'Early Bird',
          'description': 'Complete 5 goals before 9 AM',
          'icon': Icons.wb_sunny,
          'color': Colors.amber,
          'earned': true,
        },
        {
          'name': 'Consistent',
          'description': 'Maintain a 7-day streak',
          'icon': Icons.calendar_today,
          'color': Colors.green,
          'earned': true,
        },
        {
          'name': 'Overachiever',
          'description': 'Complete 20 goals in a month',
          'icon': Icons.emoji_events,
          'color': Colors.purple,
          'earned': true,
        },
        {
          'name': 'Night Owl',
          'description': 'Complete 5 goals after 10 PM',
          'icon': Icons.nightlight_round,
          'color': Colors.indigo,
          'earned': false,
        },
      ],
      'recentActivity': [
        {
          'action': 'Completed goal',
          'title': 'Read 30 minutes',
          'category': 'Learning',
          'time': '2 hours ago',
          'icon': Icons.book,
          'color': Colors.blue,
        },
        {
          'action': 'Created new goal',
          'title': 'Morning meditation',
          'category': 'Health',
          'time': '1 day ago',
          'icon': Icons.self_improvement,
          'color': Colors.purple,
        },
        {
          'action': 'Achieved streak',
          'title': '14 days streak',
          'category': 'Achievement',
          'time': '2 days ago',
          'icon': Icons.local_fire_department,
          'color': Colors.orange,
        },
      ],
    };

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Spotify dark background
      body: CustomScrollView(
        slivers: [
          // Profile Header
          SliverAppBar(
            expandedHeight: 210,
            pinned: true,
            backgroundColor: const Color(0xFF121212),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // Profile picture with premium badge
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[800],
                              backgroundImage: NetworkImage(userData['avatar']),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white54,
                              ),
                            ),
                            if (userData['premium'])
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1DB954),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'PREMIUM',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // User name and info
                        Text(
                          userData['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          userData['username'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Stats Cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData['joinDate'],
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildStatCard(
                        'Completed',
                        userData['stats']['completedGoals'].toString(),
                        Icons.check_circle,
                        const Color(0xFF1DB954),
                      ),
                      const SizedBox(width: 12),
                      _buildStatCard(
                        'In Progress',
                        userData['stats']['currentGoals'].toString(),
                        Icons.trending_up,
                        Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      _buildStatCard(
                        'Day Streak',
                        userData['stats']['streak'].toString(),
                        Icons.local_fire_department,
                        Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Achievements Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ACHIEVEMENTS',
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
                itemCount: userData['achievements'].length,
                itemBuilder: (context, index) {
                  final achievement = userData['achievements'][index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF282828), // Spotify card color
                        borderRadius: BorderRadius.circular(8),
                        border: achievement['earned']
                            ? Border.all(color: achievement['color'], width: 2)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: achievement['earned']
                                  ? achievement['color']
                                  : Colors.grey[700],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              achievement['icon'],
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            achievement['name'],
                            style: TextStyle(
                              color: achievement['earned'] ? Colors.white : Colors.grey[400],
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              achievement['description'],
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Recent Activity
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'RECENT ACTIVITY',
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
                final activity = userData['recentActivity'][index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
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
                            color: activity['color'].withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            activity['icon'],
                            color: activity['color'],
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity['action'],
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                activity['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${activity['category']} • ${activity['time']}',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
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
              childCount: userData['recentActivity'].length,
            ),
          ),

          // Settings Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: const Text(
                'SETTINGS',
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                children: [
                  _buildSettingItem(
                    'Account',
                    'Manage your account details',
                    Icons.person_outline,
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    'Notifications',
                    'Configure your notifications',
                    Icons.notifications_none,
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    'Appearance',
                    'Dark mode and theme settings',
                    Icons.palette_outlined,
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    'Privacy',
                    'Manage your privacy settings',
                    Icons.lock_outline,
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    'Help & Support',
                    'Get help or contact support',
                    Icons.help_outline,
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LogoutSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 
                              MyRoute.login.name, 
                              (_) => false);
                        }
                      },
                      child: IconButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(Logout());
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF282828), // Spotify card color
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, String subtitle, IconData icon, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
