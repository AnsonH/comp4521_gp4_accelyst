import 'package:comp4521_gp4_accelyst/widgets/photo/photo_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// A photo carousel with zoom controls.
///
/// Created using the [photo_view_gallery](https://pub.dev/documentation/photo_view/latest/photo_view_gallery/photo_view_gallery-library.html) package.
class PhotoCarousel extends StatefulWidget {
  final List<PhotoGridItemData> carouselItems;
  final int initialIndex;

  // Parameters for PhotoViewGallery
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final PageController pageController;

  /// Creates a photo carousel.
  ///
  /// [loadingBuilder], [backgroundDecoration], and [pageController] are parameters for the [PhotoViewGallery] widget constructor.
  /// See the [PhotoViewGallery documentation](https://pub.dev/documentation/photo_view/latest/photo_view_gallery/PhotoViewGallery-class.html)
  PhotoCarousel(
    this.carouselItems, {
    Key? key,
    this.initialIndex = 0,
    this.loadingBuilder,
    this.backgroundDecoration,
  })  : pageController = PageController(initialPage: initialIndex),
        super(key: key);

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  late int currentIndex = widget.initialIndex;

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment:
              AlignmentDirectional.bottomEnd, // "Image N" at bottom right
          children: [
            PhotoViewGallery.builder(
              itemCount: widget.carouselItems.length,
              builder: _buildItem,
              onPageChanged: _onPageChanged,
              scrollPhysics: const BouncingScrollPhysics(),
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final PhotoGridItemData item = widget.carouselItems[index];

    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item.resource),
      initialScale: PhotoViewComputedScale.contained,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
