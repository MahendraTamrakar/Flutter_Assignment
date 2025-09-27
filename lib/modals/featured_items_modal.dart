class FeaturedItemsModal {
  String name;
  String imgPath;
  String caption;

  FeaturedItemsModal({
    required this.name,
    required this.imgPath,
    required this.caption,
  });

  static List<FeaturedItemsModal> getFeaturedItems() {
    List<FeaturedItemsModal> featuredItems =[];

    featuredItems.add(
      FeaturedItemsModal(
        name: 'Smart Kitchen Set',
        imgPath: 'assets/images/kitchenSet.png',
        caption: 'Upgrade your cocking experience',
      ),
    );

    featuredItems.add(
      FeaturedItemsModal(
        name: 'Tech Bundel',
        imgPath: 'assets/images/bundle.png',
        caption: 'Latest gadgets for enthusiasts',
      ),
    );

    featuredItems.add(
      FeaturedItemsModal(
        name: 'Sports Essentials',
        imgPath: 'assets/images/sport.jpg',
        caption: 'Upgrade your playing experience',
      ),
    );

    featuredItems.add(
      FeaturedItemsModal(
        name: 'Books',
        imgPath: 'assets/images/books.jpg',
        caption: 'Grow your knowledge with variety of Books',
      ),
    );

    return featuredItems;
  }
}