import 'package:flutter/material.dart';
import 'package:bilheteria_panucci/screens/movie_screen.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieScreen(movie: movie),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio:
                    3 / 4, // Adjust the aspect ratio as per your design
                child: movie.imageURI != null
                    ? Image.network(
                        movie.imageURI!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text('Imagem não encontrada'),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(Icons.error),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
