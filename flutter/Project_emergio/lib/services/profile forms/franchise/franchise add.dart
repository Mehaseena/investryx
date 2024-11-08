import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import Flutter Secure Storage
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../api_list.dart';

class FranchiseAddPage {
  static var client = http.Client();
  static final storage = FlutterSecureStorage(); // Initialize Flutter Secure Storage

  static Future<bool?> franchiseAddPage({
    required String brandName,
    required String industry,
    required String businessWebsite,
    required String initialInvestment,
    required String projectedRoi,
    required String iamOffering,
    required String currentNumberOfOutlets,
    required String franchiseTerms,
    required String aboutYourBrand,
    required String locationsAvailable,
    required String kindOfSupport,
    required String allProducts,
    required String brandStartOperation,
    required String spaceRequiredMin,
    required String spaceRequiredMax,
    required String totalInvestmentFrom,
    required String totalInvestmentTo,
    required String brandFee,
    required String avgNoOfStaff,
    required String avgMonthlySales,
    required String avgEBITDA,
    required File brandLogo,
    required File businessPhoto,
    required File image2,
    required File image3,
    required File image4,
    required List<File> businessDocuments,
    required File businessProof,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        return false;
      }

      // Create multipart request
      var request =
      http.MultipartRequest('POST', Uri.parse(ApiList.franchiseAddPage!))
        ..headers['token'] = token;
      request.fields['name'] = brandName;
      request.fields['industry'] = industry;
      request.fields['url'] = businessWebsite;
      request.fields['initial'] = initialInvestment;
      request.fields['proj_ROI'] = projectedRoi;
      request.fields['offering'] = iamOffering;
      request.fields['total_outlets'] = currentNumberOfOutlets;
      request.fields['yr_period'] = franchiseTerms;
      request.fields['description'] = aboutYourBrand;
      request.fields['locations_available'] = locationsAvailable;
      request.fields['supports'] = kindOfSupport;
      request.fields['services'] = allProducts;
      request.fields['establish_yr'] = brandStartOperation;
      request.fields['min_space'] = spaceRequiredMin;
      request.fields['max_space'] = spaceRequiredMax;
      request.fields['range_starting'] = totalInvestmentFrom;
      request.fields['range_ending'] = totalInvestmentTo;
      request.fields['brand_fee'] = brandFee;
      request.fields['staff'] = avgNoOfStaff;
      request.fields['avg_monthly_sales'] = avgMonthlySales;
      request.fields['ebitda'] = avgEBITDA;

      // Add files to the request
      request.files.add(await http.MultipartFile.fromPath(
          'logo', brandLogo.path,
          filename: basename(brandLogo.path)));

      request.files.add(await http.MultipartFile.fromPath(
          'image1', businessPhoto.path,
          filename: basename(businessPhoto.path)));

      request.files.add(await http.MultipartFile.fromPath(
          'image2', image2.path,
          filename: basename(image2.path)));

      request.files.add(await http.MultipartFile.fromPath(
          'image3', image3.path,
          filename: basename(image3.path)));

      request.files.add(await http.MultipartFile.fromPath(
          'image4', image4.path,
          filename: basename(image4.path)));

      for (var file in businessDocuments) {
        request.files.add(await http.MultipartFile.fromPath('doc1', file.path,
            filename: basename(file.path)));
      }
      request.files.add(await http.MultipartFile.fromPath(
          'proof1', businessProof.path,
          filename: basename(businessProof.path)));

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        log('Franchise information uploaded successfully!');
        var responseString = await response.stream.bytesToString();
        log('Response: $responseString');
        return true;
      } else {
        log('Failed to upload franchise information: ${response.statusCode}');
        return false;
      }
    } on SocketException catch (e) {
      log('SocketException: ${e.message}');
      return null;
    } on http.ClientException catch (e) {
      log('ClientException: ${e.message}');
      return null;
    } catch (e) {
      log('Unexpected error: $e');
      return null;
    }
  }

  static Future<bool?> updateFranchise({
    required String franchiseId,
    required String brandName,
    required String industry,
    required String businessWebsite,
    required String initialInvestment,
    required String projectedRoi,
    required String iamOffering,
    required String currentNumberOfOutlets,
    required String franchiseTerms,
    required String aboutYourBrand,
    required String locationsAvailable,
    required String kindOfSupport,
    required String allProducts,
    required String brandStartOperation,
    required String spaceRequiredMin,
    required String spaceRequiredMax,
    required String totalInvestmentFrom,
    required String totalInvestmentTo,
    required String brandFee,
    required String avgNoOfStaff,
    required String avgMonthlySales,
    required String avgEBITDA,
    File? brandLogo,
    required File image1,
    File? image2,
    File? image3,
    File? image4,
    required File doc1,
    required File proof1,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        return false;
      }

      // Create multipart request
      var request = http.MultipartRequest(
          'PATCH', Uri.parse('${ApiList.franchiseAddPage!}$franchiseId'))
        ..headers['token'] = token; // Add token to request headers

      // Add form fields
      request.fields['name'] = brandName;
      request.fields['industry'] = industry;
      request.fields['url'] = businessWebsite;
      request.fields['initial'] = initialInvestment;
      request.fields['proj_ROI'] = projectedRoi;
      request.fields['offering'] = iamOffering;
      request.fields['total_outlets'] = currentNumberOfOutlets;
      request.fields['yr_period'] = franchiseTerms;
      request.fields['description'] = aboutYourBrand;
      request.fields['locations_available'] = locationsAvailable;
      request.fields['supports'] = kindOfSupport;
      request.fields['services'] = allProducts;
      request.fields['establish_yr'] = brandStartOperation;
      request.fields['min_space'] = spaceRequiredMin;
      request.fields['max_space'] = spaceRequiredMax;
      request.fields['range_starting'] = totalInvestmentFrom;
      request.fields['range_ending'] = totalInvestmentTo;
      request.fields['brand_fee'] = brandFee;
      request.fields['staff'] = avgNoOfStaff;
      request.fields['avg_monthly_sales'] = avgMonthlySales;
      request.fields['ebitda'] = avgEBITDA;

      // Add files to the request
      if (brandLogo != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'logo', brandLogo.path,
            filename: basename(brandLogo.path)));
      }

      // Add image1 (required)
      if (image1.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image1',
          image1.path,
          filename: basename(image1.path),
        ));
      }
      if (image2 != null && image2.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image2',
          image2.path,
          filename: basename(image2.path),
        ));
      }
      if (image3 != null && image3.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image3',
          image3.path,
          filename: basename(image3.path),
        ));
      }
      if (image4 != null && image4.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image4',
          image4.path,
          filename: basename(image4.path),
        ));
      }

      // Add document and proof files
      if (doc1.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'doc1',
          doc1.path,
          filename: basename(doc1.path),
        ));
      }
      if (proof1.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'proof1',
          proof1.path,
          filename: basename(proof1.path),
        ));
      }

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        log('Franchise information updated successfully!');
        var responseString = await response.stream.bytesToString();
        log('Response: $responseString');
        return true;
      } else {
        log('Failed to update franchise information: ${response.statusCode}');
        return false;
      }
    } on SocketException catch (e) {
      log('SocketException: ${e.message}');
      return null;
    } on http.ClientException catch (e) {
      log('ClientException: ${e.message}');
      return null;
    } catch (e) {
      log('Unexpected error: $e');
      return null;
    }
  }
}
