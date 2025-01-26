import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otaku_stream/Backend/Api/api_service.dart';
import 'package:otaku_stream/Providers/genre_provider.dart';
import 'package:otaku_stream/Screens/anime_detail.dart';
import 'package:otaku_stream/Screens/genre_page.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  final List<String> genres = [
    "Action", "Adventure", "Cars", "Comedy", "Dementia", "Demons", "Drama", "Ecchi", "Fantasy", "Game", "Harem", "Historical", "Horror", "Isekai", "Josei", "Kids", "Magic", "Martial Arts", "Mecha", "Military", "Music", "Mystery", "Parody", "Police", "Psychological", "Romance", "Samurai", "School", "Sci-Fi", "Seinen", "Shoujo", "Shoujo Ai", "Shounen", "Shounen Ai", "Slice of Life", "Space", "Sports", "Super Power", "Supernatural", "Thriller", "Vampire",
  ];
  bool showAllGenres = false;
  bool isSearching = false;
  String searchQuery = '';
  List<dynamic> searchResults = [];
  int currentPage = 1;
  bool hasNextPage = false;
  bool isLoading = false;

  Future<void> fetchSearchResults(int currentPage) async {
    if (searchQuery.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final data = await ApiService.fetchSearchAnimes(searchQuery, currentPage);

      setState(() {
        searchResults.addAll(data['data']['animes']);
        hasNextPage = data['data']['hasNextPage'];
      });


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error fetching search results'),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildSearchResults(String query) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.length + (hasNextPage ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == searchResults.length && hasNextPage) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage++;
                        });
                        fetchSearchResults(currentPage);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        'Show More',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                    ),
                  ),
                );
              }

              final anime = searchResults[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade600,Colors.black54, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 170.0), // Added constraints
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              bottomLeft: Radius.circular(16.0),
                            ),
                            child: Image.network(
                              anime['poster'],
                              fit: BoxFit.cover,
                              width: 140, // Explicit width
                              height: 170, // Explicit height
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.orange,
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    anime['name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize:18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '${anime['type']} • ${anime['rating']} • ${anime['episodes']['sub']} || ${anime['episodes']['dub']}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 40,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            anime['type'],
                            style: GoogleFonts.poppins(
                              color: Colors.orange,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MovieDetailPage(id: anime['id'])),
                                  (route) => route.isFirst, // Keep the first (home) route in the stack
                            );

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          ),
                          icon: const Icon(Icons.play_arrow, color: Colors.black),
                          label: Text(
                            'Watch Now',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 80,),
        if (isLoading)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(color: Colors.orange),
          ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.explore, color: Color(0xFFFFA726), size: 28),
            const SizedBox(width: 8),
            Text(
              isSearching ? 'Results' : 'Explore',
              style: GoogleFonts.poppins(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: isSearching
            ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFA726)),
          onPressed: () {
            setState(() {
              isSearching = false;
              searchResults.clear();
              currentPage = 1;
            });
          },
        )
            : null,
      ),
      body: isSearching
          ? buildSearchResults(searchQuery)
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFFFA726)),
                  hintText: 'Search for anime...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  setState(() {
                    searchQuery = value;
                    isSearching = true;
                    //searchResults.clear();
                    //currentPage = 1;
                  });
                  fetchSearchResults(currentPage);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Genres',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAllGenres = !showAllGenres;
                      });
                    },
                    child: Text(
                      showAllGenres ? 'Show Less' : 'Show More',
                      style: GoogleFonts.poppins(color: const Color(0xFFFFA726)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 270 ,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                child: GridView.builder(
                  key: ValueKey(showAllGenres),
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: showAllGenres ? genres.length : 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        final genreProvider = Provider.of<GenreProvider>(context, listen: false);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => GenrePage(genre: genres[index])));
                        await genreProvider.fetchAndCacheGenres(genres[index].toLowerCase(), 1);

                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 1.5),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text(
                            genres[index],
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFFA726),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Featured Content',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFA726),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: PageView.builder(
                itemCount: 5, // Example count for featured content
                controller: PageController(viewportFraction: 0.85),
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Content ${index + 1}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }
}
