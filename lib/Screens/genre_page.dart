import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:otaku_stream/Providers/genre_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'anime_detail.dart';

class GenrePage extends StatefulWidget {
  final String genre;
  const GenrePage({super.key, required this.genre});

  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
              widget.genre,
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

      body: genreProvider.serverData == null || isLoading
          ? Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 500,
          child: Lottie.asset('assets/animations/animation2.json'),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.61,
          ),
          itemCount: genreProvider.serverData!.data!.animes!.length,
          itemBuilder: (context, index) {
            // Vary the height for staggered effect
            double height = index.isEven ? 300 : 500;

            // Add left-right padding for the offset effect
            return Padding(
              padding: EdgeInsets.only(
                left: index % 2 == 0 ? 20.0 : 0.0,
                right: index % 2 != 0 ? 20.0 : 0.0,
              ),
              child: SizedBox(
                height: height,
                child: MovieCard(
                  title: genreProvider.serverData!.data!.animes![index].name ?? "",
                  year: genreProvider.serverData!.data!.animes![index].type!.name,
                  image: genreProvider.serverData!.data!.animes![index].poster ?? "",
                  id: genreProvider.serverData!.data!.animes![index].id ?? "",
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String year;
  final String image;
  final String id;

  const MovieCard({
    super.key,
    required this.title,
    required this.year,
    required this.image,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailPage(id: id)));
      },
      child: Stack(
        children: [
          // Main card with animations
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutBack,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(3, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Enlarged image section
                  Stack(
                    children: [
                      Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 332,
                      ),
                      // Transparent overlay shimmer effect
                      Positioned.fill(
                        child: AnimatedOpacity(
                          duration: const Duration(seconds: 2),
                          opacity: 0.4,
                          child: Container(
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.6),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                year,
                                style: TextStyle(
                                  color: Colors.orange.withOpacity(0.8),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

