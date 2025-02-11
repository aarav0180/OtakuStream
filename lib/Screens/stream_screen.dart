// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:otaku_stream/Providers/episode_provider.dart';
// import 'package:otaku_stream/Providers/stream_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
// import '../Providers/server_provider.dart';
//
// class AdvancedVideoPlayer extends StatefulWidget {
//   const AdvancedVideoPlayer({Key? key}) : super(key: key);
//
//   @override
//   _AdvancedVideoPlayerState createState() =>
//       _AdvancedVideoPlayerState();
// }
//
// class _AdvancedVideoPlayerState
//     extends State<AdvancedVideoPlayer> {
//   late VideoPlayerController _controller;
//   //List<String> _servers = ["Server 1", "Server 2", "Server 3"];
//   //List<String> _qualities = ["480p", "720p", "1080p"];
//   final List<String> _subDubOptions = ["Sub", "Dub"];
//   Map<String, List<String>> _serverOptions = {
//     "Sub": [],
//     "Dub": []
//   };
//
//   // Future<void> _fetchServerOptions() async {
//   //   try {
//   //     final serverData = Provider.of<ServerProvider>(context, listen: false);
//   //     final servers = serverData.serverData!.data;
//   //
//   //     setState(() {
//   //       _serverOptions = servers as Map<String, List<String>>; // servers should be a Map<String, List<String>>
//   //       _selectedServer = _serverOptions[_selectedSubDub]?.first ?? "";
//   //     });
//   //   } catch (e) {
//   //     debugPrint("Error fetching servers: $e");
//   //   }
//   // }
//
//   Future<void> _fetchServerOptions() async {
//     try {
//       final serverData = Provider.of<ServerProvider>(context, listen: false);
//       final data = serverData.serverData?.data;
//
//       if (data != null) {
//         setState(() {
//           _serverOptions = {
//             "Sub": data.sub?.map((sub) => sub.serverName ?? "").toList() ?? [],
//             "Dub": data.dub?.map((dub) => dub.serverName ?? "").toList() ?? [],
//           };
//           _selectedServer = _serverOptions[_selectedSubDub]?.first ?? "";
//         });
//       }
//     } catch (e) {
//       debugPrint("Error fetching servers: $e");
//     }
//   }
//
//
//
//   String _selectedServer = "Server 1";
//   //String _selectedQuality = "720p";
//   String _selectedSubDub = "Sub";
//   bool _isLoading = true;
//   double _playbackSpeed = 1.0;
//   bool _isFullscreen = false;
//
//   @override
//   void initState() {
//     super.initState();
//     final episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
//     // final serverProvider = Provider.of<ServerProvider>(context, listen: false);
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   serverProvider.fetchAndCacheServers(episodeProvider.episodeData!.data.episodes[1].episodeId);
//     // });
//     _initializePlayer();
//     final streamProvider = Provider.of<StreamingProvider>(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       streamProvider.fetchAndCacheLinks(episodeProvider.episodeData!.data.episodes[1].episodeId, _selectedServer, _selectedSubDub);
//     });
//     //_fetchServerOptions();
//   }
//
//   Widget _buildSubDubToggle() {
//     return ToggleButtons(
//       borderRadius: BorderRadius.circular(8),
//       borderColor: Colors.orange,
//       selectedBorderColor: Colors.orange,
//       fillColor: Colors.orange.shade100,
//       selectedColor: Colors.orange,
//       color: Colors.white,
//       isSelected: _subDubOptions.map((option) => option == _selectedSubDub).toList(),
//       onPressed: (index) {
//         setState(() {
//           _selectedSubDub = _subDubOptions[index];
//           _initializePlayer();
//           //_selectedServer = _serverOptions[_selectedSubDub]?.first ?? "";
//         });
//       },
//       children: _subDubOptions.map((option) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Text(option, style: const TextStyle(fontSize: 16)),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildServerChips() {
//     return Consumer<ServerProvider>(
//       builder: (context, serverProvider, child) {
//         final data = serverProvider.serverData?.data;
//         if (data == null) {
//           return const Center(child: Text("No servers available", style: TextStyle(color: Colors.white)));
//         }
//
//         // Access servers dynamically based on _selectedSubDub
//         final servers = _selectedSubDub == "Sub"
//             ? data.sub?.map((dub) => dub.serverName ?? "").toList() ?? []
//             : data.dub?.map((dub) => dub.serverName ?? "").toList() ?? [];
//
//         _selectedServer = servers[0];
//
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: servers.map((server) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: ChoiceChip(
//                   label: Text(
//                     server,
//                     style: TextStyle(
//                       color: server == _selectedServer ? Colors.white : Colors.orange,
//                     ),
//                   ),
//                   selected: server == _selectedServer,
//                   selectedColor: Colors.orange,
//                   backgroundColor: Colors.black,
//                   onSelected: (isSelected) {
//                     if (isSelected) {
//                       setState(() {
//                         _selectedServer = server;
//                         _initializePlayer();
//                       });
//                     }
//                   },
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _initializePlayer() async {
//     try {
//
//       String videoUrl = await _fetchVideoUrl(); // Fetch video URL from API
//       _controller = VideoPlayerController.network(videoUrl)
//         ..initialize().then((_) {
//           setState(() {
//             _isLoading = false;
//           });
//           _controller.play();
//         });
//     } catch (e) {
//       debugPrint("Error initializing video player: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//
//   // Future<String> _fetchVideoUrl() async {
//   //   // Simulate API call to fetch video URL
//   //   await Future.delayed(const Duration(seconds: 1));
//   //   return "https://gg3.biananset.net/_v7/74a50cfd4c1c68eb65e43d21048f2e2dad2e8db6b42e757ada8fbfd1b4fb38d74b1c23d794f22381a22e44f43c7733f840067afe2e967767eb8a99a3c03102440da0706c30b5e4ed0751e68d7ffd5a686afffad7e16b4c77f16bf345606bdeab79112d52a761e9e003f90a8008a67d833314df0265b6c93971604bd7d00d4179/master.m3u8";
//   // }
//
//   Future<String> _fetchVideoUrl() async {
//     final streamProvider = Provider.of<StreamingProvider>(context, listen: false);
//     //final episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
//
//     // // Fetch stream data
//     // await streamProvider.fetchAndCacheLinks(
//     //   episodeProvider.episodeData!.data.episodes[1].episodeId,
//     //   _selectedServer,
//     //   _selectedSubDub,
//     // );
//
//     final streamUrl = streamProvider.streamData!.data!.sources![0].url;
//
//     // Return stream URL or fallback to default
//     if (streamUrl != null && streamUrl.isNotEmpty) {
//       return streamUrl;
//     } else {
//       debugPrint("No video found");
//       return "https://gg3.biananset.net/_v7/74a50cfd4c1c68eb65e43d21048f2e2dad2e8db6b42e757ada8fbfd1b4fb38d74b1c23d794f22381a22e44f43c7733f840067afe2e967767eb8a99a3c03102440da0706c30b5e4ed0751e68d7ffd5a686afffad7e16b4c77f16bf345606bdeab79112d52a761e9e003f90a8008a67d833314df0265b6c93971604bd7d00d4179/master.m3u8";
//     }
//   }
//
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _changePlaybackSpeed(double speed) {
//     setState(() {
//       _playbackSpeed = speed;
//       _controller.setPlaybackSpeed(speed);
//     });
//   }
//
//   void _toggleFullscreen() {
//     if (_isFullscreen) {
//       // Exit fullscreen mode
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ]);
//     } else {
//       // Enter fullscreen mode
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ]);
//     }
//     setState(() {
//       _isFullscreen = !_isFullscreen;
//     });
//   }
//
//
//   void _seekToPosition(Duration position) {
//     _controller.seekTo(position);
//   }
//
//   Widget _buildVideoControls() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         VideoProgressIndicator(
//           _controller,
//           allowScrubbing: true,
//           colors: const VideoProgressColors(
//             playedColor: Colors.orange,
//             bufferedColor: Colors.white70,
//             backgroundColor: Colors.white24,
//           ),
//           //onSeek: _seekToPosition,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.replay_10, color: Colors.orange),
//               onPressed: () => _controller.seekTo(
//                 _controller.value.position - const Duration(seconds: 10),
//               ),
//             ),
//             IconButton(
//               icon: Icon(
//                 _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                 color: Colors.orange,
//               ),
//               onPressed: () {
//                 setState(() {
//                   if (_controller.value.isPlaying) {
//                     _controller.pause();
//                   } else {
//                     _controller.play();
//                   }
//                 });
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.forward_10, color: Colors.orange),
//               onPressed: () => _controller.seekTo(
//                 _controller.value.position + const Duration(seconds: 10),
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.fullscreen, color: Colors.orange),
//               onPressed: _toggleFullscreen,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//
//   Widget _buildVideoPlayer() {
//     return Stack(
//       children: [
//         AspectRatio(
//           aspectRatio: _controller.value.isInitialized
//               ? _controller.value.aspectRatio
//               : 16 / 9,
//           child: _controller.value.isInitialized
//               ? VideoPlayer(_controller)
//               : const Center(
//             child: CircularProgressIndicator(
//               color: Colors.orange,
//             ),
//           ),
//         ),
//         if (_isLoading)
//           const Center(
//             child: CircularProgressIndicator(color: Colors.orange),
//           ),
//       ],
//     );
//   }
//
//   Widget _buildLandscapeLayout() {
//     return Stack(
//       children: [
//         VideoPlayer(_controller),
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: _buildVideoControls(),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: isPortrait
//             ? Column(
//           children: [
//             _buildVideoPlayer(), // Optimized video player widget
//             const SizedBox(height: 16),
//             _buildSubDubToggle(),
//             const SizedBox(height: 8),
//             _buildServerChips(),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 12,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(
//                       "Episode ${index + 1}",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     trailing: Icon(
//                       index == 0
//                           ? Icons.play_circle_fill
//                           : Icons.play_arrow,
//                       color: Colors.orange,
//                     ),
//
//         onTap: () {
//
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         )
//             : _buildLandscapeLayout(),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:wakelock_plus/wakelock_plus.dart';
import '../Providers/episode_provider.dart';
import '../Providers/stream_provider.dart';

