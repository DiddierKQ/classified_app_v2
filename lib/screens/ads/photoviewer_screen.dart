import 'package:classified_app_v2/utils/colors_utils.dart';
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:classified_app_v2/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class PhotoViewerScreen extends StatelessWidget {
  //const PhotoViewerScreen({ Key? key }) : super(key: key);

  var adData = {};
  String img;

  PhotoViewerScreen({
    Key? key,
    required this.adData,
    this.img = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    return Scaffold(
      backgroundColor: CustomColors.scaffoldBackgroundColor,
      appBar: AppBarWidget(
        title: adData['title'],
        enableReturnButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(
          SizeConfig.screenWidth * 0.02,
        ),
        child: img != '' ? buildPhotoView() : buildViewGallery(),
      ),
    );
  }

  // Create a view of a single picture
  PhotoView buildPhotoView() {
    return PhotoView(
      imageProvider: NetworkImage(img),
    );
  }

  // Create a gallery view of multiple pictures
  PhotoViewGallery buildViewGallery() {
    return PhotoViewGallery.builder(
      itemCount: adData['images'].length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          basePosition: Alignment.center,
          imageProvider: NetworkImage(adData['images'][index]),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        );
      },
      scrollPhysics: const BouncingScrollPhysics(),
      backgroundDecoration: const BoxDecoration(
        color: CustomColors.scaffoldBackgroundColor,
      ),
      loadingBuilder: (context, event) => const Center(
        child: SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            color: CustomColors.buttonColor,
          ),
        ),
      ),
    );
  }
}
