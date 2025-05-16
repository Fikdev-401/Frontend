import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/addGoals/add_goal_bloc.dart';
import 'package:flutter_frontend/bloc/addJournals/bloc/add_journal_bloc.dart';
import 'package:flutter_frontend/bloc/goals/goals_bloc.dart';
import 'package:flutter_frontend/bloc/goalsCategory/category_goal_bloc.dart';
import 'package:flutter_frontend/bloc/journalsCategory/category_journal_bloc.dart';
import 'package:flutter_frontend/models/request/add_goal_request_model.dart';
import 'package:flutter_frontend/models/request/add_journal_request_model.dart';
import 'package:flutter_frontend/utils/session_manager.dart';

class AddGoalPage extends StatefulWidget {
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  // Form controllers
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  // Selected category
  int? _selectedCategoryId;
  String _selectedCategoryTitle = 'Select Category';
  late int id;

  void getUserId() async {
    final session = SessionManager();
    id = await session.getUserId() ?? 0;
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF282828),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Category',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CategoryGoalBloc, CategoryGoalState>(
                builder: (context, state) {
                  if (state is CategoryGoalLoading)
                    return const Center(child: CircularProgressIndicator());
                  else if (state is CategoryGoalLoaded)
                    return ListView.builder(
                      itemCount: state.dataCategoryGoals.length,
                      itemBuilder: (context, index) {
                        final category = state.dataCategoryGoals[index];
                        return ListTile(
                          title: Text(
                            category.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1DB954).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.category,
                              color: Color(0xFF1DB954),
                              size: 14,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedCategoryId = category.id;
                              _selectedCategoryTitle = category.title;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  else if (state is CategoryGoalError)
                    return const Center(child: Text('Error'));
                  else {
                    return const Center(child: Text('Error'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Spotify-inspired colors
    const backgroundColor = Color(0xFF121212);
    const surfaceColor = Color(0xFF282828);
    const primaryColor = Color(0xFF1DB954);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFFB3B3B3);

    return BlocListener<AddJournalBloc, AddJournalState>(
        listener: (context, state) {
          if (state is AddJournalLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Journal added successfully'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is AddJournalError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'New Journal',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: Stack(
            children: [
              // Gradient background
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      HSLColor.fromAHSL(1.0, 140, 0.7, 0.5).toColor(),
                      backgroundColor,
                    ],
                  ),
                ),
              ),

              // Form content
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Journal icon
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 30, top: 10),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.book,
                              size: 40,
                              color: primaryColor.withOpacity(0.8),
                            ),
                          ),
                        ),

                        // Form title
                        const Text(
                          'Create New Goal',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 30),

                        // Category selector
                        const Text(
                          'Category',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _showCategoryPicker,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _selectedCategoryId != null
                                    ? primaryColor.withOpacity(0.3)
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    if (_selectedCategoryId != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          _selectedCategoryTitle,
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      )
                                    else
                                      Text(
                                        _selectedCategoryTitle,
                                        style: const TextStyle(
                                          color: textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: secondaryTextColor,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Title input
                        const Text(
                          'Title',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        BlocConsumer<AddGoalBloc, AddGoalState>(
                          listener: (context, state) {
                            if (state is AddGoalSuccess) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Goal added successfully'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              context
                                  .read<GoalsBloc>()
                                  .add(LoadGoals(userId: id));
                            } else if (state is AddGoalError) {
                              _showErrorSnackBar(state.message);
                            }
                          },
                          builder: (context, state) {
                            return Container(
                              decoration: BoxDecoration(
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                controller: _titleController,
                                style: const TextStyle(color: textColor),
                                decoration: const InputDecoration(
                                  hintText: 'Enter journal title',
                                  hintStyle:
                                      TextStyle(color: secondaryTextColor),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        // Description input
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _descController,
                            style: const TextStyle(color: textColor),
                            maxLines: 8,
                            decoration: const InputDecoration(
                              hintText: 'Write your journal entry here...',
                              hintStyle: TextStyle(color: secondaryTextColor),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

              // Save button at the bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        backgroundColor,
                        backgroundColor.withOpacity(0.9),
                        backgroundColor.withOpacity(0),
                      ],
                      stops: const [0.7, 0.9, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: GestureDetector(
                    onTap: () {
                      final requestBody = AddGoalRequestModel(
                        title: _titleController.text,
                        desc: _descController.text,
                        categoryGoalId: _selectedCategoryId,
                        status: 'belum',
                      );
                      context.read<AddGoalBloc>().add(
                            AddGoal(requestBody),
                          );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'SAVE JOURNAL',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
