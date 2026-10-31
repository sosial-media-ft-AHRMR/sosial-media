import 'package:flutter/material.dart';
import 'membuat_postingan.dart';
import 'membuat_story.dart';
import 'menambah_cerita.dart';

export 'membuat_postingan.dart';
export 'membuat_story.dart';
export 'menambah_cerita.dart';

/// Helper navigasi cepat untuk alur pembuatan postingan atau cerita baru
class PembuatanFeedNavigator {
  /// Membuka layar New Slice (pemilih media & kamera dengan toggle cerita/postingan)
  static void openNewSlice(BuildContext context, {String initialMode = 'postingan'}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewSlicePage(initialMode: initialMode),
      ),
    );
  }

  /// Membuka formulir Create Slice (postingan) secara langsung
  static void openCreatePost(BuildContext context, {String imagePath = 'assets/feed/cake_swan.png'}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePostPage(imagePath: imagePath),
      ),
    );
  }

  /// Membuka pratinjau Story secara langsung
  static void openStoryPreview(BuildContext context, {String imagePath = 'assets/feed/cake_swan.png'}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryPreviewPage(imagePath: imagePath),
      ),
    );
  }
}

