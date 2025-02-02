class BusinessInvestorExplr {
  final String id;
  final String imageUrl;
  final String image2;
  final String image3;
  final String? image4;
  final String name;
  final String? industry;
  final String? establish_yr;
  final String? description;
  final String? address_1;
  final String? address_2;
  final String? pin;
  final String city;
  final String? state;
  final String? employees;
  final String? entity;
  final String? avg_monthly;
  final String? latest_yearly;
  final String? ebitda;
  final String? rate;
  final String? type_sale;
  final String? url;
  final String? features;
  final String? facility;
  final String? income_source;
  final String? reason;
  final String postedTime;
  final String topSelling;
  String? rangeStarting;
  String? locationIntrested;
  String? rangeEnding;
  String? evaluatingAspects;
  String? companyName;
  String? brandName;
  String? initialInvestment;
  String? iamOffering;
  String? currentNumberOfOutlets;
  String? franchiseTerms;
  String? locationsAvailable;
  String? projectedRoi;
  String? kindOfSupport;
  String? allProducts;
  String? brandStartOperation;
  String? spaceRequiredMin;
  String? spaceRequiredMax;
  String? totalInvestmentFrom;
  String? totalInvestmentTo;
  String? brandFee;
  String? avgNoOfStaff;
  String? avgEBITDA;
  String? avgMonthlySales;
  final String? entityType;

  BusinessInvestorExplr(
      {required this.id,
        required this.imageUrl,
        required this.image2,
        required this.image3,
        this.image4,
        required this.name,
        this.industry,
        this.establish_yr,
        this.description,
        this.address_1,
        this.address_2,
        this.pin,
        required this.city,
        this.state,
        this.employees,
        this.entity,
        this.avg_monthly,
        this.latest_yearly,
        this.ebitda,
        this.rate,
        this.type_sale,
        this.url,
        this.features,
        this.facility,
        this.income_source,
        this.reason,
        this.evaluatingAspects,
        this.companyName,
        this.rangeStarting,
        this.rangeEnding,
        this.locationsAvailable,
        this.brandName,
        this.locationIntrested,
        required this.postedTime,
        required this.topSelling,
        this.entityType});

  factory BusinessInvestorExplr.fromJson(Map<String, dynamic> json) {
    return BusinessInvestorExplr(
        id: json['id']?.toString() ?? 'N/A',
        imageUrl: validateUrl(json['image1']) ??
            'https://via.placeholder.com/400x200',
        image2: validateUrl(json['image2']) ??
            'https://via.placeholder.com/400x200',
        image3: validateUrl(json['image3']) ??
            'https://via.placeholder.com/400x200',
        image4: validateUrl(json['image4']),
        name: json['name']?.toString() ?? 'N/A',
        industry: json['industry']?.toString(),
        establish_yr: json['establish_yr']?.toString(),
        description: json['description']?.toString(),
        address_1: json['address_1']?.toString(),
        address_2: json['address_2']?.toString(),
        pin: json['pin']?.toString(),
        city: json['city']?.toString() ?? 'N/A',
        state: json['state']?.toString(),
        employees: json['employees']?.toString(),
        entity: json['entity']?.toString(),
        avg_monthly: json['avg_monthly']?.toString(),
        latest_yearly: json['latest_yearly']?.toString(),
        ebitda: json['ebitda']?.toString(),
        rate: json['range_starting']?.toString(),
        type_sale: json['type_sale']?.toString(),
        url: json['url']?.toString(),
        features: json['features']?.toString(),
        facility: json['facility']?.toString(),
        income_source: json['income_source']?.toString(),
        reason: json['reason']?.toString(),
        postedTime: json['listed_on']?.toString() ?? 'N/A',
        topSelling: json['top_selling']?.toString() ?? 'N/A',
        locationIntrested: json['location_interested']?.toString(),
        rangeStarting: json['range_starting']?.toString(),
        rangeEnding: json['range_ending']?.toString(),
        companyName: json['company']?.toString(),
        evaluatingAspects: json['evaluating_aspects']?.toString(),
        brandName: json['brand_name']?.toString(),
        entityType: json["entity_type"] ?? "");
  }

  static String? validateUrl(String? url) {
    const String baseUrl = 'https://investryx.com/';

    if (url == null || url.isEmpty) {
      return null;
    }

    Uri? uri;
    try {
      uri = Uri.parse(url);
      if (!uri.hasScheme) {
        url = url.startsWith('/') ? url.substring(1) : url;
        url = baseUrl + url;
        uri = Uri.parse(url);
      }
      if (uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty)) {
        return url;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

class FranchiseExplr {
  final String? established_year;
  final String imageUrl;
  final String image2;
  final String image3;
  final String image4;
  final String id;
  final String brandName;
  final String city;
  final String postedTime;
  final String? state;
  final String? industry;
  final String? description;
  final String? url;
  final String? initialInvestment;
  final String? projectedRoi;
  final String? iamOffering;
  final String? currentNumberOfOutlets;
  final String? franchiseTerms;
  final String? locationsAvailable;
  final String? kindOfSupport;
  final String? allProducts;
  final String? brandStartOperation;
  final String? spaceRequiredMin;
  final String? spaceRequiredMax;
  final String? totalInvestmentFrom;
  final String? totalInvestmentTo;
  final String? brandFee;
  final String? avgNoOfStaff;
  final String? avgMonthlySales;
  final String? avgEBITDA;
  final String? companyName;
  final String? entityType;

  FranchiseExplr(
      {this.established_year,
        required this.imageUrl,
        required this.image2,
        required this.image3,
        required this.image4,
        required this.brandName,
        required this.city,
        required this.postedTime,
        required this.id,
        this.state,
        this.industry,
        this.description,
        this.url,
        this.initialInvestment,
        this.projectedRoi,
        this.iamOffering,
        this.currentNumberOfOutlets,
        this.franchiseTerms,
        this.locationsAvailable,
        this.kindOfSupport,
        this.allProducts,
        this.brandStartOperation,
        this.spaceRequiredMin,
        this.spaceRequiredMax,
        this.totalInvestmentFrom,
        this.totalInvestmentTo,
        this.brandFee,
        this.avgNoOfStaff,
        this.avgMonthlySales,
        this.avgEBITDA,
        this.companyName,
        this.entityType});

  factory FranchiseExplr.fromJson(Map<String, dynamic> json) {
    return FranchiseExplr(
        imageUrl: validateUrl(json['image1']) ??
            'https://via.placeholder.com/400x200',
        image2: validateUrl(json['image2']) ??
            'https://via.placeholder.com/400x200',
        image3: validateUrl(json['image3']) ??
            'https://via.placeholder.com/400x200',
        image4: validateUrl(json['image4']) ??
            'https://via.placeholder.com/400x200',
        established_year: json['established_year'],
        brandName: json['name'] ?? 'N/A',
        city: json['city'] ?? 'N/A',
        postedTime: json['listed_on'] ?? 'N/A',
        state: json['state'],
        industry: json['industry'],
        description: json['description'],
        url: json['url'],
        initialInvestment: json['initial']?.toString(),
        projectedRoi: json['proj_ROI']?.toString(),
        iamOffering: json['offering']?.toString(),
        currentNumberOfOutlets: json['total_outlets']?.toString(),
        franchiseTerms: json['yr_period']?.toString(),
        locationsAvailable: json['locations_available'],
        kindOfSupport: json['supports'],
        allProducts: json['services'],
        brandStartOperation: json['establish_yr']?.toString(),
        spaceRequiredMin: json['min_space']?.toString(),
        spaceRequiredMax: json['max_space']?.toString(),
        totalInvestmentFrom: json['range_starting']?.toString(),
        totalInvestmentTo: json['range_ending']?.toString(),
        brandFee: json['brand_fee']?.toString(),
        avgNoOfStaff: json['staff']?.toString(),
        avgMonthlySales: json['avg_monthly_sales']?.toString(),
        avgEBITDA: json['ebitda']?.toString(),
        companyName: json['company'],
        id: json['id']!.toString(),
        entityType: json["entity_type"] ?? "entity_type");
  }

  Map<String, dynamic> toJson() {
    return {
      'established_year': established_year,
      'image1': imageUrl,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'id': id,
      'name': brandName,
      'city': city,
      'listed_on': postedTime,
      'state': state,
      'industry': industry,
      'description': description,
      'url': url,
      'initial': initialInvestment,
      'proj_ROI': projectedRoi,
      'offering': iamOffering,
      'total_outlets': currentNumberOfOutlets,
      'yr_period': franchiseTerms,
      'locations_available': locationsAvailable,
      'supports': kindOfSupport,
      'services': allProducts,
      'establish_yr': brandStartOperation,
      'min_space': spaceRequiredMin,
      'max_space': spaceRequiredMax,
      'range_starting': totalInvestmentFrom,
      'range_ending': totalInvestmentTo,
      'brand_fee': brandFee,
      'staff': avgNoOfStaff,
      'avg_monthly_sales': avgMonthlySales,
      'ebitda': avgEBITDA,
      'company': companyName,
      'entity_type': entityType,
    };
  }




  static String? validateUrl(String? url) {
    const String baseUrl = 'https://investryx.com/';

    if (url == null || url.isEmpty) {
      return null;
    }

    Uri? uri;
    try {
      uri = Uri.parse(url);
      if (!uri.hasScheme) {
        url = url.startsWith('/') ? url.substring(1) : url;
        url = baseUrl + url;
        uri = Uri.parse(url);
      }
      if (uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty)) {
        return url;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

class AdvisorExplr {
  final String imageUrl;
  final String id;
  final String user;
  final String name;
  final String? designation;
  final String location;
  final String postedTime;
  final String? state;
  final String? expertise;
  final String? url;
  final String? contactNumber;
  final String? interest;
  final String? description;
  final List<String>? brandLogo; // URLs of brand logos
  final List<String>? businessPhotos; // URLs of business photos
  final String? businessProof; // URL of business proof
  final List<String>? businessDocuments; // URLs of business documents

  AdvisorExplr({
    required this.imageUrl,
    required this.id,
    required this.user,
    required this.name,
    required this.location,
    required this.postedTime,
    this.state,
    this.designation,
    this.expertise,
    this.url,
    this.contactNumber,
    this.interest,
    this.description,
    this.brandLogo,
    this.businessPhotos,
    this.businessProof,
    this.businessDocuments,
  });

  factory AdvisorExplr.fromJson(Map<String, dynamic> json) {
    return AdvisorExplr(
      imageUrl:
      validateUrl(json['image']) ?? 'https://via.placeholder.com/400x200',
      name: json['name'] ?? 'N/A',
      designation: json['designation'] ?? 'N/A',
      location: json['city'] ?? 'N/A',
      postedTime: json['listed_on'] ?? 'N/A',
      state: json['state'],
      expertise: json['expertise'],
      url: json['url'],
      contactNumber: json['number'],
      interest: json['interest'],
      description: json['description'],
      id: json['id']?.toString() ?? '', // Ensure id is a String
      user: json['user']?.toString() ?? '', // Ensure id is a String
      brandLogo: json['brandLogo'] != null
          ? List<String>.from(json['brandLogo'])
          : null,
      businessPhotos: json['businessPhotos'] != null
          ? List<String>.from(json['businessPhotos'])
          : null,
      businessProof: json['businessProof'],
      businessDocuments: json['businessDocuments'] != null
          ? List<String>.from(json['businessDocuments'])
          : null,
    );
  }

  static String? validateUrl(String? url) {
    const String baseUrl = 'https://investryx.com/';

    if (url == null || url.isEmpty) {
      return null;
    }

    Uri? uri;
    try {
      uri = Uri.parse(url);
      if (!uri.hasScheme) {
        url = url.startsWith('/') ? url.substring(1) : url;
        url = baseUrl + url;
        uri = Uri.parse(url);
      }
      if (uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty)) {
        return url;
      }
    } catch (e) {
      return null;
    }
    return null;
    }
}
