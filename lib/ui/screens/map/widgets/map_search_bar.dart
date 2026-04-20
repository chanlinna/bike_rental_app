import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../search/view_model/search_view_model.dart';
import '../../search/search_screen.dart';
import '../../../states/map_state.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: GestureDetector(
        onTap: () {
          final mapState = context.read<MapState>();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => SearchViewModel(mapState),
                child: const SearchScreen(),
              ),
            ),
          );
        },
        child: Hero(
          tag: 'search_bar', 
          child: Material(
            elevation: 8,
            shadowColor: Colors.black26,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Search stations in Takhmao...",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  const VerticalDivider(indent: 12, endIndent: 12),
                  Icon(Icons.mic_none, color: Colors.grey[600]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
