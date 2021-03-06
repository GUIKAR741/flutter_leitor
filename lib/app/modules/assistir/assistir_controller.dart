import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';

import '../../modules/assistir/repositories/assistir_anime_repository.dart';
import '../../modules/assistir/widgets/controles/controles_widget.dart';
import '../../shared/models/capitulo_episodio_model.dart';

part 'assistir_controller.g.dart';

class AssistirController extends _AssistirBase with _$AssistirController {
  @override
  void dispose() {
    if (!_cancel.isCancelled) _cancel.cancel();
    if (_videoPlayerController != null) _videoPlayerController?.dispose();
    if (_chewieController != null) _chewieController?.dispose();
  }
}

abstract class _AssistirBase extends Disposable with Store {
  final CancelToken _cancel = CancelToken();
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  final AssistirAnimeRepository _repo = Modular.get<AssistirAnimeRepository>();

  @observable
  ObservableFuture<Chewie> chewie;

  @action
  void iniciarLink(CapEpModel ep) {
    chewie = null;
    chewie = _repo.linkVideo(ep, cancel: _cancel).then((data) {
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
      _videoPlayerController.addListener(
        () {
          if (_videoPlayerController.value.position ==
              _videoPlayerController.value.duration) {
            Modular.to.popUntil(ModalRoute.withName('/animes/anime'));
          }
        },
      );
      return Chewie(
        controller: _chewieController,
      );
    }).asObservable();
  }
}
