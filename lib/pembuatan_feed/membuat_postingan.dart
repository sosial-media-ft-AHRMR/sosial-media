import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_item.dart';
import '../theme/qcumber_colors.dart';

/// Halaman Buat Postingan Baru Sesuai 100% dengan Figma Create Post.png
/// Fitur:
/// - Judul "Create Slice" dengan gradasi latar belakang resmi Qcumber
/// - Pratinjau carousel foto postingan yang dipilih
/// - Input caption fleksibel ("Tambahkan caption...")
/// - Tombol cepat tagar (#) dan sebutan (@)
/// - Pemilihan lokasi dengan deretan chip negara/kota
/// - Pengaturan privasi interaktif (Nonaktifkan komentar & Jangan bagikan)
/// - Tombol "Mulai Awal" (reset) dan "Posting" (unggah ke feed)
class CreatePostPage extends StatefulWidget {
  final String imagePath;

  const CreatePostPage({
    super.key,
    this.imagePath = 'assets/feed/cake_swan.png',
  });

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late List<String> _photos;
  String? _selectedLocation;
  bool _disableComments = false;
  bool _preventShare = false;

  final List<String> _locations = [
    'Afghanistan',
    'Aljazair',
    'Australia',
    'Belanda',
    'Cina',
    'Indonesia',
    'New York',
    'Seoul',
  ];

  @override
  void initState() {
    super.initState();
    _photos = [widget.imagePath];
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickAdditionalPhoto() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pilih Sumber Foto Tambahan',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF165540),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF165540)),
                title: Text('Kamera', style: GoogleFonts.poppins(fontSize: 14)),
                onTap: () async {
                  Navigator.pop(ctx);
                  final photo = await _picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    setState(() => _photos.add(photo.path));
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined, color: Color(0xFF165540)),
                title: Text('Galeri HP', style: GoogleFonts.poppins(fontSize: 14)),
                onTap: () async {
                  Navigator.pop(ctx);
                  final photo = await _picker.pickImage(source: ImageSource.gallery);
                  if (photo != null) {
                    setState(() => _photos.add(photo.path));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _captionController.clear();
      _selectedLocation = null;
      _disableComments = false;
      _preventShare = false;
      _photos = [widget.imagePath];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulir direset ke awal'),
        backgroundColor: Color(0xFF165540),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _submitPost() {
    final caption = _captionController.text.trim();

    // Simpan postingan baru ke PostRepository terpusat agar langsung tampil di feed
    PostRepository.addPost(
      imagePath: _photos.isNotEmpty ? _photos.first : widget.imagePath,
      caption: caption,
      location: _selectedLocation,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          caption.isNotEmpty
              ? 'Postingan "$caption" berhasil diunggah!'
              : 'Postingan baru berhasil dibagikan!',
        ),
        backgroundColor: const Color(0xFF165540),
        duration: const Duration(seconds: 2),
      ),
    );

    // Kembali ke halaman feed utama
    Navigator.of(context).popUntil((route) => route.isFirst);
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
          child: Column(
            children: [
              // 1. Top Bar: Tombol Kembali & Judul "Create Slice"
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDEEBCE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFF165540),
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'Create Slice',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF165540),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Konten Formulir Scrollable
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // Carousel Kartu Foto Postingan yang Dipilih
                      SizedBox(
                        height: 210,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            // Daftar Foto yang Dipilih
                            ..._photos.map((photoPath) => Padding(
                                  padding: const EdgeInsets.only(right: 14.0),
                                  child: Container(
                                    width: 320,
                                    height: 210,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDEEBCE),
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.08),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(22),
                                      child: _buildSinglePhoto(photoPath),
                                    ),
                                  ),
                                )),

                            // Kartu Tambah Foto Tambahan
                            GestureDetector(
                              onTap: _pickAdditionalPhoto,
                              child: Container(
                                width: 80,
                                height: 210,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDEEBCE)
                                      .withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: const Color(0xFFB5D4A2),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 32,
                                    color: Color(0xFF165540),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Input Caption: "Tambahkan caption..."
                      TextField(
                        controller: _captionController,
                        maxLines: 3,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: const Color(0xFF165540),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Tambahkan caption...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14.5,
                            color: const Color(0xFF536947)
                                .withValues(alpha: 0.8),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Tombol Tagar (#) dan Sebutan (@)
                      Row(
                        children: [
                          _buildQuickTagButton(
                            label: '@',
                            onTap: () {
                              _captionController.text += ' @';
                              _captionController.selection =
                                  TextSelection.fromPosition(
                                    TextPosition(
                                      offset: _captionController.text.length,
                                    ),
                                  );
                            },
                          ),
                          const SizedBox(width: 12),
                          _buildQuickTagButton(
                            label: '#',
                            onTap: () {
                              _captionController.text += ' #';
                              _captionController.selection =
                                  TextSelection.fromPosition(
                                    TextPosition(
                                      offset: _captionController.text.length,
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFCFDFCA), thickness: 1),
                      const SizedBox(height: 12),

                      // Bagian Pemilihan Lokasi
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF165540),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _selectedLocation ?? 'Tambahkan lokasi',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF165540),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Deretan Chip Negara / Kota
                      SizedBox(
                        height: 38,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _locations.length,
                          separatorBuilder: (context, index) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final loc = _locations[index];
                            final isSelected = _selectedLocation == loc;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedLocation = isSelected ? null : loc;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF165540)
                                      : const Color(0xFFDEEBCE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    loc,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF165540),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFCFDFCA), thickness: 1),
                      const SizedBox(height: 8),

                      // Toggle 1: Nonaktifkan komentar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.speaker_notes_off_outlined,
                                color: Color(0xFF165540),
                                size: 22,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Nonaktifkan komentar',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF165540),
                                ),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: _disableComments,
                            activeThumbColor: const Color(0xFF165540),
                            activeTrackColor: const Color(0xFFB5D4A2),
                            onChanged: (val) {
                              setState(() => _disableComments = val);
                            },
                          ),
                        ],
                      ),

                      // Toggle 2: Jangan bagikan postingan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Transform.rotate(
                                angle: -0.4,
                                child: const Icon(
                                  Icons.send_outlined,
                                  color: Color(0xFF165540),
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Jangan bagikan postingan',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF165540),
                                ),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: _preventShare,
                            activeThumbColor: const Color(0xFF165540),
                            activeTrackColor: const Color(0xFFB5D4A2),
                            onChanged: (val) {
                              setState(() => _preventShare = val);
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // 3. Dua Tombol Aksi: "Mulai Awal" dan "Posting"
                      Row(
                        children: [
                          // Tombol "Mulai Awal"
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _resetForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFDEEBCE),
                                  foregroundColor: const Color(0xFF165540),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Text(
                                  'Mulai Awal',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Tombol "Posting" (Gradasi Hijau Segar)
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF729B5E),
                                      Color(0xFF1E5B47),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF165540)
                                          .withValues(alpha: 0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _submitPost,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: Text(
                                    'Posting',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tombol Cepat Tagar / Sebutan (@ dan #)
  Widget _buildQuickTagButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFFDEEBCE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF165540),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSinglePhoto(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(
            Icons.image_outlined,
            size: 64,
            color: Color(0xFF165540),
          ),
        ),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(
            Icons.image_outlined,
            size: 64,
            color: Color(0xFF165540),
          ),
        ),
      );
    }
  }
}
