import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
void main() {
  runApp(const MyApp());
}

/// This is a public function/class.
/// MyApp is the root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audiobook Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AudiobookMainScreen(),
    );
  }
}

// Audiobook mock data model
class Audiobook {
  final String title;
  final String author;
  final String imageUrl;
  final String price;

  Audiobook(
      {required this.title,
      required this.author,
      required this.imageUrl,
      required this.price});
}

/// List of mock audiobooks
final List<Audiobook> mockAudiobooks = [
  Audiobook(
      title: 'Moby Dick',
      author: 'Herman Melville',
      imageUrl: 'https://covers.openlibrary.org/b/id/5552036-L.jpg',
      price: '\$12.99'),
  Audiobook(
      title: '1984',
      author: 'George Orwell',
      imageUrl: 'https://covers.openlibrary.org/b/id/8228691-L.jpg',
      price: '\$9.99'),
  Audiobook(
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      imageUrl: 'https://covers.openlibrary.org/b/id/8091016-L.jpg',
      price: '\$7.99'),
  Audiobook(
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      imageUrl: 'https://covers.openlibrary.org/b/id/6979861-L.jpg',
      price: '\$10.99'),
  Audiobook(
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      imageUrl: 'https://covers.openlibrary.org/b/id/8225265-L.jpg',
      price: '\$8.99'),
  Audiobook(
      title: 'Frankenstein',
      author: 'Mary Shelley',
      imageUrl: 'https://covers.openlibrary.org/b/id/6970454-L.jpg',
      price: '\$6.99'),
  Audiobook(
      title: 'Great Expectations',
      author: 'Charles Dickens',
      imageUrl: 'https://covers.openlibrary.org/b/id/8231856-L.jpg',
      price: '\$11.99'),
  Audiobook(
      title: 'Dracula',
      author: 'Bram Stoker',
      imageUrl: 'https://covers.openlibrary.org/b/id/8099645-L.jpg',
      price: '\$8.49'),
  Audiobook(
      title: 'Ulysses',
      author: 'James Joyce',
      imageUrl: 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
      price: '\$13.49'),
  Audiobook(
      title: 'The Odyssey',
      author: 'Homer',
      imageUrl: 'https://covers.openlibrary.org/b/id/7812581-L.jpg',
      price: '\$9.49'),
  // Add more audiobooks as needed
];

/// The main screen with bottom navigation.
/// Currently, only Store tab is implemented.
class AudiobookMainScreen extends StatefulWidget {
  const AudiobookMainScreen({super.key});

  @override
  State<AudiobookMainScreen> createState() => _AudiobookMainScreenState();
}

class _AudiobookMainScreenState extends State<AudiobookMainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const StoreView(),
    // Placeholder pages for Library and Player
    Center(
      child: Text('Library (coming soon!)'),
    ),
    Center(
      child: Text('Player (coming soon!)'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audiobook Store'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill), label: 'Player'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}


/// Store view showing all audiobooks in a grid layout with images.
class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    // PUBLIC_INTERFACE
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: mockAudiobooks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,                // 2 columns
          mainAxisSpacing: 16,              // vertical spacing between rows
          crossAxisSpacing: 16,             // horizontal spacing between columns
          childAspectRatio: 0.66,           // height/width ratio per tile
        ),
        itemBuilder: (context, index) {
          final audiobook = mockAudiobooks[index];
          return AudiobookGridTile(audiobook: audiobook);
        },
      ),
    );
  }
}


/// Grid tile widget for displaying one audiobook with image and details.
class AudiobookGridTile extends StatelessWidget {
  final Audiobook audiobook;

  const AudiobookGridTile({required this.audiobook, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // To be implemented: purchase/book details
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Purchase "${audiobook.title}" coming soon!')),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 0.8,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  audiobook.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 48),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                audiobook.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                audiobook.author,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                audiobook.price,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
