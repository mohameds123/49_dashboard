import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:readmore/readmore.dart';

class MultiImageViewer extends StatelessWidget {
  const MultiImageViewer({
    super.key,
    required this.images,
    this.captions,
    this.backgroundColor = Colors.black87,
    this.textStyle = const TextStyle(
      fontSize: 30,
    ),
    this.height = 205,
    this.width,
  });

  /// Color of the background image.
  final Color backgroundColor;

  ///Color for the textStyle
  final TextStyle textStyle;

  /// List of network images to display.
  final List<String> images;

  /// List of captions to display.
  ///
  /// Each caption is displayed with respect to its corresponding image.
  ///
  /// The number of captions `must` be equal to the number of images or else, captions will not be displayed.
  final List<String>? captions;

  /// Height of the image(s).
  ///
  /// If not set, it will be a height of 205.0.
  final double height;

  /// Width of the image(s).
  final double? width;

  @override
  Widget build(BuildContext context) {
    /// MediaQuery Width
    final double defaultWidth = MediaQuery.of(context).size.width;

    if (images.isEmpty) {
      return const SizedBox();
    }
    if (images.length == 1) {
      return GestureDetector(
        onTap: () => openImage(context, 0, images, captions),
        child: Container(
          height: height,
          width: width ?? defaultWidth,
          decoration: BoxDecoration(
            color: backgroundColor,
            image: DecorationImage(
              image: CachedNetworkImageProvider(images[0]),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      );
    } else if (images.length == 2) {
      return SizedBox(
        height: height,
        width: width ?? defaultWidth,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 1),
                child: GestureDetector(
                  onTap: () => openImage(context, 0, images, captions),
                  child: Container(
                    height: height,
                    width: width == null ? defaultWidth / 2 : width! / 2,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(images[0]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: GestureDetector(
                  onTap: () => openImage(context, 1, images, captions),
                  child: Container(
                    height: height,
                    width: width == null ? defaultWidth / 2 : width! / 2,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(images[1]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (images.length == 3) {
      return SizedBox(
        height: height,
        width: width ?? defaultWidth,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2, bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 0, images, captions),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(images[0]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 1, images, captions),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(images[1]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => openImage(context, 2, images, captions),
                child: Container(
                  width: width == null ? defaultWidth / 2 : width! / 2,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(images[2]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (images.length == 4) {
      return SizedBox(
        height: height,
        width: width ?? defaultWidth,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2, bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 0, images, captions),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(images[0]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 1, images, captions),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(images[1]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 2, images, captions),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(images[2]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 3, images, captions),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(images[3]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (images.length > 4) {
      return SizedBox(
        height: height,
        width: width ?? defaultWidth,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2, bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 0, images, captions),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(images[0]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 1, images, captions),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(images[1]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: GestureDetector(
                        onTap: () => openImage(context, 2, images, captions),
                        child: Container(
                          width: width == null ? defaultWidth / 2 : width! / 2,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(images[2]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openImage(context, 3, images, captions),
                      child: Container(
                        width: width == null ? defaultWidth / 2 : width! / 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(images[3]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "+${images.length - 4}",
                              style: textStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

/// View Image(s)
void openImage(
  BuildContext context,
  int index,
  List<String> unitImages,
  List<String>? captions,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GalleryPhotoViewWrapper(
        galleryItems: unitImages,
        captions: captions,
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        initialIndex: index,
      ),
    ),
  );
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  const GalleryPhotoViewWrapper({
    super.key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    required this.galleryItems,
    this.captions,
    this.scrollDirection = Axis.horizontal,
    this.onDelete,
    this.onCommentClick,
  });

  final BoxDecoration? backgroundDecoration;
  final List<String>? galleryItems;
  final List<String>? captions;
  final int? initialIndex;
  final LoadingBuilder? loadingBuilder;
  final dynamic maxScale;
  final dynamic minScale;
  final Axis scrollDirection;
  final VoidCallback? onDelete;
  final VoidCallback? onCommentClick;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int? currentIndex;
  bool showCaptions = false;
  late final pageController = PageController(initialPage: widget.initialIndex!);

  @override
  void initState() {
    checkCaptionLength();
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void checkCaptionLength() {
    if (widget.captions != null &&
        widget.captions!.length == widget.galleryItems!.length) {
      showCaptions = true;
    }
  }

  void onPageChanged(int index) {
    if (mounted) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.galleryItems![index];
    return PhotoViewGalleryPageOptions(
      imageProvider: CachedNetworkImageProvider(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 41, 7),
      body: Container(
        decoration: widget.backgroundDecoration ??
            const BoxDecoration(
              color: Color.fromARGB(255, 13, 39, 6),
            ),
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment:
              showCaptions ? Alignment.bottomCenter : Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems!.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration ??
                  const BoxDecoration(
                    color: Color.fromARGB(255, 9, 40, 1),
                  ),
              pageController: pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: showCaptions
                  ? ReadMoreText(
                      widget.captions![currentIndex!],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      colorClickableText: Colors.white,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more'.tr,
                      trimExpandedText: 'Show less'.tr,
                      moreStyle: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.onCommentClick != null)
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white.withOpacity(0.5),
                            child: IconButton(
                              onPressed: widget.onCommentClick,
                              icon: const Icon(
                                Icons.comment,
                                color: Colors.black,
                              ),
                            ),
                          )
                        else
                          const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${currentIndex! + 1} / ${widget.galleryItems?.length}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Positioned(
              top: 80,
              left: 15,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white.withOpacity(0.5),
                child: const BackButton(color: Colors.black),
              ),
            ),
            if (widget.onDelete != null)
              Positioned(
                top: 80,
                right: 15,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: widget.onDelete,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
