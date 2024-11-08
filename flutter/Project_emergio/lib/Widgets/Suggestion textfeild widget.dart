import 'package:flutter/material.dart';

class SuggestionTextField extends StatefulWidget {
  final List<String> suggestions;
  final String hint;
  final ValueChanged<String> onSelected;

  SuggestionTextField({
    required this.suggestions,
    required this.hint,
    required this.onSelected,
  });

  @override
  _SuggestionTextFieldState createState() => _SuggestionTextFieldState();
}

class _SuggestionTextFieldState extends State<SuggestionTextField> {
  late TextEditingController _controller;
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_updateSuggestions);
  }

  void _updateSuggestions() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredSuggestions = widget.suggestions
          .where((suggestion) => suggestion.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        _controller.text = value;
        widget.onSelected(value);
        _updateSuggestions(); // Update suggestions after selection
      },
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: OutlineInputBorder(), // Add outline border
          suffixIcon: Icon(Icons.search),
        ),
      ),
      itemBuilder: (context) {
        return _filteredSuggestions.map((suggestion) {
          return PopupMenuItem<String>(
            value: suggestion,
            child: Text(suggestion),
          );
        }).toList();
      },
    );
  }
}
