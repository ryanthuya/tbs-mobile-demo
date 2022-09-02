// //JSOM Format

// {
// "q": null,
// "books": {
// "current_page": 1,
// "data": [
// {
// "id": 11,
// "title": "အရိုးပွအရိုးပါးရောဂါအကြောင်း     သိကောင်းစရာ",
// "desc": "လူတစ်ယောက် အရိုးပွ အရိုးပါးရောဂါဖြစ်နိုင်ခြင်း၊ မဖြစ်နိုင်ခြင်းကို အဓိကအဆုံးအဖြတ်ပေး နိုင်တဲ့ အချက် ၂ ချက် က..",
// "price": 20,
// "rental_price": null,
// "slug": "https://today.s3.ap-southeast-1.amazonaws.com/img/books/bf0b568d-7229-42b3-befb-5c249d6bca32/thumb.jpg?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASR26BWNNHCLKK6EZ%2F20220902%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T002847Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=3608b5e87d507e6c65844c362813cc009296807229dba4d96512908d8b669b3e",
// "stock": 100,
// "is_free_shipping": 0,
// "is_publish": 1,
// "published_at": "2011-03-12 11:00:00",
// "created_at": "2011-03-14T03:11:49.000000Z",
// "updated_at": "2022-05-26T04:06:55.000000Z",
// "product_id": 66,
// "image_url": "data/Dr-Hla-Kyi(Bone).jpg",
// "pages": null,
// "width": null,
// "height": null,
// "length": null,
// "barcode": null
// }

class Book {
  final int id;
  final String title;
  final String desc;
  final int price;
  final int rental_price;
  final String slug;
  final String  is_publish;
  final DateTime published_at;
  final DateTime created_at;
  final DateTime updated_at;
  final int product_id;
  final String image_url;
  final String pages;
  final int width;
  final int height;
  final String length;
  final String barcode;

      Book({required this.id, required this.title,required  this.desc,required this.price, required this.rental_price,
        required this.slug,required this.is_publish,required this.published_at,required this.created_at,
        required this.updated_at,required this.product_id,required this.image_url,required this.pages,
        required this.width,required this.height,required this.length,required this.barcode});


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
    'rental_price':rental_price,
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