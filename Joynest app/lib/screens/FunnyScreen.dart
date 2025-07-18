import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'Home.dart';

class FunnyScreen extends StatefulWidget {
  const FunnyScreen({super.key});

  @override
  _FunnyScreenState createState() => _FunnyScreenState();
}

class _FunnyScreenState extends State<FunnyScreen> {
  int _currentIndex = 0;

  List<dynamic> _videos = [];
  bool _isLoading = true;
  String _errorMessage = '';
  final String _apiKey = 'AIzaSyCGF5VDzpIZyPpig-TW9qT4MzCdMR7dwPg';

  List<YoutubePlayerController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _searchYouTubeVideos();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.close();
    }
    super.dispose();
  }

  Future<void> _searchYouTubeVideos() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final response = await http.get(
        Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?'
          'part=snippet&'
          'maxResults=6&'
          'q=depression+help+therapy+mental+health&'
          'type=video&'
          'videoDuration=medium&'
          'key=$_apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'];

        for (var controller in _controllers) {
          controller.close();
        }

        _controllers = items.map<YoutubePlayerController>((video) {
          final videoId = video['id']['videoId'] as String;
          return YoutubePlayerController.fromVideoId(
            videoId: videoId,
            autoPlay: false,
            params: const YoutubePlayerParams(
              showControls: true,
              showFullscreenButton: true,
            ),
          );
        }).toList();

        setState(() {
          _videos = items;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Failed to load videos. Error code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Connection error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Mental Health Support",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 123, 167, 215),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _searchYouTubeVideos,
          ),
        ],
      ),
      body: _buildMainContent(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildMainContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchYouTubeVideos,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Professional Mental Health Videos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            ..._videos.asMap().entries.map((entry) {
              final index = entry.key;
              final video = entry.value;
              final title = video['snippet']['title'];
              final channel = video['snippet']['channelTitle'];

              return Column(
                children: [
                  YoutubePlayer(controller: _controllers[index]),
                  ListTile(
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(channel),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
            _buildResourceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Crisis Support Resources",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        _buildResourceCard(
          "National Suicide Prevention Lifeline",
          "https://suicidepreventionlifeline.org",
          "Call or text 988 for 24/7 support",
        ),
        _buildResourceCard(
          "Crisis Text Line",
          "https://www.crisistextline.org",
          "Text HOME to 741741",
        ),
      ],
    );
  }

  Widget _buildResourceCard(String title, String url, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not launch $url')),
            );
          }
        },
      ),
    );
  }

  BottomAppBar _buildBottomNavBar() {
    return BottomAppBar(
      color: const Color.fromARGB(255, 123, 167, 215),
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              size: _currentIndex == 0 ? 40 : 30,
              color: _currentIndex == 0
                  ? Colors.white
                  : const Color.fromARGB(255, 8, 63, 94),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              setState(() => _currentIndex = 0);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.spa,
              size: _currentIndex == 1 ? 40 : 30,
              color: _currentIndex == 1
                  ? Colors.white
                  : const Color.fromARGB(255, 8, 63, 94),
            ),
            onPressed: () {
              setState(() => _currentIndex = 1);
            },
          ),
        ],
      ),
    );
  }
}
