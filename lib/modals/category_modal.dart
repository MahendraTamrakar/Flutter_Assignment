class CategoryModal {
  
  String name;

  CategoryModal({
    required this.name,
  });

  static List<CategoryModal> getCategories() {
    List<CategoryModal> categories = [];

    categories.add(
      CategoryModal(name: "All"),
    );

    categories.add(
      CategoryModal(name: "Electronics"),
    );

    categories.add(
      CategoryModal(name: "Home Goods"),
    );

    categories.add(
      CategoryModal(name: "Sports"),
    );

    categories.add(
      CategoryModal(name: "Books"),
    );

    return categories;
  }

}