import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlay extends StatefulWidget{
  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  
  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer(){
     controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
     controller.addListener(() {
        setState(() {});
     });
    controller.initialize().then((value){
        setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
              title: Text("Play Video from Assets/URL"),
              backgroundColor: Color(0xff1160aa),
          ),
          body: Container( 
            child: Column(
              children:[
                  AspectRatio( 
                    aspectRatio: controller.value.aspectRatio,
                     child: VideoPlayer(controller),
                  ),

                  Container( //duration of video
                     child: Text("Total Duration: " + controller.value.duration.toString()),
                  ),

                  Container(
                      child: VideoProgressIndicator(
                        controller, 
                        allowScrubbing: true,
                        colors:VideoProgressColors(
                            backgroundColor: Colors.redAccent,
                            playedColor: Colors.green,
                            bufferedColor: Colors.purple,
                        )
                      )
                  ),

                  Container(
                     child: Row(
                         children: [
                            IconButton(
                                onPressed: (){
                                  if(controller.value.isPlaying){
                                    controller.pause();
                                  }else{
                                    controller.play();
                                  }

                                  setState(() {
                                    
                                  });
                                }, 
                                icon:Icon(controller.value.isPlaying?Icons.pause:Icons.play_arrow)
                           ),

                           IconButton(
                                onPressed: (){
                                  controller.seekTo(Duration(seconds: 0));

                                  setState(() {
                                    
                                  });
                                }, 
                                icon:Icon(Icons.stop)
                           )
                         ],
                     ),
                  )
              ]
            )
          ),
       );
  }
}