// import 'package:flutter/material.dart';

// class BusinessValuationScreen extends StatefulWidget {
//   @override
//   _BusinessValuationScreenState createState() =>
//       _BusinessValuationScreenState();
// }
//
// class _BusinessValuationScreenState extends State<BusinessValuationScreen> {
//   String? _selectedCountry;
//   String? _selectedIndustry;
//   double? _annualRevenue;
//   double? _ebitdaMargin;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Business Valuation'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'What is Business Valuation?',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.0,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 'At Emerald, we define Business Valuation as a technique used to capture the true value of the business. Common approaches to business valuation include Discounted Cash Flow (DCF), Trading Comparables, and Transaction Comparables method described below.',
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'How much is Your Business Worth',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.0,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButtonFormField<String>(
//                       value: _selectedCountry,
//                       decoration: InputDecoration(border: OutlineInputBorder()),
//                       hint: Text('Select Country'),
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedCountry = value;
//                         });
//                       },
//                       items: ['USA', 'Canada', 'UK', 'Australia']
//                           .map((country) => DropdownMenuItem<String>(
//                                 value: country,
//                                 child: Text(country),
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: DropdownButtonFormField<String>(
//                       value: _selectedIndustry,
//                       hint: Text('Select Industry'),
//                       decoration: InputDecoration(border: OutlineInputBorder()),
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedIndustry = value;
//                         });
//                       },
//                       items: ['Technology', 'Finance', 'Healthcare', 'Retail']
//                           .map((industry) => DropdownMenuItem<String>(
//                                 value: industry,
//                                 child: Text(industry),
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Annual Revenue',
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _annualRevenue = double.tryParse(value);
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Expanded(
//                     child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'EBITDA Margin',
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _ebitdaMargin = double.tryParse(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.0),
//               Center(
//                 child: SizedBox(
//                   height: 45,
//                   width: 150,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5)),
//                       backgroundColor: Color(0xff003C82),
//                     ),
//                     onPressed: () {
//                       // Implement business valuation logic here
//                     },
//                     child: Text(
//                       'Get Report',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'When do you need a Business Valuation?',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.0,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 'The following are some of the common reasons which necessitate valuing your business:',
//               ),
//               SizedBox(height: 8.0),
//               UnorderedList([
//                 'Selling the business',
//                 'Fund raising from VC or IPO',
//                 'Issuing stock for employees',
//                 'Financial reporting related',
//                 'Litigation related',
//               ]),
//               SizedBox(height: 16.0),
//               Text(
//                 'What is a Business Value?',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.0,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 'A company is held by two categories of owners, shareholders and debt holders. The value of a pure business which accrues to both categories of owners is called the Enterprise Value; whereas the value which accrues just to shareholders is the Equity Value (also called market cap for listed companies). Companies are compared using the enterprise value instead of equity value as debt and cash levels may vary significantly even between companies in the same industry. During an acquisition, depending on the acquirers strategy, a valuation of appropriate elements of the business needs to be carried out.',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class UnorderedList extends StatelessWidget {
//   final List<String> items;
//
//   UnorderedList(this.items);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: items.map((item) => Text('• $item')).toList(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusinessValuationScreen extends StatefulWidget {
  @override
  _BusinessValuationScreenState createState() =>
      _BusinessValuationScreenState();
}

class _BusinessValuationScreenState extends State<BusinessValuationScreen> {
  String? _selectedCountry;
  String? _selectedIndustry;
  String _selectedCurrency = 'USD';
  double? _annualRevenue;
  double? _ebitdaMargin;
  double _businessValue = 0.0;

  final _formKey = GlobalKey<FormState>();

  void calculateValuation() {
    if (_formKey.currentState!.validate()) {
      // Ensure that _annualRevenue and _ebitdaMargin are not null
      if (_annualRevenue != null && _ebitdaMargin != null) {
        // Calculate EBITDA
        double ebitda = _annualRevenue! * (_ebitdaMargin! / 100);

        // Apply a multiple to EBITDA to calculate business value
        const double multiple = 5.0; // Adjust based on industry
        _businessValue = ebitda * multiple;

        // Convert to selected currency
        if (_selectedCurrency == 'INR') {
          _businessValue = convertToINR(_businessValue); // Convert to INR if needed
        }

        setState(() {});
      }
    }
  }

  // Convert USD to INR (Assume conversion rate; update dynamically if needed)
  double convertToINR(double valueInUSD) {
    const double conversionRate = 83.0; // Example conversion rate, update as needed
    return valueInUSD * conversionRate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Valuation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What is Business Valuation?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'At Emerald, we define Business Valuation as a technique used to capture the true value of the business. Common approaches to business valuation include Discounted Cash Flow (DCF), Trading Comparables, and Transaction Comparables method described below.',
                ),
                SizedBox(height: 16.0),
                Text(
                  'How much is Your Business Worth',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCountry,
                        decoration:
                        InputDecoration(border: OutlineInputBorder()),
                        hint: Text('Select Country'),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountry = value;
                          });
                        },
                        items: ['USA', 'Canada', 'UK', 'Australia']
                            .map((country) => DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        ))
                            .toList(),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedIndustry,
                        hint: Text('Select Industry'),
                        decoration:
                        InputDecoration(border: OutlineInputBorder()),
                        onChanged: (value) {
                          setState(() {
                            _selectedIndustry = value;
                          });
                        },
                        items: ['Technology', 'Finance', 'Healthcare', 'Retail']
                            .map((industry) => DropdownMenuItem<String>(
                          value: industry,
                          child: Text(industry),
                        ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Annual Revenue',
                        ),
                        onChanged: (value) {
                          _annualRevenue = double.tryParse(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter annual revenue';
                          }
                          if (double.tryParse(value) == null ||
                              double.tryParse(value)! <= 0) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'EBITDA Margin',
                        ),
                        onChanged: (value) {
                          _ebitdaMargin = double.tryParse(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter EBITDA margin';
                          }
                          double? margin = double.tryParse(value);
                          if (margin == null || margin < 0 || margin > 100) {
                            return 'Please enter a valid percentage (0-100)';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    height: 45,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Color(0xff003C82),
                      ),
                      onPressed: () {
                        calculateValuation();
                      },
                      child: Text(
                        'Get Report',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                if (_businessValue > 0)
                  Center(
                    child: Text(
                      'Estimated Business Value: ${NumberFormat.currency(symbol: _selectedCurrency == 'INR' ? '₹' : '\$').format(_businessValue)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                SizedBox(height: 16.0),
                Text(
                  'When do you need a Business Valuation?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'The following are some of the common reasons which necessitate valuing your business:',
                ),
                SizedBox(height: 8.0),
                UnorderedList([
                  'Selling the business',
                  'Fund raising from VC or IPO',
                  'Issuing stock for employees',
                  'Financial reporting related',
                  'Litigation related',
                ]),
                SizedBox(height: 16.0),
                Text(
                  'What is a Business Value?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'A company is held by two categories of owners, shareholders and debt holders. The value of a pure business which accrues to both categories of owners is called the Enterprise Value; whereas the value which accrues just to shareholders is the Equity Value (also called market cap for listed companies). Companies are compared using the enterprise value instead of equity value as debt and cash levels may vary significantly even between companies in the same industry. During an acquisition, depending on the acquirers strategy, a valuation of appropriate elements of the business needs to be carried out.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UnorderedList extends StatelessWidget {
  final List<String> items;

  UnorderedList(this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => Text('• $item')).toList(),
    );
  }
}
