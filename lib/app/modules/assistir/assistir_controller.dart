import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leitor/app/modules/assistir/repositories/assistir_anime_repository.dart';
import 'package:flutter_leitor/app/modules/assistir/widgets/controles/controles_widget.dart';
import 'package:flutter_leitor/app/shared/models/episodio_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';

part 'assistir_controller.g.dart';

class AssistirController extends _AssistirBase with _$AssistirController {
  AssistirController(AssistirAnimeRepository repo) : super(repo);

  @override
  void dispose() {
    if (_videoPlayerController != null) _videoPlayerController.dispose();
    if (_chewieController != null) _chewieController.dispose();
  }
}

abstract class _AssistirBase extends Disposable with Store {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  // @visibleForTesting
  // VideoPlayerController get videoPlayerControllerTest => _videoPlayerController;
  // @visibleForTesting
  // set videoPlayerController(VideoPlayerController value) => _videoPlayerController= value;
  // @visibleForTesting
  // set chewieController(ChewieController value) => _chewieController = value;

  final AssistirAnimeRepository _repo;

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
        _chewieController = ChewieController(
          customControls: ControlesWidget(title: ep.titulo),
          videoPlayerController: _videoPlayerController,
        );
        return Chewie(
          controller: _chewieController,
        );
      }
      _videoPlayerController = VideoPlayerController.network(data);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        customControls: ControlesWidget(title: ep.titulo),
        allowedScreenSleep: false,
        fullScreenByDefault: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.green,
        ),
        systemOverlaysAfterFullScreen: [],
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
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
