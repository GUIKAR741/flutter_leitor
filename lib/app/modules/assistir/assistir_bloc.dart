import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart' show Colors, ModalRoute, Navigator;
import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:video_player/video_player.dart';

class AssistirBloc extends Disposable {
  final AnimeRepository repo;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  AssistirBloc(this.repo);

  final StreamController<Chewie> _dados = StreamController<Chewie>.broadcast();
  Stream<Chewie> get dados => _dados.stream;

  void iniciarLink(context, Episodio ep) {
    repo.linkVideo(ep).then((data) {
      if (data == 'link_invalido') {
        ep.titulo = 'Indisponivel';
        _videoPlayerController = VideoPlayerController.network(null);
        _chewieController =
            ChewieController(videoPlayerController: _videoPlayerController);
      }
      _videoPlayerController = VideoPlayerController.network(data);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: true,
        // overlay: TituloOverlay(ep: ep),
        allowedScreenSleep: false,
        fullScreenByDefault: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.green,
        ),
      );
      _videoPlayerController.addListener(() {
        if (_videoPlayerController.value.position ==
            _videoPlayerController.value.duration) {
          Navigator.popUntil(context, ModalRoute.withName('/animes/anime'));
        }
      });

      _dados.add(Chewie(
        controller: _chewieController,
      ));
    });
  }

  @override
  void dispose() {
    _dados.close();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}

// class TituloOverlay extends StatefulWidget {
//   final Episodio ep;

//   const TituloOverlay({Key key, this.ep}) : super(key: key);

//   @override
//   _TituloOverlayState createState() => _TituloOverlayState();
// }

// class _TituloOverlayState extends State<TituloOverlay> {
//   bool _hideStuff = false;
//   final barHeight = 35.0;
//   final marginSize = 5.0;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onHover: (_) => _mostrar(),
//       child: GestureDetector(
//         onTap: _mostrar,
//         child: AbsorbPointer(
//           absorbing: _hideStuff,
//           child: AnimatedOpacity(
//             opacity: _hideStuff ? 0.0 : 1.0,
//             duration: Duration(milliseconds: 300),
//             child: Container(
//               height: barHeight,
//               color: Theme.of(context).dialogBackgroundColor,
//               padding: EdgeInsets.only(left: 10.0),
//               child: Column(
//                 children: <Widget>[
//                   _buildHitArea(),
//                   Expanded(child: Text(widget.ep.titulo)),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       // value: '',
//     );
//   }

//   Expanded _buildHitArea() {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           _mostrar();
//         },
//         child: Container(
//           color: Colors.transparent,
//           child: Center(
//             child: AnimatedOpacity(
//               opacity: _hideStuff ? 1.0 : 0.0,
//               duration: Duration(milliseconds: 300),
//               child: GestureDetector(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).dialogBackgroundColor,
//                     borderRadius: BorderRadius.circular(48.0),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Icon(Icons.play_arrow, size: 32.0),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _mostrar() {
//     // print('mostrando');
//     setState(() {
//       _hideStuff = !_hideStuff;
//     });
//   }
// }
