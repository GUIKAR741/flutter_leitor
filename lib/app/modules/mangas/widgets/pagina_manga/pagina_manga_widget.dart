import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class PaginaMangaWidget extends StatelessWidget {
  final String url;

  const PaginaMangaWidget({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      fit: BoxFit.contain,
      cache: true,
      mode: ExtendedImageMode.gesture,
      initGestureConfigHandler: (state) {
        return GestureConfig(
          minScale: 0.9,
          animationMinScale: 0.7,
          maxScale: 3.0,
          animationMaxScale: 3.5,
          speed: 1.0,
          inertialSpeed: 100.0,
          initialScale: 1.0,
          inPageView: false,
          initialAlignment: InitialAlignment.center,
        );
      },
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
            break;
          case LoadState.completed:
            return state.completedWidget;
            break;
          case LoadState.failed:
            return Container(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      state.reLoadImage();
                    },
                    child: Text('Erro ao carregar')));
            break;
        }
        return null;
      },
    );
  }
}
