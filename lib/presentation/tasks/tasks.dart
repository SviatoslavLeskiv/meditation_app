import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meditation_app/data/task/tasks.dart';
import 'package:url_launcher/url_launcher.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe1ecef),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            floating: true,
            primary: false,
            forceMaterialTransparency: false,
            foregroundColor: Color(0xFFe1ecef),
            backgroundColor: Color(0xFFe1ecef),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Вправи дня:',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: tasksMock
                  .map((task) => _buildTaskCard(context, task: task))
                  .toList(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
    BuildContext context, {
    required Task task,
  }) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    late String formattedDate;
    var postDate = DateTime.utc(task.time.year, task.time.month, task.time.day);
    var nowDate = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (nowDate.compareTo(postDate) == 0) {
      formattedDate = 'Сьогодні';
    } else {
      if (nowDate.day - postDate.day == 1) {
        formattedDate = 'Вчора';
      } else {
        formattedDate = formatter.format(task.time);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedDate.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://maximum.fm/joga-v-domashnih-umovah-prosti-vpravi-yaki-zroblyat-vas-zdorovishimi_n149130');
              await launchUrl(url);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 250,
                    width: 250,
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      task.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      Text(
                        task.title,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
