class Task {
  final String title;
  final DateTime time;
  final String imageUrl;

  Task({
    required this.title,
    required this.time,
    required this.imageUrl,
  });
}

final tasksMock = [
  Task(
    title: 'Поза лотоса',
    time: DateTime.now(),
    imageUrl:
        'https://maximum.fm/uploads/media_news/2018/10/76344a1b8c548968c5fa5f7703b507815df06fef.jpg?w=640&il&q=80&output=jpg&v=5316',
  ),
  Task(
    title: 'Нахил вперед',
    time: DateTime.now().subtract(const Duration(days: 1)),
    imageUrl:
        'https://maximum.fm/uploads/media_news/2018/10/1c9a7d7f2d8f55d64c248d9dd991ce7c6721ba65.jpg?w=640&il&q=80&output=jpg&v=5316',
  ),
  Task(
    title: 'Поза дитини',
    time: DateTime.now().subtract(const Duration(days: 2)),
    imageUrl:
        'https://maximum.fm/uploads/media_news/2018/10/32b5f5d940bb0e8e2acefdc2bca12338a47fff92.jpg?w=640&il&q=80&output=jpg&v=5316',
  ),
  Task(
    title: 'Скручування вбік',
    time: DateTime.now().subtract(const Duration(days: 3)),
    imageUrl:
        'https://maximum.fm/uploads/media_news/2018/10/1da28faa6f94af581cf092cf5f5e6d0fae094ec3.jpg?w=640&il&q=80&output=jpg&v=5316',
  ),
  Task(
    title: 'Поза богині',
    time: DateTime.now().subtract(const Duration(days: 4)),
    imageUrl:
        'https://maximum.fm/uploads/media_news/2018/10/62136cc9d8408b5a5540f5e61dd922bef0bae970.jpg?w=640&il&q=80&output=jpg&v=5316',
  ),
];
