import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post_item.dart';
import '../models/story_item.dart';
import 'menambah_cerita.dart';
import '../theme/qcumber_colors.dart';
import '../widgets/post_card.dart';
import '../tampilan_utama/feed_header.dart';
import '../pembuatan_feed/post_detail_page.dart';
import '../tampilan_utama/slice_story_bar.dart';
import '../tampilan_utama/story_viewer_page.dart';

/// Halaman Feed Utama Qcumber
/// Header banner di bagian atas dibuat TETAP (FIXED) dan tidak ikut ter-scroll
class FeedPage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const FeedPage({super.key, this.scaffoldKey});

  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Membuka alur pembuatan postingan baru (Figma Create Post & New Post-1)
  void showCreatePostDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewSlicePage(initialMode: 'postingan'),
      ),
    );
  }

  /// Membuka alur pembuatan cerita / Slice baru (Figma New Story & New Post)
  void showAddSliceDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewSlicePage(initialMode: 'cerita'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: QcumberColors.pageBackgroundGradient,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ==============================================================
            // 1. FIXED HEADER (TIDAK IKUT TER-SCROLL SAMA SEKALI)
            // Tulisan "Qcumber / A fresh slice of life" tetap diam di atas layar
            // ==============================================================
            FeedHeader(
              onMenuPressed: () {
                if (widget.scaffoldKey?.currentState?.hasDrawer ?? false) {
                  widget.scaffoldKey?.currentState?.openDrawer();
                } else {
                  Scaffold.maybeOf(context)?.openDrawer();
                }
              },
            ),

            // ==============================================================
            // 2. KONTEN SCROLLABLE (STORIES DAN POSTINGAN FEED)
            // ==============================================================
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),

                  // Baris Stories ("Slice") - Diperbarui secara otomatis saat pengguna membagikan cerita
                  SliverToBoxAdapter(
                    child: ValueListenableBuilder<List<StoryItem>>(
                      valueListenable: StoryRepository.storiesNotifier,
                      builder: (context, stories, child) {
                        return SliceStoryBar(
                          stories: stories,
                          onAddSlice: showAddSliceDialog,
                          onStoryTap: (story) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StoryViewerPage(story: story),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 10)),

                  // Daftar Postingan Feed dengan Aset Asli dan Notched Notch Tab (Otomatis terupdate saat posting baru)
                  ValueListenableBuilder<List<PostItem>>(
                    valueListenable: PostRepository.postsNotifier,
                    builder: (context, posts, child) {
                      return SliverList.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return GestureDetector(
                            onDoubleTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostDetailPage(post: post),
                                ),
                              );
                            },
                            child: PostCard(
                              key: ValueKey(post.id),
                              post: post,
                              onCommentTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PostDetailPage(post: post),
                                  ),
                                );
                              },
                              onShareTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Bagikan postingan @${post.username}',
                                      style: GoogleFonts.poppins(fontSize: 13),
                                    ),
                                    backgroundColor: QcumberColors.primaryGreen,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              onMenuTap: () {
                                _showPostOptionsSheet(context, post);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Ruang padding bawah agar tidak tertutup Floating Bottom Nav
                  const SliverToBoxAdapter(child: SizedBox(height: 95)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Sheet untuk menambahkan Slice/Story baru menggunakan aset lokal
  void showAddSliceSheet(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
      text: 'Anda',
    );
    final List<String> presetImages = [
      'assets/feed/story_your_idol.png',
      'assets/feed/story_thv.png',
      'assets/feed/story_shawn.png',
      'assets/feed/story_peter.png',
    ];
    int selectedImageIndex = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: QcumberColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tambah Slice Baru',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: QcumberColors.primaryGreen,
                    ),
                  ),
                  Text(
                    'Bagikan momen cerita segar hari ini',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: QcumberColors.sageText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nama / Judul Slice',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: nameController,
                    style: GoogleFonts.poppins(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Misal: Cerita Saya',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: QcumberColors.primaryGreen,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Pilih Foto Slice',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: presetImages.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final bool isSelected = selectedImageIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setSheetState(() {
                              selectedImageIndex = index;
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? QcumberColors.primaryGreen
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Image.asset(
                                presetImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        final String name = nameController.text.trim().isEmpty
                            ? 'Cerita Anda'
                            : nameController.text.trim();
                        StoryRepository.addMyStory(
                          imagePath: presetImages[selectedImageIndex],
                          username: name,
                        );

                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Slice "$name" berhasil diunggah!',
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            backgroundColor: QcumberColors.primaryGreen,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: QcumberColors.primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Unggah Slice',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Sheet untuk membuat Postingan Baru menggunakan aset lokal
  void showCreatePostSheet(BuildContext context) {
    final TextEditingController locationController = TextEditingController(
      text: 'Jakarta, Indonesia',
    );
    final TextEditingController captionController = TextEditingController();
    final List<String> presetPostImages = [
      'assets/feed/post_thv.png',
      'assets/feed/post_shawn.png',
      'assets/feed/post_bali.png',
      'assets/feed/post_peter.png',
    ];
    int selectedPostImage = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: QcumberColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Buat Postingan Baru',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: QcumberColors.primaryGreen,
                      ),
                    ),
                    Text(
                      'Bagikan foto dan cerita segar ke feed Qcumber',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: QcumberColors.sageText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Lokasi',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: locationController,
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                          color: QcumberColors.primaryGreen,
                          size: 20,
                        ),
                        hintText: 'Misal: Jakarta, Indonesia',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: QcumberColors.primaryGreen,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Caption Cerita',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: captionController,
                      maxLines: 3,
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Tuliskan momen segar hari ini...',
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: QcumberColors.primaryGreen,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Pilih Foto Postingan',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: presetPostImages.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final bool isSelected = selectedPostImage == index;
                          return GestureDetector(
                            onTap: () {
                              setSheetState(() {
                                selectedPostImage = index;
                              });
                            },
                            child: Container(
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? QcumberColors.primaryGreen
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(11),
                                child: Image.asset(
                                  presetPostImages[selectedPostImage],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final String loc =
                              locationController.text.trim().isEmpty
                              ? 'Indonesia'
                              : locationController.text.trim();
                          final String cap =
                              captionController.text.trim().isEmpty
                              ? 'Menikmati momen segar bersama Qcumber hari ini!'
                              : captionController.text.trim();

                          PostRepository.addPost(
                            imagePath: presetPostImages[selectedPostImage],
                            caption: cap,
                            location: loc,
                          );

                          Navigator.pop(ctx);

                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeOut,
                            );
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Postingan berhasil dibagikan ke Feed!',
                              ),
                              backgroundColor: QcumberColors.primaryGreen,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: QcumberColors.primaryGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Bagikan Postingan',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Bottom sheet opsi postingan saat menu kebab diklik
  void _showPostOptionsSheet(BuildContext context, PostItem post) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.link_rounded,
                  color: QcumberColors.primaryGreen,
                ),
                title: Text(
                  'Salin Tautan',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tautan postingan berhasil disalin'),
                      backgroundColor: QcumberColors.primaryGreen,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.report_problem_outlined,
                  color: Colors.redAccent,
                ),
                title: Text(
                  'Laporkan Postingan',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
