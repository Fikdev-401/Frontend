import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/goals/goals_bloc.dart';
import 'package:flutter_frontend/ui/dialogs/edit_goal_dialogs.dart';
import 'package:flutter_frontend/utils/session_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class DetailGoalPage extends StatefulWidget {
  final int id;
  final String title;
  final String desc;
  final int categoryId;
  final String categoryTitle;

  DetailGoalPage({
    super.key,
    required this.id,
    required this.title,
    required this.desc,
    required this.categoryId,
    required this.categoryTitle,
  });

  @override
  State<DetailGoalPage> createState() => _DetailGoalPageState();
}

class _DetailGoalPageState extends State<DetailGoalPage> {
  final GlobalKey _shareKey = GlobalKey();

  late int userId;

  void getUserId() async {
    final session = SessionManager();
    userId = await session.getUserId() ?? 0;
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF121212);
    const surfaceColor = Color(0xFF282828);
    const primaryColor = Color(0xFF1DB954);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFFB3B3B3);

    return BlocListener<DeleteGoalBloc, GoalsState>(
      listener: (context, state) {
        if (state is DeleteGoalSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Goal berhasil dihapus')),
          );
          Navigator.pop(context);
          context.read<GoalsBloc>().add(LoadGoals(userId: userId));
        } else if (state is DeleteGoalError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus goal')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined, color: Colors.white),
              onPressed: () {
                _shareAsImage(context, _shareKey, widget.id.toString());
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RepaintBoundary(
                          key: _shareKey,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  margin: const EdgeInsets.only(bottom: 30),
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
                                    Icons.flag,
                                    size: 80,
                                    color: primaryColor.withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        widget.categoryTitle,
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '• Goal #${widget.id}',
                                      style: TextStyle(
                                        color: secondaryTextColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.desc,
                                      style: const TextStyle(
                                        color: textColor,
                                        fontSize: 16,
                                        height: 1.6,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 100),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Start button on the left
                    _buildStartButton(context),

                    // Edit and Delete buttons grouped on the right
                    Row(
                      children: [
                        _buildActionButton(
                          context,
                          icon: Icons.edit_outlined,
                          onTap: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (context) => EditGoalDialogs(
                                goalId: widget.id,
                                categoryId: widget.categoryId,
                                categoryTitle: widget.categoryTitle,
                                goalTitle: widget.title,
                                goalDesc: widget.desc,
                              ),
                            );
                            if (result == true) {
                              context
                                  .read<GoalsBloc>()
                                  .add(LoadGoals(userId: widget.id));
                            }
                            print('Edit goal with ID: ${widget.id}');
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildActionButton(
                          context,
                          icon: Icons.delete_outline,
                          onTap: () {
                            _showDeleteConfirmation(context, widget.id);
                          },
                          isDestructive: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Starting goal with ID: ${widget.id}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1DB954),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1DB954).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 130),
            const Text(
              'START',
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
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    String? label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final Color color =
        isDestructive ? const Color(0xFFE91429) : const Color(0xFF1DB954);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            Text(
              label ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, int id) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF282828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Goal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to delete this goal? This action cannot be undone.',
          style: TextStyle(color: Color(0xFFB3B3B3), fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL', style: TextStyle(letterSpacing: 1)),
          ),
          TextButton(
            onPressed: () {
              context.read<DeleteGoalBloc>().add(DeleteGoal(id: id));
              Navigator.pop(context, true);
            },
            child: const Text(
              'DELETE',
              style: TextStyle(
                color: Color(0xFFE91429),
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareAsImage(
      BuildContext context, GlobalKey _shareKey, String id) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0xFF1DB954)),
      ),
    );

    try {
      final RenderRepaintBoundary boundary =
          _shareKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(
          pixelRatio: 3.0); // Menggunakan pixelRatio lebih rendah
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Tentukan path untuk menyimpan gambar
      final directory = Directory('C:/Users/USer/Pictures/Saved Pictures');
      if (!(await directory.exists())) {
        await directory.create(
            recursive: true); // Membuat direktori jika belum ada
      }

      final file = File('${directory.path}/goal_$id.png');
      await file.writeAsBytes(pngBytes);

      Navigator.pop(context); // Tutup loading dialog
      await Share.shareXFiles([XFile(file.path)],
          text: 'Check out my goal: ${widget.title}'); // Bagikan gambar
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share image: $e')),
      );
    }
  }
}
