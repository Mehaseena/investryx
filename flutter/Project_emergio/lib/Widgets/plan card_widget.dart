import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Views/plan detail page.dart';


class PlanCardWidget extends StatefulWidget {
  final String planType;
  final String price;
  final String id;
  final List<String> features;
  final bool isHighlighted;
  final bool isRecommended;
  final String subscribedId;
  final String timePeriod;
  final VoidCallback onPurchaseComplete;

  PlanCardWidget({
    required this.planType,
    required this.price,
    required this.features,
    this.isHighlighted = false,
    this.isRecommended = false,
    required this.id,
    required this.subscribedId,
    required this.onPurchaseComplete,
    required this.timePeriod,
  });

  @override
  _PlanCardWidgetState createState() => _PlanCardWidgetState();
}

class _PlanCardWidgetState extends State<PlanCardWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
            child: Container(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color:
                            widget.isHighlighted ? Colors.yellow : Colors.grey,
                        width: widget.isHighlighted ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.isRecommended)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Recommended',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            widget.planType,
                            style: TextStyle(
                                fontSize: 25.h, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 2),
                        Center(
                          child: Text(
                            '₹${widget.price} for ${widget.timePeriod} Months',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 16),
                        AnimatedCrossFade(
                          firstChild: _buildFeaturesList(
                              widget.features.take(3).toList()),
                          secondChild: _buildFeaturesList(widget.features),
                          crossFadeState: _expanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(milliseconds: 300),
                        ),
                        SizedBox(height: 8),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       _expanded = !_expanded;
                        //     });
                        //   },
                        //   child: Text(
                        //     _expanded ? 'Read Less' : 'Read More',
                        //     style: TextStyle(color: Colors.blue),
                        //   ),
                        // ),
                        SizedBox(height: 16),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black45),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlanDetailsPage(
                                      planType: widget.planType,
                                      price: widget.price,
                                      features: widget.features,
                                      id: widget.id,
                                      subscribedId: widget.subscribedId,
                                      onPurchaseComplete:
                                          widget.onPurchaseComplete,
                                      timePeriod: widget.timePeriod,
                                    ),
                                  ),
                                );
                              },
                              child: Text('View More'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
      },
    );
  }

  Widget _buildFeaturesList(List<String> features) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(feature),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
