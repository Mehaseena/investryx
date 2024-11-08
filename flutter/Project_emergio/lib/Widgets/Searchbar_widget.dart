import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Views/advisor%20explore%20page.dart';
import 'package:project_emergio/services/profile%20forms/investor/investor%20explore.dart';
import '../Views/Investment explore page.dart';
import '../Views/business explore page.dart';
import '../Views/franchise explore page.dart';
import '../services/profile forms/business/business explore.dart';

class SearchbarWidget extends StatefulWidget {
  final ValueNotifier<String> selectedFilterNotifier;

  const SearchbarWidget({super.key, required this.selectedFilterNotifier});

  @override
  _SearchbarWidgetState createState() => _SearchbarWidgetState();
}

class _SearchbarWidgetState extends State<SearchbarWidget> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: widget.selectedFilterNotifier,
      builder: (context, selectedFilter, child) {
        return Container(
          height: 65.h,
          width: 325.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            border: Border.all(color: Colors.black38),
          ),
          child: Autocomplete<BusinessExplr>(
            optionsBuilder: (TextEditingValue textEditingValue) async {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<BusinessExplr>.empty();
              }
              final businesses = await BusinessExplore.fetchBusinessExplore();
              return businesses!.where((BusinessExplr option) {
                return option.name
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            displayStringForOption: (BusinessExplr option) => option.name,
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  hintText: 'Enter a keyword',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 4),
                    child: GestureDetector(
                      onTap: () {
                        _onSearch(
                          context,
                          selectedFilter,
                          textEditingController.text,
                        );
                      },
                      child: Container(
                        height: 10.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Color(0xff003C82),
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        ),
                        child: Center(
                          child: Text(
                            'Search',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              );
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<BusinessExplr> onSelected,
                Iterable<BusinessExplr> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 200.h, // Limit the height to a maximum value
                    ),
                    width: 325.w,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8.0),
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final BusinessExplr option = options.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: ListTile(
                            title: Text(option.name),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            onSelected: (BusinessExplr selection) {
              _searchController.clear();
              _onSearch(
                  context, widget.selectedFilterNotifier.value, selection.name);
            },
          ),
        );
      },
    );
  }

  void _onSearch(BuildContext context, String selectedFilter, String query) {
    if (selectedFilter == 'Business') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusinessExplorePage(searchQuery: query),
        ),
      );
    } else if (selectedFilter == 'Franchise') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FranchiseExplorePage(searchQuery: query),
        ),
      );
    } else if (selectedFilter == 'Investor') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvestorExplorePage(searchQuery: query),
        ),
      );
    } else
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdvisorExploreScreen(searchQuery: query),
        ),
      );    }
  }
}
