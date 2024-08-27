import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerView extends StatelessWidget {
  final String url;

  const ImageViewerView(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    final isRtl = Directionality.of(context).index == 0;
    FocusScope.of(context).unfocus();
    return Hero(
      tag: url,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            PhotoView(
              imageProvider: CachedNetworkImageProvider(url),
            ),
            if (isRtl)
              Positioned(
                top: 80,
                right: 15,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            else
              Positioned(
                top: 80,
                left: 15,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
