import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/detail_provider.dart';

class MovieDetailPage extends StatefulWidget {
  final String id;
  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      detailProvider.fetchAnimeDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {

    final detailProvider = Provider.of<DetailProvider>(context);

    return Scaffold(
      body: detailProvider.animeDetail == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
        height: MediaQuery.of(context).size.height, // Full screen height
        child: Column(
          children: [
            // Upper Half with Poster and Gradient
            Stack(
              children: [
                // Poster Image
                Container(
                  height: MediaQuery.of(context).size.height * 0.35, // Half of the screen height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(detailProvider.animeDetail!.data.anime?.info?.poster ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Lower Half Components
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.black87, Colors.orange],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40), // Top spacing
                        // Movie Title and Info
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         detailProvider.animeDetail!.data.anime.info.name,
                        //         style: const TextStyle(
                        //           fontSize: 32,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 10),
                        //     Text(
                        //       detailProvider.animeDetail!.data.anime.moreInfo.genres.join(', '),
                        //       style: const TextStyle(
                        //         fontSize: 16,
                        //         color: Colors.white70,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detailProvider.animeDetail!.data.anime?.info?.name ?? "",
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis, // Ensures the name does not overflow
                            ),
                            const SizedBox(height: 7),
                            Text(
                              detailProvider.animeDetail!.data.anime?.moreInfo?.studios ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),


                        const SizedBox(height: 14),
                        SizedBox(
                          height: 30, // Restrict height to make it more compact
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: detailProvider.animeDetail!.data.anime?.moreInfo?.genres!.length,
                            itemBuilder: (context, index) {
                              final genre = detailProvider.animeDetail!.data.anime?.moreInfo?.genres![index];
                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white24, // Background color for genres
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  genre ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 16),
                        // Rating Section
                        // Row(
                        //   children: [
                        //     Row(
                        //       children: List.generate(
                        //         detailProvider.animeDetail!.data.anime.moreInfo..round(),
                        //             (index) => const Icon(
                        //           Icons.star,
                        //           color: Colors.orange,
                        //           size: 20,
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 8),
                        //     Text(
                        //       'From ${movie.ratingCount} users',
                        //       style: const TextStyle(
                        //         fontSize: 14,
                        //         color: Colors.white70,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        Row(
                          children: [
                            _InfoChip(
                              label: detailProvider.animeDetail!.data.anime?.info?.stats?.type ?? "",
                              icon: Icons.tv,
                            ),
                            const SizedBox(width: 8),
                            _InfoChip(
                              label: detailProvider.animeDetail!.data.anime?.info?.stats?.duration ?? "",
                              icon: Icons.timer,
                            ),
                            const SizedBox(width: 8),
                            _InfoChip(
                              label: detailProvider.animeDetail!.data.anime?.moreInfo?.status ?? "",
                              icon: Icons.check_circle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Description
                        Text(
                          detailProvider.animeDetail!.data.anime?.info?.description ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Cast Section
                        const Text(
                          'Cast',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal, // Horizontal scrolling
                            itemCount: detailProvider.animeDetail!.data.anime?.info?.charactersVoiceActors!.length,
                            itemBuilder: (context, index) {
                              final cast = detailProvider.animeDetail!.data.anime?.info?.charactersVoiceActors![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(cast?.voiceActor?.poster ?? ""),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      cast?.voiceActor?.name ?? "",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      'As ${cast?.character?.name ?? ""}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20),
                        // Watch Now Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Watch now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        // Similar Anime Section
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Related Animes",
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
                                  itemCount: detailProvider.animeDetail?.data.relatedAnimes?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final relatedAnime = detailProvider.animeDetail?.data.relatedAnimes![index];
                                    return ListCard(
                                      imageUrl:  relatedAnime!.poster ?? "",
                                      title: relatedAnime.name ?? "",
                                      genres: " SUB: ${relatedAnime.episodes?.sub ?? 0} || DUB: ${relatedAnime.episodes?.dub ?? 0}",
                                      id: relatedAnime.id ?? "",
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _InfoChip({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.orange),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ],
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