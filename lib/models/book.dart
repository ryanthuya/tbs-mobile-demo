
class Book {
  final int id;
  final String title;
  final String desc;
  final int price;
  final int? rental_price;
  final String slug;
  final int?  is_publish;
  final String published_at;
  final String created_at;
  final String updated_at;
  final int? product_id;
  final String image_url;
  final int? pages;
  final int? width;
  final int? height;
  final String? length;
  final String? barcode;

      Book({
        required this.id,
        required this.title,
        required  this.desc,
        required this.price,
        required this.rental_price,
        required this.slug,
        required this.is_publish,
        required this.published_at,
        required this.created_at,
        required this.updated_at,
        required this.product_id,
        required this.image_url,
        required this.pages,
        required this.width,
        required this.height,
        required this.length,
        required this.barcode
      });


  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      price: json['price'],
      rental_price: json['rental_price'],
      slug: json['slug'],
      is_publish: json['is_publish'],
      published_at: json['published_at'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      product_id: json['product_id'],
      image_url: json['image_url'],
      pages: json['pages'],
      width: json['width'],
      height: json['height'],
      length: json['length'],
      barcode: json['barcode'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'desc': desc,
    'price':price,
    // 'rental_price':rental_price,
    'slug':slug,
    'is_publish':is_publish,
    'published_at' : published_at,
    'created_at' : created_at,
    'updated_at' : updated_at,
    'product_id' : product_id,
    'image_url'  : image_url,
    'pages': pages,
    'width': width,
    'height' : height,
    'length':length,
    'barcode':barcode,
  };
}