class AdvancedVideoPlayer extends StatefulWidget {
  const AdvancedVideoPlayer({super.key});

  @override
  _AdvancedVideoPlayerState createState() => _AdvancedVideoPlayerState();
}

class _AdvancedVideoPlayerState extends State<AdvancedVideoPlayer> {
  VideoPlayerController? _controller;
  final List<String> _subDubOptions = ["sub", "dub"];
  final Map<String, List<String>> _serverOptions = {
    "sub": ["hd-1", "hd-2"],
    "dub": ["hd-1", "hd-2"]
  };
  String _selectedServer = "hd-1";
  String _selectedSubDub = "sub";
  bool _isLoading = true;
  double _playbackSpeed = 1.0;
  bool _isFullscreen = false;
  bool _areSubtitlesVisible = true;
  List<Subtitle> _subtitles = [];
  late Ticker _ticker;
  Duration _currentTime = Duration.zero;
  int episodeNo = 0;
  Timer? _hideControlsTimer;
  bool _controlsVisible = false;

  @override
  void initState() {
    super.initState();
    _initializeWithProvider(episodeNo);
    WakelockPlus.enable();
  }

  void _onTick(Duration elapsed) {
    if (_controller != null && _controller!.value.isInitialized) {
      setState(() {
        _currentTime = _controller!.value.position;
      });
    }
  }

