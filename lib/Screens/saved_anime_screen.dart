import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import 'package:otaku_stream/Services/watch_later_cache.dart';

import '../Widgets/snack_bar.dart';
import 'anime_detail.dart';

class SavedAnimeScreen extends StatefulWidget {
  const SavedAnimeScreen({super.key});

  @override
  State<SavedAnimeScreen> createState() => _SavedAnimeScreenState();
}

class _SavedAnimeScreenState extends State<SavedAnimeScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _savedAnimes = [];

  @override
  void initState() {
    super.initState();
    _loadSavedAnimes();
  }

  void showCustomSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: CustomSnackBar(
        message: message,
        backgroundColor: Colors.black,
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _deleteAnimeById(String id) {
    setState(() {
      _savedAnimes.removeWhere((anime) => anime['id'] == id);
    });
    LaterAnimeCache.removeAnimeFromCache(id);
    showCustomSnackBar(context, "Anime removed from saved list!");
  }

  Future<void> _loadSavedAnimes() async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      final savedData = await LaterAnimeCache.getCachedAnime();

      final formattedData = savedData.entries.map((entry) {
        return {
          'poster': entry.value['poster'] ?? '',
          'name': entry.value['name'] ?? '',
          'studio': entry.value['studios'] ?? '',
          'id': entry.value['id'] ?? '',
        };
      }).toList();

      setState(() {
        _isLoading = false;
        _savedAnimes = formattedData;
      });
      showCustomSnackBar(context, "Yay! Your saved animes have been fetched successfully");
    } catch (e) {
      showCustomSnackBar(context, "Oops! We couldn’t fetch the animes. Please try again or report the issue.");
      setState(() {
        _isLoading = false;
        _savedAnimes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Saved Animes",
          style: GoogleFonts.poppins(
            color: Colors.orange,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 500,
          child: Lottie.asset('assets/animations/animation2.json'),
        ),
      )
          : _savedAnimes.isEmpty
           ? Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Oops! Nothing to show here.",
          style: GoogleFonts.poppins(
            color: Colors.orange,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 300,
          child: Lottie.asset('assets/animations/notFound.json'),
        ),
        Text(
          'Try adding some animes to your list!',
          style: GoogleFonts.poppins(
            color: Colors.orange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Display 2 cards per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7, // Adjust the height of the cards
          ),
          itemCount: _savedAnimes.length, // Total number of saved anime
          itemBuilder: (context, index) {
            final anime = _savedAnimes[index];
            return ListCard(
              imageUrl: anime['poster'] ?? '',
              title: anime['name'] ?? '',
              studio: anime['studio'] ?? '',
              id: anime['id'] ?? '',
              onDelete: _deleteAnimeById,
            ); // Pass the anime data to the card widget
          },
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String studio;
  final String id;
  final Function(String) onDelete;

  const ListCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.studio,
    required this.id,
    required this.onDelete
  });

  void showCustomSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: CustomSnackBar(
        message: message,
        backgroundColor: Colors.black,
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailPage(id: id,)));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 9.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 180,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Flexible(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            studio,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFFFA726),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Truncate text with ellipsis
                          ),
                        ),
                      ],
                    ),
                    // Add delete button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),
                            onPressed: () {
                              onDelete(id);
                            },
                          ),
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
}
