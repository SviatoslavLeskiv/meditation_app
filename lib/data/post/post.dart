class Post {
  final String title;
  final String description;
  final String photoUrl;
  final String ownerName;
  final String ownerPhotoUrl;
  final String href;

  Post({
    required this.title,
    required this.description,
    required this.photoUrl,
    required this.ownerName,
    required this.ownerPhotoUrl,
    required this.href,
  });
}

List<Post> meditationPosts = [
  Post(
    title: "Початкова медитація",
    description: "Засвоюйте основи медитації для початківців.",
    photoUrl:
        "https://life.pravda.com.ua/images/doc/e/b/eb955b4-depositphotos-haydmitriy-755.jpg",
    ownerName: "John Doe",
    ownerPhotoUrl: "https://example.com/john_doe.jpg",
    href: 'https://life.pravda.com.ua/health/2021/03/7/244150/',
  ),
  Post(
    title: "Медитація для стресостійкості",
    description: "Навчіться медитувати для зниження стресу та тривожності.",
    photoUrl:
        "https://cdn.village.com.ua/the-village.com.ua/post_image-image/bsx-rPgtsURgJjtv6rY97A-article.jpg",
    ownerName: "Jane Smith",
    ownerPhotoUrl: "https://example.com/jane_smith.jpg",
    href:
        'https://www.village.com.ua/village/city/good-habit/274597-korisna-zvichka-meditatsiya',
  ),
  Post(
    title: "Ранкова медитація",
    description: "Почніть свій день з енергетичної ранкової медитації.",
    photoUrl:
        "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/fd/16/e1/fd16e126-debd-93f4-c7c5-3d2ca9f1c177/859776799096_cover.jpg/632x632bb.webp",
    ownerName: "Alice Johnson",
    ownerPhotoUrl:
        "https://music.apple.com/ua/song/%D1%80%D0%B0%D0%BD%D0%BA%D0%BE%D0%B2%D0%B0-%D0%BC%D0%B5%D0%B4%D0%B8%D1%82%D0%B0%D1%86%D1%96%D1%8F/1701624724",
    href: '',
  ),
  Post(
    title: "Медитація для кращого сну",
    description: "Як медитація може поліпшити якість вашого сну.",
    photoUrl:
        "https://images.glavred.info/2020_07/thumb_files/1200x0/1594370545-4068.jpg?r=892874",
    ownerName: "Mike Brown",
    ownerPhotoUrl: "https://example.com/mike_brown.jpg",
    href:
        'https://glavred.net/health/meditaciya-dlya-krashchogo-snu-3-sposobi-10192781.html',
  ),
  Post(
    title: "Медитація і творчість",
    description: "Як медитація впливає на творчість та інновації.",
    photoUrl: "https://ukr.media/static/ba/aimg/webp/4/2/6/426404_1.webp",
    ownerName: "Sara White",
    ownerPhotoUrl: "https://ukr.media/static/ba/aimg/webp/4/2/6/426404_1.webp",
    href: 'https://ukr.media/psihologiya/426404/',
  ),
  Post(
    title: "Медитація для внутрішнього спокою",
    description: "Знаходьте внутрішній спокій через регулярну медитацію.",
    photoUrl:
        "https://www.epochtimes.com.ua/sites/default/files/field/image/09-2014/73e019a060f54546b8f8e74d361a65da.jpg",
    ownerName: "David Lee",
    ownerPhotoUrl: "https://example.com/david_lee.jpg",
    href:
        'https://www.epochtimes.com.ua/health/traditions/medytatsiya-shcho-tse-i-yak-vona-vykonuetsya-112785.html',
  ),
];
