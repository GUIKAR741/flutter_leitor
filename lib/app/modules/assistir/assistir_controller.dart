import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leitor/app/modules/animes/repositories/anime_repository.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';

part 'assistir_controller.g.dart';

class AssistirController extends _AssistirBase with _$AssistirController {
  AssistirController(AnimeRepository _repo) : super(_repo);

  @override
  void dispose() {
    if (_videoPlayerController != null) _videoPlayerController.dispose();
    if (_chewieController != null) _chewieController.dispose();
  }
}

abstract class _AssistirBase extends Disposable with Store {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  final AnimeRepository _repo;

  _AssistirBase(this._repo);

  @observable
  ObservableFuture<Chewie> chewie;

  @action
  void iniciarLink(EpisodioModel ep) {
    chewie = null;
    chewie = _repo.linkVideo(ep).then((data) {
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
          Modular.to.popUntil(ModalRoute.withName('/animes/anime'));
        }
      });
      return Chewie(
        controller: _chewieController,
      );
    }).asObservable();
  }
}
