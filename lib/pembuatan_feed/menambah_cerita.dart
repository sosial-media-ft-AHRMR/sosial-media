import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/qcumber_colors.dart';
import 'membuat_postingan.dart';
import 'membuat_story.dart';

/// Halaman Pemilih Media "New Slice" Sesuai 100% dengan Figma New Story.png & New Post-1.png
/// Fitur:
/// - Bilah navigasi atas: Tombol Tutup (X), Judul "New Slice", Tombol Lanjut (>)
/// - Area bidik kamera atas dengan ikon kamera garis tebal (#165540)
/// - Lembar galeri bawah 3 kolom foto lokal assets
/// - Kapsul toggle mengambang di bawah antara "cerita" dan "postingan"
/// - Berpindah halaman tujuan sesuai mode yang aktif:
///   * Mode "cerita" -> Ke halaman pratinjau cerita (StoryPreviewPage / New Post.png)
///   * Mode "postingan" -> Ke formulir unggah postingan (CreatePostPage / Create Post.png)
class NewSlicePage extends StatefulWidget {
  final String initialMode; // 'cerita' atau 'postingan'

  const NewSlicePage({
    super.key,
    this.initialMode = 'postingan',
  });

  @override
  State<NewSlicePage> createState() => _NewSlicePageState();
}

class _NewSlicePageState extends State<NewSlicePage> {
  late String _selectedMode;
  int _selectedPhotoIndex = 0;
  final ImagePicker _picker = ImagePicker();

  // Daftar Foto Galeri (Bisa bertambah saat pengguna mengambil foto kamera / memilih dari galeri HP)
  final List<String> _galleryPhotos = [
    'assets/feed/cake_swan.png',
    'assets/feed/alexumber_post1.jpg',
    'assets/feed/alexumber_post2.jpg',
    'assets/feed/alexumber_post3.jpg',
    'assets/feed/alexumber_post4.jpg',
    'assets/feed/post_thv.png',
    'assets/feed/post_shawn.png',
    'assets/feed/post_peter.png',
    'assets/feed/post_amsterdam.png',
  ];

  @override
  void initState() {
    super.initState();
    _selectedMode = widget.initialMode;
  }

  /// Membuka kamera perangkat secara langsung
  Future<void> _openCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 88,
      );
      if (photo != null) {
        setState(() {
          _galleryPhotos.insert(0, photo.path);
          _selectedPhotoIndex = 0;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tidak dapat membuka kamera: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  /// Membuka galeri perangkat pengguna secara langsung
  Future<void> _openGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 88,
      );
      if (image != null) {
        setState(() {
          _galleryPhotos.insert(0, image.path);
          _selectedPhotoIndex = 0;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tidak dapat membuka galeri: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _proceedToNext() {
    if (_galleryPhotos.isEmpty) return;
    final selectedImage = _galleryPhotos[_selectedPhotoIndex];
    if (_selectedMode == 'cerita') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StoryPreviewPage(imagePath: selectedImage),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePostPage(imagePath: selectedImage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: QcumberColors.pageBackgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  // 1. Bilah Atas: Tombol X, Judul "New Slice", Tombol >
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tombol Tutup (X)
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDEEBCE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Color(0xFF165540),
                              size: 22,
                            ),
                          ),
                        ),

                        // Judul "New Slice" dengan bayangan halus
                        Text(
                          'New Slice',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF165540),
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),

                        // Tombol Lanjut (>)
                        GestureDetector(
                          onTap: _proceedToNext,
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDEEBCE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFF165540),
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. Area Pratinjau Kamera Atas (Viewfinder & Buka Kamera HP)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: _openCamera,
                      child: Container(
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDEEBCE),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFB5D4A2),
                            width: 1.5,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Tampilkan foto yang sedang dipilih di jendela pratinjau atas
                            if (_galleryPhotos.isNotEmpty)
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: _buildImageTile(
                                    _galleryPhotos[_selectedPhotoIndex],
                                  ),
                                ),
                              ),

                            // Tombol Buka Kamera Mengambang
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF165540).withValues(alpha: 0.88),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.camera_alt_rounded,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Buka Kamera',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 3. Lembar Galeri Foto 3 Kolom & Akses Galeri HP
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Header Galeri Foto dengan Tombol "Buka Galeri HP"
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Galeri',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF165540),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Color(0xFF165540),
                                      size: 24,
                                    ),
                                  ],
                                ),

                                // Tombol Aksi Langsung ke Galeri Perangkat HP
                                GestureDetector(
                                  onTap: _openGallery,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDEEBCE),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: const Color(0xFFB5D4A2),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.photo_library_outlined,
                                          size: 16,
                                          color: Color(0xFF165540),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Buka Galeri HP',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF165540),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Grid Galeri Foto
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.fromLTRB(6, 6, 6, 80),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                  childAspectRatio: 1.0,
                                ),
                                itemCount: _galleryPhotos.length,
                                itemBuilder: (context, index) {
                                  final photoPath = _galleryPhotos[index];
                                  final isSelected = _selectedPhotoIndex == index;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedPhotoIndex = index;
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Container(
                                              color: const Color(0xFFDEEBCE),
                                              child: _buildImageTile(photoPath),
                                            ),
                                          ),
                                        ),

                                        // Highlight border jika terpilih
                                        if (isSelected)
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                  color: const Color(0xFF165540),
                                                  width: 3.5,
                                                ),
                                                color: Colors.black.withValues(
                                                  alpha: 0.15,
                                                ),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Color(0xFF165540),
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // 4. Kapsul Toggle Mengambang di Bawah: "cerita" | "postingan"
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA5C996).withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol Mode Cerita
                        GestureDetector(
                          onTap: () {
                            setState(() => _selectedMode = 'cerita');
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedMode == 'cerita'
                                  ? const Color(0xFFDEEBCE)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: _selectedMode == 'cerita'
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.08),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Text(
                              'cerita',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: _selectedMode == 'cerita'
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: const Color(0xFF165540),
                              ),
                            ),
                          ),
                        ),

                        // Tombol Mode Postingan
                        GestureDetector(
                          onTap: () {
                            setState(() => _selectedMode = 'postingan');
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedMode == 'postingan'
                                  ? const Color(0xFFDEEBCE)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: _selectedMode == 'postingan'
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.08),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Text(
                              'postingan',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: _selectedMode == 'postingan'
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: const Color(0xFF165540),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageTile(String photoPath) {
    if (photoPath.startsWith('assets/')) {
      return Image.asset(
        photoPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(
            Icons.image_outlined,
            size: 32,
            color: Color(0xFF165540),
          ),
        ),
      );
    } else {
      return Image.file(
        File(photoPath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(
            Icons.image_outlined,
            size: 32,
            color: Color(0xFF165540),
          ),
        ),
      );
    }
  }
}
