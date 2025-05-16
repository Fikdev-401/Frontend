import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/addJournals/bloc/add_journal_bloc.dart';
import 'package:flutter_frontend/bloc/journals/journals_bloc.dart';
import 'package:flutter_frontend/models/request/add_journal_request_model.dart';
import 'package:flutter_frontend/utils/session_manager.dart';

class EditJournalDialogs extends StatefulWidget {
  final int journalId;
  final int categoryId;
  final String categoryTitle;
  final String journalTitle;
  final String journalDesc;

  const EditJournalDialogs({
    Key? key,
    required this.journalId,
    required this.categoryId,
    required this.categoryTitle,
    required this.journalTitle,
    required this.journalDesc,
  }) : super(key: key);

  @override
  State<EditJournalDialogs> createState() => _EditJournalDialogState();
}

class _EditJournalDialogState extends State<EditJournalDialogs> {
  late TextEditingController titleController;
  late TextEditingController descController;
  late int selectedCategoryId;
  late int _userId;

  @override

  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.journalTitle);
    descController = TextEditingController(text: widget.journalDesc);
    selectedCategoryId = widget.categoryId;
    _loadUserId();
  }

  void _loadUserId() async {
  final id = await SessionManager().getUserId();
  setState(() {
    _userId = id ?? 0;
  });
}
  @override
  Widget build(BuildContext context) {
    // Spotify colors
    const spotifyGreen = Color(0xFF1DB954);
    const spotifyBlack = Color(0xFF121212);
    const spotifyDarkGray = Color(0xFF282828);
    const spotifyLightGray = Color(0xFFB3B3B3);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: spotifyBlack,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with gradient
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        spotifyGreen.withOpacity(0.8),
                        spotifyGreen.withOpacity(0.4),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menampilkan judul kategori di header
                      Text(
                        widget.categoryTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title field
                      const Text(
                        "TITLE",
                        style: TextStyle(
                          color: spotifyLightGray,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: titleController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "What do you want to achieve?",
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                          filled: true,
                          fillColor: spotifyDarkGray,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Description field
                      const Text(
                        "DESCRIPTION",
                        style: TextStyle(
                          color: spotifyLightGray,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: descController,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Add some details about your Journal...",
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                          filled: true,
                          fillColor: spotifyDarkGray,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Category info
                      Row(
                        children: [
                          const Icon(
                            Icons.category,
                            color: spotifyLightGray,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "CATEGORY",
                            style: TextStyle(
                              color: spotifyLightGray,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: spotifyDarkGray,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              widget
                                  .categoryTitle, // Menampilkan judul kategori
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Buttons
                      BlocConsumer<EditJournalBloc, AddJournalState>(
                        listener: (context, state) {
                          if (state is EditJournalLoaded) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Journal successfully edited!",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: spotifyGreen,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                            context.read<JournalsBloc>().add(LoadJournals(userId: _userId));
                          } else if (state is EditJournalError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Failed: ${state.message}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red.shade800,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: TextButton.styleFrom(
                                    foregroundColor: spotifyLightGray,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  child: const Text(
                                    "CANCEL",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: state is EditJournalLoading
                                      ? null
                                      : () {
                                          if (titleController.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Please enter a title"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }

                                          final requestBody =
                                              AddJournalRequestModel(
                                            title: titleController.text,
                                            desc: descController.text,
                                            categoryJournalId:
                                                selectedCategoryId,
                                          );
                                          context.read<EditJournalBloc>().add(
                                                EditJournal(requestBody, widget.journalId),
                                              );
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: spotifyGreen,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor:
                                        spotifyGreen.withOpacity(0.5),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  child: state is AddJournalLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          "SAVE",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
