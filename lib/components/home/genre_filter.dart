import 'package:flutter/material.dart';

import '../../logic/cubit/home/home_cubit.dart';

class GenreFilter extends StatefulWidget {
  final HomeCubit homeCubit;

  const GenreFilter({Key? key, required this.homeCubit}) : super(key: key);

  @override
  State<GenreFilter> createState() => _GenreFilterState();
}

class _GenreFilterState extends State<GenreFilter> {
  static final List<String> listGenres = [
    'Todos',
    'Ação',
    'Comédia',
    'Drama',
    'Romance',
    'Documentário',
    'Suspense',
    'Terror',
    'Ficção Científica'
  ];

  String dropdownValue = listGenres.first;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Gênero: ', style: Theme.of(context).textTheme.displaySmall),
          DropdownButton<String>(
            value: dropdownValue,
            items: listGenres.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) async {
              if (value != null) {
                value == "Todos"
                    ? await widget.homeCubit.getMovies()
                    : await widget.homeCubit.getMoviesByGenre(value);

                setState(() {
                  dropdownValue = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
