import 'package:flutter/foundation.dart';

/// Model untuk item pada baris Stories ("Slice")
/// Mendukung multi-slide per akun (sesuai Figma Story.png & Story 2.png)
class StoryItem {
  final String id;
  final String username;
  final String imageUrl;
  final List<String> slides;
  final String? userAvatarUrl;
  final bool isVerified;
  final bool isAddSlice;
  final bool isMyStory;

  const StoryItem({
    required this.id,
    required this.username,
    required this.imageUrl,
    this.slides = const [],
    this.userAvatarUrl,
    this.isVerified = false,
    this.isAddSlice = false,
    this.isMyStory = false,
  });

  /// Mengembalikan daftar slide foto story, jika kosong maka menggunakan imageUrl utama
  List<String> get effectiveSlides {
    if (slides.isNotEmpty) return slides;
    if (imageUrl.isNotEmpty) return [imageUrl];
    return ['assets/feed/story_your_idol.png'];
  }

  /// Data mock sesuai 100% dengan daftar akun dan aset asli dari Figma
  static List<StoryItem> getMockStories() {
    return const [
      // 0. Tombol Add a Slice
      StoryItem(
        id: 'slice_add',
        username: 'Add a Slice',
        imageUrl: '',
        isAddSlice: true,
      ),

      // 1. Akun Your.Idol dengan 2 slide cerita (Figma Story.png & Story 2.png)
      StoryItem(
        id: 'slice_1',
        username: 'Your.Idol',
        imageUrl: 'assets/feed/story_your_idol.png',
        slides: [
          'assets/feed/story_snow_bg.png',
          'assets/feed/story_stars_bg.png',
        ],
        userAvatarUrl: 'assets/feed/avatar_your_idol.png',
        isVerified: true,
      ),

      // 2. MrShadow
      StoryItem(
        id: 'slice_2',
        username: 'MrShadow',
        imageUrl: 'assets/feed/story_mrshadow.png',
        slides: ['assets/feed/post_amsterdam.png'],
        userAvatarUrl: 'assets/feed/avatar_mrshadow.png',
      ),

      // 3. thv
      StoryItem(
        id: 'slice_3',
        username: 'thv',
        imageUrl: 'assets/feed/story_thv.png',
        slides: ['assets/feed/post_thv.png'],
        userAvatarUrl: 'assets/feed/avatar_thv.png',
        isVerified: true,
      ),

      // 4. Shawn
      StoryItem(
        id: 'slice_4',
        username: 'Shawn',
        imageUrl: 'assets/feed/story_shawn.png',
        slides: ['assets/feed/post_shawn.png'],
        userAvatarUrl: 'assets/feed/avatar_shawn.png',
      ),

      // 5. Peter
      StoryItem(
        id: 'slice_5',
        username: 'Peter',
        imageUrl: 'assets/feed/story_peter.png',
        slides: ['assets/feed/post_peter.png'],
        userAvatarUrl: 'assets/feed/avatar_peter.png',
      ),

      // 6. Rangga
      StoryItem(
        id: 'slice_6',
        username: 'Rangga',
        imageUrl: 'assets/feed/story_rangga.png',
        slides: ['assets/feed/story_rangga.png'],
        userAvatarUrl: 'assets/feed/story_rangga.png',
      ),

      // 7. Spider
      StoryItem(
        id: 'slice_7',
        username: 'Spider',
        imageUrl: 'assets/feed/story_spider.png',
        slides: ['assets/feed/story_spider.png'],
        userAvatarUrl: 'assets/feed/story_spider.png',
      ),
    ];
  }
}

/// Repository terpusat untuk mengelola cerita aktif dalam aplikasi
/// Menghubungkan pembuatan cerita (Story Anda) dengan tampilan feed utama
class StoryRepository {
  static final ValueNotifier<List<StoryItem>> storiesNotifier =
      ValueNotifier<List<StoryItem>>(StoryItem.getMockStories());

  /// Menambahkan atau memperbarui cerita pengguna ("Cerita Anda")
  static void addMyStory({
    required String imagePath,
    String username = 'Cerita Anda',
    String avatarUrl = 'assets/feed/alexumber_avatar.jpg',
  }) {
    final currentList = List<StoryItem>.from(storiesNotifier.value);

    // Cari apakah sudah ada "Cerita Anda"
    final existingIndex = currentList.indexWhere(
      (item) => item.isMyStory || item.id == 'my_story',
    );

    if (existingIndex != -1) {
      // Tambahkan slide baru ke cerita yang sudah ada
      final existingStory = currentList[existingIndex];
      final updatedSlides = List<String>.from(existingStory.slides)
        ..add(imagePath);
      currentList[existingIndex] = StoryItem(
        id: existingStory.id,
        username: existingStory.username,
        imageUrl: imagePath,
        slides: updatedSlides,
        userAvatarUrl: avatarUrl,
        isMyStory: true,
      );
    } else {
      // Masukkan cerita baru tepat di posisi setelah "Add a Slice" (index 1)
      final newStory = StoryItem(
        id: 'my_story',
        username: username,
        imageUrl: imagePath,
        slides: [imagePath],
        userAvatarUrl: avatarUrl,
        isMyStory: true,
      );
      currentList.insert(1, newStory);
    }

    storiesNotifier.value = currentList;
  }
}
