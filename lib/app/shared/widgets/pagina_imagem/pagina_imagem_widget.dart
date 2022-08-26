import 'package:extended_image/extended_image.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PaginaImagemWidget extends StatelessWidget {
  final String url;

  const PaginaImagemWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, o) => ExtendedImage.network(
        url,
        fit: BoxFit.contain,
        cache: true,
        filterQuality: FilterQuality.high,
        mode: ExtendedImageMode.gesture,
        initGestureConfigHandler: (state) {
          return GestureConfig(
            minScale: 0.9,
            animationMinScale: 0.7,
            maxScale: 3.0,
            animationMaxScale: 3.5,
            speed: 1.0,
            inertialSpeed: 100.0,
            initialScale: o == Orientation.portrait ? 1.0 : 3.0,
            inPageView: false,
            initialAlignment: o == Orientation.portrait
                ? InitialAlignment.center
                : InitialAlignment.topCenter,
          );
        },
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoadState.completed:
              return state.completedWidget;
            case LoadState.failed:
              Modular.get<FirebaseCrashlytics>()
                  .log('Erro ao Carregar Imagem $url');
              return Center(
                child: ElevatedButton(
                  onPressed: state.reLoadImage,
                  child: const Text('Erro ao carregar'),
                ),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
