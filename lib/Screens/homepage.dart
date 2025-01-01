import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutter/material.dart';
import 'package:otaku_stream/Screens/anime_detail.dart';
import 'package:otaku_stream/Widgets/hamburger.dart';
import 'package:provider/provider.dart';
import '../Providers/home_provider.dart';

class AnimeHomeScreen extends StatefulWidget {

  const AnimeHomeScreen({super.key});

  @override
  State<AnimeHomeScreen> createState() => _AnimeHomeScreenState();
}

class _AnimeHomeScreenState extends State<AnimeHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final animeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (animeProvider.homeAnime == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        animeProvider.fetchHomeAnime();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final animeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AnimeAppMenu(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 33,),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0, bottom: 10), // Add spacing on the right
            child: CircleAvatar(
              radius: 27,
              backgroundImage: NetworkImage(
                "https://via.placeholder.com/150",
              ),
            ),
          ),
        ],
      ),
      body: animeProvider.homeAnime == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16,),

            // Carousel Section using Spotlight Animes
            SizedBox(
              height: 350,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  final spotlightAnime = animeProvider
                      .homeAnime!.data.spotlightAnimes[index];
                  return AnimeCard(
                    id: spotlightAnime.id,
                    title: spotlightAnime.name,
                    imageUrl: spotlightAnime.poster,
                    description: spotlightAnime.description,
                  );
                  },
                itemCount:
                animeProvider.homeAnime!.data.spotlightAnimes
                    .length,
                viewportFraction: 0.8,
                scale: 0.9,
                autoplay: true,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: Colors.orange,
                    size: 8.0,
                    activeSize: 12.0,
                  ),
                  margin: EdgeInsets.only(top: 7),
                ),
              ),
            ),

            // Popular Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    height: 300, // Adjust height based on card size
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: animeProvider
                          .homeAnime!.data.trendingAnimes.length,
                      itemBuilder: (context, index) {
                        final popularanime = animeProvider
                            .homeAnime!.data.trendingAnimes[index];
                        return ListCard(
                          imageUrl: popularanime.poster,
                          title: popularanime.name,
                          genres: popularanime.rank.toString(),
                          id: popularanime.id,
                        );
                      },
                    ),
                  )

                ],
              ),
            ),

            // Top Airing Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Top Airing",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300, // Adjust height based on card size
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: animeProvider
                          .homeAnime!.data.topAiringAnimes.length,
                      itemBuilder: (context, index) {
                        final topAiringAnime = animeProvider
                            .homeAnime!.data.topAiringAnimes[index];
                        return ListCard(
                          imageUrl:  topAiringAnime.poster,
                          title: topAiringAnime.name,
                          genres: " SUB: ${topAiringAnime.episodes?.sub ?? 0} || DUB: ${topAiringAnime.episodes?.dub ?? 0}",
                          id: topAiringAnime.id,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 60,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryTab({super.key,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: isSelected ? Colors.orange : Colors.white54,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 16,
      ),
    );
  }
}

class AnimeCard extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;

  const AnimeCard({super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailPage(id: id,)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 1, // Restrict to 1 line
                          overflow: TextOverflow.ellipsis, // Show ellipsis if the text overflows
                        ),
                        Text(
                          description,
                          style: const TextStyle(
                            color: Color(0xFFFFA726),
                            fontSize: 14,
                          ),
                          maxLines: 2, // Restrict to 2 lines
                          overflow: TextOverflow.ellipsis, // Show ellipsis if the text overflows
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
    );
  }
}

class ListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String genres;
  final String id;

  const ListCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.genres,
    required this.id
  });

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
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         title,
            //         style: const TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white,
            //         ),
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //       const SizedBox(height: 8),
            //       Text(
            //         genres,
            //         style: const TextStyle(
            //           fontSize: 12,
            //           color: Color(0xFFFFA726),
            //         ),
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //       const SizedBox(height: 8),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Truncate text with ellipsis
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Text(
                        genres,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFFA726),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Truncate text with ellipsis
                      ),
                    ),
                    const SizedBox(height: 8),
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
