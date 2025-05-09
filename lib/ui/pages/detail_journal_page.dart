import 'dart:io';
import 'dart:ui' as ui;

import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class DetailJournalPage extends StatelessWidget {
  final int id;
  final String title;
  final String desc;
  final int categoryId;
  final String categoryTitle;

  DetailJournalPage({
    super.key,
    required this.id,
    required this.title,
    required this.desc,
    required this.categoryId,
    required this.categoryTitle,
  });

  final GlobalKey _shareKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF121212);
    const surfaceColor = Color(0xFF282828);
    const primaryColor = Color(0xFF1DB954);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFFB3B3B3);

    return Scaffold(
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
                                  Icons.book,
                                  size: 80,
                                  color: primaryColor.withOpacity(0.8),
                                ),
                              ),
                              Text(
                                title,
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
                                      categoryTitle,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '• Journal #$id',
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
                                    desc,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSpotifyButton(
                    context,
                    icon: Icons.edit_outlined,
                    label: 'Edit',
                    onTap: () {
                      print('Edit journal with ID: $id');
                    },
                  ),
                  _buildSpotifyButton(
                    context,
                    icon: Icons.delete_outline,
                    label: 'Delete',
                    onTap: () {
                      _showDeleteConfirmation(context);
                    },
                    isDestructive: true,
                  ),
                  _buildSpotifyButton(
                    context,
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: () {
                      _shareAsImage(context, _shareKey, id.toString());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpotifyButton(
    BuildContext context, {
    required IconData icon,
    required String label,
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
            const SizedBox(width: 8),
            Text(
              label,
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

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF282828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Journal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to delete this journal? This action cannot be undone.',
          style: TextStyle(color: Color(0xFFB3B3B3), fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(letterSpacing: 1)),
          ),
          TextButton(
            onPressed: () {
              print('Deleting journal with ID: $id');
              Navigator.pop(context);
              Navigator.pop(context);
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

      final file =
          File('${directory.path}/journal_$id.png'); // Menyimpan dengan .png
      await file.writeAsBytes(pngBytes);

      Navigator.pop(context); // Tutup loading dialog
      await Share.shareXFiles([XFile(file.path)],
          text: 'Test'); // Bagikan gambar
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share image: $e')),
      );
    }
  }
}
