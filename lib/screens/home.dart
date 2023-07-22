import 'package:flutter/material.dart';
import 'package:bilheteria_panucci/components/home/genre_filter.dart';
import 'package:bilheteria_panucci/components/movie_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit/home/home_cubit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeCubit homeCubit = HomeCubit();

  @override
  void initState() {
    homeCubit.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  "Filmes",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              GenreFilter(homeCubit: homeCubit),
              BlocBuilder<HomeCubit, HomeStates>(
                bloc: homeCubit,
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is HomeSuccess) {
                    if (state.movies.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: Text('Nenhum filme encontrado'),
                        ),
                      );
                    }
                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisExtent: 240,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return MovieCard(
                            movie: state.movies[index],
                          );
                        },
                        childCount: state.movies.length,
                      ),
                    );
                  } else {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text("Não foi possível visualizar os filmes."),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
