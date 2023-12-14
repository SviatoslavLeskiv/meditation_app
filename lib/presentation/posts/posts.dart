import 'package:flutter/material.dart';
import 'package:meditation_app/data/post/post.dart';
import 'package:url_launcher/url_launcher.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

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
                'Цікаві статті:',
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
              children: meditationPosts
                  .map((post) => _buildPostCard(context, postData: post))
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

  Widget _buildPostCard(
    BuildContext context, {
    required Post postData,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: InkWell(
        onTap: () async {
          final Uri url = Uri.parse(postData.href);
          await launchUrl(url);
        },
        child: Container(
          height: 125,
          width: MediaQuery.of(context).size.width,
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
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 100,
                width: 100,
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  postData.photoUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        postData.description,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${postData.title} by ${postData.ownerName}',
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
