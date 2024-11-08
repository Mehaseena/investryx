import 'package:flutter/material.dart';

import '../services/search.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Center(
        child: Text('Search',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      elevation: 0,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.notifications, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// widgets/search_bar.dart
class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;

  const SearchBar({
    required this.controller,
    required this.onChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Search...',
              filled: true,
              fillColor: const Color(0xffF3F8FE),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              suffixIcon: _buildSuffixIcon(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilterButton(onTap: onFilterTap),
      ],
    );
  }

  Widget _buildSuffixIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (controller.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          ),
        SearchButton(onTap: () => onChanged(controller.text)),
      ],
    );
  }
}

// widgets/search_results.dart
class SearchResults extends StatelessWidget {
  final List<SearchResult> results;
  final Function(SearchResult) onTap;

  const SearchResults({required this.results, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: results.map((result) => SearchResultCard(
        result: result,
        onTap: () => onTap(result),
      )).toList(),
    );
  }
}

// models/filter_state.dart
class FilterState {
  String city = '';
  String state = '';
  String industry = '';
  String entityType = '';
  String establishFrom = '';
  String establishTo = '';
  String rangeStarting = '';
  String rangeEnding = '';
  bool filter = false;

  Map<String, dynamic> toMap() => {
    'city': city,
    'state': state,
    'industry': industry,
    'entityType': entityType,
    'establishFrom': establishFrom,
    'establishTo': establishTo,
    'rangeStarting': rangeStarting,
    'rangeEnding': rangeEnding,
  };

  void reset() {
    city = '';
    state = '';
    industry = '';
    entityType = '';
    establishFrom = '';
    establishTo = '';
    rangeStarting = '';
    rangeEnding = '';
    filter = false;
  }
}

// widgets/filter_button.dart
class FilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const FilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xffFFCC00),
      child: IconButton(
        icon: const Icon(Icons.sort_sharp, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }
}

// widgets/search_button.dart
class SearchButton extends StatelessWidget {
  final VoidCallback onTap;

  const SearchButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xffFFCC00),
      child: IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }
}

// widgets/search_result_card.dart
class SearchResultCard extends StatelessWidget {
  final SearchResult result;
  final VoidCallback onTap;

  const SearchResultCard({
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildImage(),
            const SizedBox(width: 12),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        result.imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 100,
          height: 100,
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          result.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        _buildLocation(),
        const SizedBox(height: 4),
        _buildDescription(),
        const SizedBox(height: 4),
        _buildTypeTag(),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          result.location,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      result.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.grey[800],
        fontSize: 14,
      ),
    );
  }

  Widget _buildTypeTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xffFFCC00).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        result.type,
        style: const TextStyle(
          color: Color(0xffFFCC00),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// widgets/clear_history_button.dart
class ClearHistoryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ClearHistoryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: 220,
        height: 40,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: const Color(0xffFFCC00),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.close, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Clear Search History',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}