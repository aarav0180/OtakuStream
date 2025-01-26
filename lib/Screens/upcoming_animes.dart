import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Providers/home_provider.dart';
import '../Widgets/snack_bar.dart';
import 'anime_detail.dart';

class LatestAnimes extends StatefulWidget {
  const LatestAnimes({super.key});

  @override
  State<LatestAnimes> createState() => _LatestAnimesState();
}

class _LatestAnimesState extends State<LatestAnimes> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedAnimes();
    final animeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (animeProvider.homeAnime == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        animeProvider.fetchHomeAnime();
      });
    }
  }

  Future<void> _loadSavedAnimes() async {
    setState(() {
      _isLoading = true;
    });


    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
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

  @override
  Widget build(BuildContext context) {
    final animeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Latest Animes",
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
          : animeProvider
          .homeAnime!.data.topUpcomingAnimes.isEmpty
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
              'Please check your internet connection!',
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
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: animeProvider
              .homeAnime!.data.topUpcomingAnimes.length,
          itemBuilder: (context, index) {
            final popularanime = animeProvider
                .homeAnime!.data.topUpcomingAnimes[index];
            return ListCard(
              imageUrl: popularanime.poster,
              title: popularanime.name,
              studio: popularanime.type,
              id: popularanime.id,
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

  const ListCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.studio,
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
                    // Flexible(
                    //   child: Text(
                    //     studio.toString(),
                    //     style: const TextStyle(
                    //       fontSize: 12,
                    //       color: Color(0xFFFFA726),
                    //     ),
                    //     maxLines: 1,
                    //     overflow: TextOverflow.ellipsis, // Truncate text with ellipsis
                    //   ),
                    // ),
                    _InfoChip(
                      label: studio,
                      icon: Icons.tv,
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

