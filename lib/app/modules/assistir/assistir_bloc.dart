import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart' show Colors;
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

  void iniciarLink(Episodio ep) {
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
        // fullScreenByDefault: true,

        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.green,
        ),
      );
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
