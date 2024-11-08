// import 'package:flutter/material.dart';
//
// class FAQScreen extends StatefulWidget {
//   FAQScreen({super.key});
//
//   @override
//   _FAQScreenState createState() => _FAQScreenState();
// }
//
// class _FAQScreenState extends State<FAQScreen> {
//   final List<Map<String, String>> faqData = [
//     {
//       'question':
//           'Should I interact with someone who no longer has a profile on SMERGERS?',
//       'answer':
//           'Please ensure you interact with your introductions only through the SMERGERS platform. In case the introduction is no longer available on your dashboard, then you should take precautionary measures and immediately stop interacting with that specific member.',
//     },
//     {
//       'question': 'What is seller financing?',
//       'answer':
//           'Seller financing is a common way to finance small business acquisitions. It involves the seller providing a loan to the buyer to purchase the business, in which the seller will receive the payments in installments following a substantial down payment. Many business owners offer this option to buyers to help bring in more buyers and complete a transaction. However, seller financing agreements should be reviewed by a lawyer and should distinctly outline the corrective actions that would enable the seller to pursue any available legal remedies in the event of a payment default.',
//     },
//     {
//       'question': 'What exactly are Tags I see on a profile?',
//       'answer':
//           'Tags are automatically created keyword phrases based on parameters selected on the profile, such as industry, location, transaction type, and so forth; there is no manual way to alter these tags. Search engines may be able to use these tags to search profiles.',
//     },
//     {
//       'question': 'How does SMERGERS promote profiles on social media?',
//       'answer':
//           'Promotion on social media would be determined by SMERGERS based on several factors, including but not limited to good quality pictures, valuation attractiveness, business legitimacy, etc. If you wish to not have your profile featured on social media, you can send us an email at help@inbox.smergers.com.',
//     },
//     {
//       'question': 'Can I delete a message already sent on SMERGERS?',
//       'answer':
//           'Yes, you can delete messages sent by you. Visit the inbox page of the introduced member, identify the message that you want to delete, and click on the red "X" icon on the top right corner of the message. Confirm the deletion by clicking on the "Delete message" prompt.',
//     },
//   ];
//
//   List<Map<String, String>> filteredFAQData = [];
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     filteredFAQData = faqData;
//   }
//
//   void filterFAQs(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         filteredFAQData = faqData;
//       });
//     } else {
//       setState(() {
//         filteredFAQData = faqData
//             .where((faq) =>
//                 faq['question']!.toLowerCase().contains(query.toLowerCase()))
//             .toList();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text('Back'),
//         elevation: 0,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//                 'We are here to help with anything and everything on Emergio',
//                 style: TextStyle(
//                     fontSize: h * 0.025, fontWeight: FontWeight.w600)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//                 'At Viral Pitch we expect at a days start is you, better and happier than yesterday. We have got you covered. Share your concern or check our frequently asked questions listed below.',
//                 style: TextStyle(
//                   fontSize: h * 0.017,
//                 )),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: searchController,
//               onChanged: filterFAQs,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   prefixIcon: Icon(Icons.search),
//                   hintText: 'Search Help'),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('FAQ',
//                 style: TextStyle(
//                     fontSize: h * 0.025, fontWeight: FontWeight.w600)),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Divider(),
//           Expanded(
//             child: filteredFAQData.isEmpty
//                 ? Center(
//                     child: Text(
//                       'No results found',
//                       style: TextStyle(
//                         fontSize: h * 0.02,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: filteredFAQData.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           border: Border(
//                             bottom: BorderSide(color: Colors.grey),
//                           ),
//                         ),
//                         child: ExpansionTile(
//                           title: Text(
//                             filteredFAQData[index]['question']!,
//                             style: TextStyle(
//                               fontSize: 17.0,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 16.0, vertical: 8.0),
//                               child: Text(
//                                 filteredFAQData[index]['answer']!,
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String selectedCategory = 'Business';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Center(
            child: Text('FAQs',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Help You With Anything And Everything On Emergio',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: const Color(0xffF3F8FE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xffFFCC00),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          // Handle search
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCategoryButton('Business'),
              _buildCategoryButton('Investment'),
              _buildCategoryButton('Franchise'),
            ],
          ),
          const SizedBox(height: 20),
          const ExpansionTile(
            title: Text('What is Business ?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Business Definition: Business is an economic activity that involves the exchange, purchase, sale or production of goods and services with a motive to earn profits and satisfy the needs of customers.',
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('How to Add Business Profile ?'),
          ),
          const ExpansionTile(
            title: Text('How to Add New Business ?'),
          ),
          const ExpansionTile(
            title: Text('How to Delete Business Post'),
          ),
          const ExpansionTile(
            title: Text('How to Accept Business Proposals'),
          ),
          const ExpansionTile(
            title: Text('How to Change my Business Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            selectedCategory = category;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedCategory == category ? Colors.amber : Colors.white,
          foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
        ),
        child: Text(category),
        );
    }
}
