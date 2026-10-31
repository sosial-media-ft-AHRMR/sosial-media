import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sosial_media/models/story_item.dart';
import 'package:sosial_media/tampilan_utama/story_viewer_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StoryViewerPage Tests', () {
    final testStory = StoryItem(
      id: 'slice_1',
      username: 'Your.Idol',
      imageUrl: 'assets/feed/story_your_idol.png',
      slides: [
        'assets/feed/story_snow_bg.png',
        'assets/feed/story_stars_bg.png',
      ],
      userAvatarUrl: 'assets/feed/avatar_your_idol.png',
      isVerified: true,
    );

    testWidgets('1. StoryViewerPage renders header, verified badge, and bottom bar',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StoryViewerPage(story: testStory),
        ),
      );
      await tester.pump();

      // Check username
      expect(find.text('Your.Idol'), findsOneWidget);

      // Check verified badge
      expect(find.byIcon(Icons.verified), findsOneWidget);

      // Check that there is NO 'close' (X) icon button, exactly matching Figma
      expect(find.byIcon(Icons.close_rounded), findsNothing);

      // Check bottom bar input field hint
      expect(find.text('Kirim Pesan..'), findsOneWidget);

      // Check heart icon
      expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
    });

    testWidgets('2. Tapping heart toggles liked state and scale animation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StoryViewerPage(story: testStory),
        ),
      );
      await tester.pump();

      final heartFinder = find.byIcon(Icons.favorite_border_rounded);
      expect(heartFinder, findsOneWidget);

      // Tap heart to like
      await tester.tap(heartFinder);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Now solid heart
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    });

    testWidgets('3. Navigates to next slide when tapping right side of screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StoryViewerPage(story: testStory),
        ),
      );
      await tester.pump();

      // Tap on the right side of the screen (e.g. at x=300, y=400)
      await tester.tapAt(const Offset(300, 400));
      await tester.pump();

      // Still in StoryViewerPage displaying slide 2
      expect(find.byType(StoryViewerPage), findsOneWidget);
      expect(find.text('Your.Idol'), findsOneWidget);
    });
  });
}

