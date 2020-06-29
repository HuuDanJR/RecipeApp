// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_youtube_view/flutter_youtube_view.dart';
// import 'package:food_receipe/model/Video.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';
// import 'package:food_receipe/VideoPage.dart';
// import 'package:video_player/video_player.dart';

// class Video extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: VideoPage(), theme: ThemeData(fontFamily: 'Nunito'));
//   }
// }

// class VideoPage extends StatefulWidget {
//   @override
//   _VideoPageState createState() => _VideoPageState();
// }

// class _VideoPageState extends State<VideoPage> {
//   VideoPlayerController _controller;
//   Future<void> _initializeVideoPlayerFuture;
//   FlutterYoutubeViewController _onYoutubeCreated;
//   YouTubePlayerListener listener;
//   //video player

//   Future<VideoM> _fetchVideo() async {
//     var url =
//         "https://api.spoonacular.com/food/videos/search?number=10&query=pasta&apiKey=9fab92e88fd74954ab99be625fcce7da";
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var json = jsonDecode(response.body);
//       return VideoM.fromJson(json);
//     } else {
//       throw Exception('failed to load video');
//     }
//   }

//   @override
//   void initState() {
//     _controller = VideoPlayerController.network(
//       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//     );
//     _onYoutubeCreated;
//     _initializeVideoPlayerFuture = _controller.initialize();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Food'),
//         automaticallyImplyLeading: true,
//       ),
//       body: FutureBuilder(
//         future: _fetchVideo(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             VideoM video = snapshot.data;
//             return ListView.builder(
//                 itemCount: video.videos.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                           height: 250,
//                           width: MediaQuery.of(context).size.width,
//                          child: FlutterYoutubeView(
//                 listener: listener,
//                 scaleMode: YoutubeScaleMode.none, // <option> fitWidth, fitHeight
//                 params: YoutubeParam(
//                       videoId: 'gcj2RUWQZ60', 
//                       showUI: false, 
//                       startSeconds: 0.0, // <option>
//                       autoPlay: false) // <option>
//                 )
//             ),
//                       Container(
//                           width: MediaQuery.of(context).size.width,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text('title: ${video.videos[index].title}'),
//                               Text(
//                                   'shortTitle: ${video.videos[index].shortTitle}'),
//                               Text(
//                                   'YoutubeId: ${video.videos[index].youTubeId}'),
//                               Text('Id: ${video.videos[index].thumbnail}'),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Text(
//                                       'Rating: ${video.videos[index].rating.toStringAsFixed(5)}'),
//                                   Text('View: ${video.videos[index].views}'),
//                                   Text(
//                                       'Length: ${video.videos[index].length} s'),
//                                 ],
//                               ),
//                             ],
//                           ))
//                     ],
//                   );
//                 });
//           } else if (snapshot.hasError) {
//             return new Text('An error occur: ${snapshot.error}');
//           }
//           return new Center(
//             child: Container(
//                 height: 50,
//                 width: 50,
//                 child: new SpinKitCubeGrid(
//                   color: Colors.blue.shade200,
//                 )),
//           );
//         },
//       ),
//     );
//   }
// }