  Future<void> _initializeWithProvider(int episodeNo) async {
    final episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    final streamProvider = Provider.of<StreamingProvider>(context, listen: false);

    try {
      setState(() {
        _isLoading = true; // Indicate loading
      });

      // Fetch data for the stream provider
      await streamProvider.fetchAndCacheLinks(
        episodeProvider.episodeData!.data.episodes[episodeNo].episodeId,
        _selectedServer,
        _selectedSubDub,
      );

      _ticker = Ticker(_onTick);

      // Ensure the provider's data is ready and initialize the player
      if (streamProvider.streamData?.data != null) {
        await _initializePlayer(); // Reinitialize the player
      } else {
        debugPrint("Stream provider data is null.");
      }
    } catch (e) {
      debugPrint("Error in _initializeWithProvider: $e");
    }
  }

  void _showControls() {
    setState(() {
      _controlsVisible = true;
    });
    // Cancel any existing timer.
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _controlsVisible = false;
      });
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller?.value.isPlaying == true) {
        _controller?.pause();
      } else {
        _controller?.play();
      }
    });
  }

  Future<void> _initializePlayer() async {
    setState(() {
      _isLoading = true;
    });

    final streamProvider = Provider.of<StreamingProvider>(context, listen: false);

    try {
      // Fetch the video URL
      String videoUrl = await _fetchVideoUrl();

      // Extract the subtitle file URL marked as default
      final tracks = streamProvider.streamData?.data?.tracks;

      String? subtitleUrl;
      if (tracks != null) {
        final defaultTrack = tracks.firstWhere(
              (track) => track.trackDefault == true,
        );
        subtitleUrl = defaultTrack.file; // Extract the subtitle file URL
        debugPrint("Selected subtitle URL: $subtitleUrl");
      }

      // Dispose of the existing controller if present
      if (_controller != null) {
        await _controller!.dispose();
      }

      // Initialize the video player
      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          setState(() {
            _isLoading = false;
          });

          // Start the ticker after the video player is initialized
          _ticker.start();

          _controller!.play();
        });

      // Load subtitles if a valid URL is available
      if (subtitleUrl != null && subtitleUrl.isNotEmpty) {
        await _loadSubtitles(subtitleUrl);
      }
    } catch (e) {
      debugPrint("Error initializing video player: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }




  Future<String> _fetchVideoUrl() async {
    final streamProvider = Provider.of<StreamingProvider>(context, listen: false);

    final streamUrl = streamProvider.streamData!.data!.sources![0].url;

    // Return stream URL or fallback to default
    if (streamUrl != null && streamUrl.isNotEmpty) {
      return streamUrl;
    } else {
      debugPrint("No video found");
      return "https://gg3.biananset.net/_v7/74a50cfd4c1c68eb65e43d21048f2e2dad2e8db6b42e757ada8fbfd1b4fb38d74b1c23d794f22381a22e44f43c7733f840067afe2e967767eb8a99a3c03102440da0706c30b5e4ed0751e68d7ffd5a686afffad7e16b4c77f16bf345606bdeab79112d52a761e9e003f90a8008a67d833314df0265b6c93971604bd7d00d4179/master.m3u8";
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _ticker.stop();
    _ticker.dispose();
    WakelockPlus.disable();
    super.dispose();
  }
  void _changePlaybackSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
      _controller?.setPlaybackSpeed(speed);
    });
  }

  Future<void> _loadSubtitles(String subtitleUrl) async {
    try {
      final response = await http.get(Uri.parse(subtitleUrl));

      if (response.statusCode == 200) {
        final subtitleContent = utf8.decode(response.bodyBytes);
        final lines = subtitleContent.split('\n');
        _subtitles = [];

        for (int i = 0; i < lines.length; i++) {
          if (lines[i].contains('-->')) {
            final parts = lines[i].split('-->');
            final start = _parseDuration(parts[0].trim());
            final end = _parseDuration(parts[1].trim());
            final textBuffer = StringBuffer();

            int j = i + 1;
            while (j < lines.length && lines[j].isNotEmpty && !lines[j].contains('-->')) {
              textBuffer.writeln(lines[j]);
              j++;
            }

            _subtitles.add(Subtitle(
              start: start,
              end: end,
              text: textBuffer.toString().trim(),
            ));

            i = j - 1; // Skip processed lines
          }
        }

        if (_subtitles.isEmpty) {
          debugPrint("No subtitles parsed. Check subtitle file format.");
        } else {
          debugPrint("Subtitles loaded: ${_subtitles.length} entries.");
        }
      } else {
        throw Exception('Failed to load subtitles with status code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error loading subtitles: $e");
    }
  }


  Duration _parseDuration(String time) {
    try {
      final parts = time.split(':');

      // Handle case where time is in "hh:mm:ss.mmm" format (with hours)
      if (parts.length == 3) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        final secondsParts = parts[2].split('.');
        final seconds = int.parse(secondsParts[0]);
        final milliseconds = secondsParts.length > 1
            ? int.tryParse(secondsParts[1].padRight(3, '0')) ?? 0
            : 0;
        return Duration(
          hours: hours,
          minutes: minutes,
          seconds: seconds,
          milliseconds: milliseconds,
        );
      }

      // Handle case where time is in "mm:ss.mmm" format (no hours)
      if (parts.length == 2) {
        final minutes = int.parse(parts[0]);
        final secondsParts = parts[1].split('.');
        final seconds = int.parse(secondsParts[0]);
        final milliseconds = secondsParts.length > 1
            ? int.tryParse(secondsParts[1].padRight(3, '0')) ?? 0
            : 0;
        return Duration(
          minutes: minutes,
          seconds: seconds,
          milliseconds: milliseconds,
        );
      }

      // If the format is incorrect, return Duration.zero
      throw const FormatException('Invalid time format');
    } catch (e) {
      debugPrint("Error parsing duration: $e");
      return Duration.zero; // Fallback to zero duration on error
    }
  }

  Widget _buildSubtitles() {
    if (!_areSubtitlesVisible || _controller == null || !_controller!.value.isInitialized) {
      return const SizedBox(height: 0, width: 0);
    }

    // Use the current time tracked by the ticker
    final subtitle = _subtitles.firstWhere(
          (s) => _currentTime >= s.start && _currentTime <= s.end,
      orElse: () => Subtitle(start: Duration.zero, end: Duration.zero, text: ''),
    );

    return subtitle.text.isNotEmpty
        ? Positioned(
      bottom: 76,
      left: 16,
      right: 16,
      child: Container(
        alignment: Alignment.center,
        //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.black54, // Background for subtitle readability
            borderRadius: BorderRadius.circular(10), // Optional: rounded corners
          ),
          child: Text(
            subtitle.text.replaceAll(RegExp(r'<[^>]*>'), ''), // Remove HTML tags
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.03, // Adjusted responsive font size
            ),
          ),
        ),
      ),
    )
        : const SizedBox.shrink();
  }



  // Widget _buildSubDubToggle() {
  //   return Column(
  //     children: [
  //       ToggleButtons(
  //         borderRadius: BorderRadius.circular(8),
  //         borderColor: Colors.orange,
  //         selectedBorderColor: Colors.orange,
  //         fillColor: Colors.orange.shade100,
  //         selectedColor: Colors.orange,
  //         color: Colors.white,
  //         isSelected: _subDubOptions.map((option) => option == _selectedSubDub).toList(),
  //         onPressed: (index) async {
  //           setState(() {
  //             _selectedSubDub = _subDubOptions[index];
  //             _selectedServer = _serverOptions[_selectedSubDub]?.first ?? "hd-1";
  //             _isLoading = true;
  //           });
  //           await _initializeWithProvider(episodeNo);
  //         },
  //         children: _subDubOptions.map((option) {
  //           return Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 12),
  //             child: Text(option.toUpperCase(), style: const TextStyle(fontSize: 16)),
  //           );
  //         }).toList(),
  //       ),
  //       const SizedBox(height: 20),
  //     ],
  //   );
  // }

  Widget _buildSubDubToggle() {
    return Column(
      children: [
        ToggleButtons(
          borderRadius: BorderRadius.circular(8),
          borderColor: Colors.orange,
          selectedBorderColor: Colors.orange,
          fillColor: Colors.orange.shade100,
          selectedColor: Colors.orange,
          color: Colors.white,
          isSelected: _subDubOptions.map((option) => option == _selectedSubDub).toList(),
          onPressed: (index) async {
            final newSubDub = _subDubOptions[index];

            // Update state and reinitialize
            setState(() {
              _selectedSubDub = newSubDub;
              _selectedServer = _serverOptions[newSubDub]?.first ?? "hd-1";
              _isLoading = true; // Show loading indicator
            });

            // Reinitialize with the updated options
            await _initializeWithProvider(episodeNo);
          },
          children: _subDubOptions.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(option.toUpperCase(), style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }


  // Widget _buildServerChips() {
  //   final servers = _serverOptions[_selectedSubDub] ?? [];
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       children: servers.map((server) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8),
  //           child: ChoiceChip(
  //             label: Text(
  //               server,
  //               style: TextStyle(
  //                 color: server == _selectedServer ? Colors.white : Colors.orange,
  //               ),
  //             ),
  //             selected: server == _selectedServer,
  //             selectedColor: Colors.orange,
  //             backgroundColor: Colors.black,
  //             onSelected: (isSelected) async{
  //               final streamProvider = Provider.of<StreamingProvider>(context, listen: false);
  //               final streamUrl = streamProvider.streamData!.data;
  //               if (isSelected) {
  //                 setState(() async {
  //                   _selectedServer = server;
  //                   _isLoading = true;
  //                   if (streamUrl != null) {
  //                     await _initializeWithProvider(episodeNo);
  //                   }
  //                 });
  //               }
  //             },
  //           ),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  Widget _buildServerChips() {
    final servers = _serverOptions[_selectedSubDub] ?? [];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: servers.map((server) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(
                server,
                style: TextStyle(
                  color: server == _selectedServer ? Colors.white : Colors.orange,
                ),
              ),
              selected: server == _selectedServer,
              selectedColor: Colors.orange,
              backgroundColor: Colors.black,
              onSelected: (isSelected) async {
                if (isSelected) {
                  setState(() {
                    _selectedServer = server;
                    _isLoading = true; // Show loading indicator
                  });

                  // Reinitialize the player with the updated server
                  await _initializeWithProvider(episodeNo);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double aspectRatio = 16 / 9;

    return GestureDetector(
      onTap: _showControls,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // AspectRatio for video to maintain correct aspect ratio
          AspectRatio(
            aspectRatio: aspectRatio,
            // _controller?.value.isInitialized == true
            //     ? (_isFullscreen ? screenWidth / screenHeight : _controller!.value.aspectRatio)
            //     : 16 / 9,
            child: _controller?.value.isInitialized == true
                ? VideoPlayer(_controller!)
                : const Center(
              child: SpinKitFadingCircle(
                color: Colors.orange,
                size: 50.0,
              ),
            ),
          ),

          // Subtitles
          if (_areSubtitlesVisible) _buildSubtitles(),

          //controls
          if (_controlsVisible)
            Center(
              child: IconButton(
                iconSize: 80,
                icon: Icon(
                  _controller?.value.isPlaying == true
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: Colors.white.withOpacity(0.8),
                ),
                onPressed: _togglePlayPause,
              ),
            ),


          if (_controlsVisible && _controller?.value.isInitialized == true)
            Positioned(
              bottom: isPortrait ? 0 : 0,
              left: 0,
              right: 0,
              child: Column(
                children: [

                  VideoProgressIndicator(
                    _controller!,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Colors.orange,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.black,
                    ),
                  ),

                  _buildVideoControls(),
                ],
              ),
            ),

          if (_isLoading)
            const Center(
              child: SpinKitFadingCircle(color: Colors.orange, size: 50.0),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoControls() {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.replay_10, color: Colors.white, size:35),
              onPressed: () => _controller?.seekTo(
                _controller!.value.position - const Duration(seconds: 10),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(
                _controller?.value.isPlaying == true ? Icons.pause : Icons.play_arrow,
                color: Colors.white, size:40
              ),
              onPressed: () {
                setState(() {
                  if (_controller?.value.isPlaying == true) {
                    _controller?.pause();
                  } else {
                    _controller?.play();
                  }
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.forward_10, color: Colors.white, size:35),
              onPressed: () => _controller?.seekTo(
                _controller!.value.position + const Duration(seconds: 10),
              ),
            ),
          ),

          GestureDetector(
            onTap: _showSpeedPopup, // Open the speed popup when clicked
            child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    duration: const Duration(milliseconds: 200),
                    scale: _playbackSpeed == 1.0 ? 1.1 : 1.0,
                    child: Text(
                      '${_playbackSpeed}x',
                      style:const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.orange,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.subtitles,  color: _areSubtitlesVisible == true ? Colors.orange: Colors.white, size:30),
              onPressed: () {
                setState(() {
                  _areSubtitlesVisible = !_areSubtitlesVisible;
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.fullscreen, color: Colors.white, size:30),
              onPressed: _toggleFullscreen,
            ),
          ),
        ],
      ),
    );
  }

  void _showSpeedPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 900),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Playback Speed",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                // Speed options
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var speed in [0.5, 1.0, 1.5, 2.0])
                      GestureDetector(
                        onTap: () {
                          _changePlaybackSpeed(speed);
                          Navigator.pop(context); // Close dialog
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                            color: _playbackSpeed == speed
                                ? Colors.orange.withOpacity(0.9)
                                : Colors.black54,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              if (_playbackSpeed == speed)
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.6),
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                ),
                            ],
                          ),
                          child: Text(
                            '${speed}x',
                            style: TextStyle(
                              color: _playbackSpeed == speed ? Colors.white : Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final episodeProvider = Provider.of<EpisodeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildVideoPlayer(),
            ),

            if (isPortrait) ...[
              const SizedBox(height: 11),
              // _buildSubDubToggle(),
              // const SizedBox(height: 2),
              // _buildServerChips(),
              Text(
                'SUB DUB AND QUALITY SELECTION IS COMING SOON',
                style: GoogleFonts.poppins(
                  color: Colors.orange,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 100,
                child: Lottie.asset('assets/animations/notFound.json'),
              ),

              const SizedBox(height: 11),
              Expanded(
              child: ListView.builder(
                itemCount: episodeProvider.episodeData!.data.totalEpisodes,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: index == episodeNo ? Colors.orange.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,  // Ensuring uniform padding
                      title: Text(
                        "Episode ${index + 1}: ${episodeProvider.episodeData!.data.episodes[index].title}",
                        style: TextStyle(
                          color: index == episodeNo ? Colors.orange : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      trailing: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          index == episodeNo ? Icons.pause_circle_filled : Icons.play_arrow,
                          key: ValueKey<int>(index),
                          color: index == episodeNo ? Colors.orange : Colors.white,
                          size: 30,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          episodeNo = index; // update the selected episode
                        });
                        _initializeWithProvider(episodeNo);
                      },
                    ),
                  );
                },
              ),
            ),
            ],
          ],
        ),
      ),
    );
  }


  void _toggleFullscreen() {
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
  }
}

class Subtitle {
  final Duration start;
  final Duration end;
  final String text;

  Subtitle({required this.start, required this.end, required this.text});
}
