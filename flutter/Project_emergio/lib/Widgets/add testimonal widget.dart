  // import 'dart:developer';
  //
  // import 'package:flutter/material.dart';
  // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
  // import 'package:shared_preferences/shared_preferences.dart';
  //
  // import '../services/testimonial/testimonial add.dart';
  //
  // class AddTestimonialDialog extends StatefulWidget {
  //   @override
  //   _AddTestimonialDialogState createState() => _AddTestimonialDialogState();
  // }
  //
  // class _AddTestimonialDialogState extends State<AddTestimonialDialog> {
  //   final _formKey = GlobalKey<FormState>();
  //   final TextEditingController nameController = TextEditingController();
  //   final TextEditingController testimonialController = TextEditingController();
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Dialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Add Testimonial',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 IconButton(
  //                   icon: Icon(Icons.close),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 16),
  //             Form(
  //               key: _formKey,
  //               child: Column(
  //                 children: [
  //                   TextFormField(
  //                     controller: nameController,
  //                     decoration: InputDecoration(
  //                       labelText: 'Company Name',
  //                       filled: true,
  //                       fillColor: Colors.grey[200],
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(12),
  //                         borderSide: BorderSide.none,
  //                       ),
  //                     ),
  //                     validator: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return 'Please enter a company name';
  //                       }
  //                       return null;
  //                     },
  //                   ),
  //                   SizedBox(height: 16),
  //                   TextFormField(
  //                     controller: testimonialController,
  //                     maxLines: 4,
  //                     decoration: InputDecoration(
  //                       labelText: 'Testimonial',
  //                       filled: true,
  //                       fillColor: Colors.grey[200],
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(12),
  //                         borderSide: BorderSide.none,
  //                       ),
  //                     ),
  //                     validator: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return 'Please enter a testimonial';
  //                       }
  //                       return null;
  //                     },
  //                   ),
  //                   SizedBox(height: 24),
  //                   ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Color(0xff003C82),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //                     ),
  //                     onPressed: () async {
  //                       if (_formKey.currentState?.validate() ?? false) {
  //                         final name = nameController.text;
  //                         final testimonial = testimonialController.text;
  //
  //                         // Retrieve the token from secure storage
  //                         final storage = FlutterSecureStorage();
  //                         final token = await storage.read(key: 'token');
  //
  //                         if (token == null) {
  //                           log('Error: Token not found in secure storage');
  //                           return;
  //                         }
  //
  //                         // Call the API method here
  //                         final success = await TestimonialAdd.testimonial(
  //                           companyName: name,
  //                           testimonial: testimonial,
  //                         );
  //
  //                         if (success == true) {
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                             SnackBar(content: Text('Testimonial added successfully')),
  //                           );
  //                         } else {
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                             SnackBar(content: Text('Failed to add testimonial')),
  //                           );
  //                         }
  //
  //                         nameController.clear();
  //                         testimonialController.clear();
  //
  //                         Navigator.of(context).pop();
  //                       }
  //                     },
  //                     child: Text('Submit', style: TextStyle(color: Colors.white)),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }
  //
  // void showAddTestimonialDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AddTestimonialDialog();
  //     },
  //   );
  // }


  import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/testimonial/testimonial add.dart';

class AddTestimonialDialog extends StatefulWidget {
    final Function onTestimonialAdded;

    const AddTestimonialDialog({Key? key, required this.onTestimonialAdded}) : super(key: key);

    @override
    _AddTestimonialDialogState createState() => _AddTestimonialDialogState();
  }

  class _AddTestimonialDialogState extends State<AddTestimonialDialog> {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController testimonialController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Testimonial',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Company Name',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a company name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: testimonialController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Testimonial',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a testimonial';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff003C82),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final name = nameController.text;
                          final testimonial = testimonialController.text;

                          // Retrieve the token from secure storage
                          final storage = FlutterSecureStorage();
                          final token = await storage.read(key: 'token');

                          if (token == null) {
                            log('Error: Token not found in secure storage');
                            return;
                          }

                          // Call the API method here
                          final success = await TestimonialAdd.testimonial(
                            companyName: name,
                            testimonial: testimonial,
                          );

                          if (success == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Testimonial added successfully')),
                            );

                            // Call the callback function to refresh testimonials
                            widget.onTestimonialAdded();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to add testimonial')),
                            );
                          }

                          nameController.clear();
                          testimonialController.clear();

                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Submit', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }