import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeBanners extends StatelessWidget {
  HomeBanners({super.key});
  final List<String> banners = [
    'assets/images/banners/b2.jpg',
    'assets/images/banners/b3.jpg',
    'assets/images/banners/b4.jpg',
    'assets/images/banners/b5.jpg',
    'assets/images/banners/b6.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        aspectRatio: 16 / 9,
        viewportFraction: 0.7,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: banners.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                //width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Stack(
                  children: [
                    Card(
                      elevation: 2,
                      child: CachedNetworkImage(
                        imageUrl: '',
                        placeholder: (context, url) => Container(
                          height: 150,
                          width: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(banner),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 150,
                          width: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(banner),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          height: 150,
                          width: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        /*httpHeaders: ImageLoaderHelper.instance.getHeader(),
                        cacheManager: ImageLoaderHelper.instance
                            .cacheManager(type.imageUrl!),*/
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
