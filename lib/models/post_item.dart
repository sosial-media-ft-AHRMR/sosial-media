import 'package:flutter/foundation.dart';

/// Model untuk item postingan pada Feed Qcumber
/// Menggunakan pemanggilan aset lokal (Image.asset) sesuai permintaan pengguna
class PostItem {
  final String id;
  final String username;
  final String location;
  final String userAvatarUrl;
  final String postImageUrl;
  final String timeAgo;
  final String caption;
  final bool isVerified;
  bool isLiked;
  bool isSaved;
  int likeCount;

  PostItem({
    required this.id,
    required this.username,
    required this.location,
    required this.userAvatarUrl,
    required this.postImageUrl,
    required this.timeAgo,
    required this.caption,
    this.isVerified = false,
    this.isLiked = false,
    this.isSaved = true,
    this.likeCount = 128,
  });

  /// 5 Postingan mock dengan gambar asli lokal hasil ekspor Figma
  static List<PostItem> getMockPosts() {
    return [
      PostItem(
        id: 'post_1',
        username: 'thv',
        location: 'Seoul, South Korea',
        isVerified: true,
        userAvatarUrl: 'assets/feed/avatar_thv.png',
        postImageUrl: 'assets/feed/post_thv.png',
        timeAgo: '24 jam yang lalu',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        likeCount: 2540,
        isSaved: true,
      ),
      PostItem(
        id: 'post_2',
        username: 'Shawn',
        location: 'New York, Amerika Serikat',
        isVerified: false,
        userAvatarUrl: 'assets/feed/avatar_shawn.png',
        postImageUrl: 'assets/feed/post_shawn.png',
        timeAgo: '1 hari yang lalu',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        likeCount: 915,
        isSaved: true,
      ),
      PostItem(
        id: 'post_3',
        username: 'Your.Idol',
        location: 'Bali, Indonesia',
        isVerified: true,
        userAvatarUrl: 'assets/feed/avatar_your_idol.png',
        postImageUrl: 'assets/feed/post_bali.png',
        timeAgo: '24 jam yang lalu',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        likeCount: 4210,
        isSaved: true,
      ),
      PostItem(
        id: 'post_4',
        username: 'Peter',
        location: 'Pinewood, Inggris',
        isVerified: true,
        userAvatarUrl: 'assets/feed/avatar_peter.png',
        postImageUrl: 'assets/feed/post_peter.png',
        timeAgo: '30 menit yang lalu',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        likeCount: 380,
        isSaved: true,
      ),
      PostItem(
        id: 'post_5',
        username: 'Mr.Shadow',
        location: 'Amsterdam, Belanda',
        isVerified: false,
        userAvatarUrl: 'assets/feed/avatar_mrshadow.png',
        postImageUrl: 'assets/feed/post_amsterdam.png',
        timeAgo: '5 hari yang lalu',
        caption:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        likeCount: 1650,
        isSaved: true,
      ),
    ];
  }
}

/// Repository terpusat untuk mengelola postingan Feed Qcumber
/// Menghubungkan form Buat Postingan (CreatePostPage) dengan FeedPage
class PostRepository {
  static final ValueNotifier<List<PostItem>> postsNotifier =
      ValueNotifier<List<PostItem>>(PostItem.getMockPosts());

  /// Menambahkan postingan baru langsung ke paling atas feed
  static void addPost({
    required String imagePath,
    required String caption,
    String? location,
  }) {
    final currentList = List<PostItem>.from(postsNotifier.value);
    final newPost = PostItem(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      username: 'Qcumber',
      location: location ?? 'Jakarta, Indonesia',
      isVerified: true,
      userAvatarUrl: 'assets/feed/avatar_qcumber.jpg',
      postImageUrl: imagePath,
      timeAgo: 'Baru saja',
      caption: caption.isEmpty ? 'A fresh slice of life #Qcumber' : caption,
      likeCount: 0,
    );
    currentList.insert(0, newPost);
    postsNotifier.value = currentList;
  }
}
