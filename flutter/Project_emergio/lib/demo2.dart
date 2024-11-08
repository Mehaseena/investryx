import 'package:flutter/material.dart';

class CompanyDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildCompanyTitle(),
            _buildDescriptionSection(),
            _buildOverviewSection(),
            _buildFinancialsSection(),
            _buildAdditionalInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: Image.asset(
              'assets/company_building.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_border),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DemoCompany',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 20),
              const SizedBox(width: 4),
              const Text(
                'Kerala, Ernakulam',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  const Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Description'),
          const SizedBox(height: 8),
          const Text(
            'A Company, Abbreviated As Co., Is A Legal Entity Representing An Association Of Legal People, Whether Natural, Juridical Or A Mixture Of Both, With A Specific Objective. Company Members Share A Common Purpose And Unite To Achieve Specific, Declared Goals.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Overview'),
          const SizedBox(height: 16),
          _buildInfoRow('Industry', 'Demoname'),
          _buildInfoRow('Established Year', '2024'),
          _buildInfoRow('Address - 1', 'Demo Address Add In Company'),
          _buildInfoRow('Address - 2', 'Demo Address Add In Company'),
          _buildInfoRow('Pin Code', '676221'),
          _buildInfoRow('City', 'Kochi'),
          _buildInfoRow('State', 'Kerala'),
          _buildInfoRow('N Of Employees', '32'),
          _buildInfoRow('Entity Type', 'Untitled'),
        ],
      ),
    );
  }

  Widget _buildFinancialsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Financials'),
          const SizedBox(height: 16),
          _buildInfoRow('Avg Monthly Revenue', '50,0000'),
          _buildInfoRow('Latest Yearly Revenue', '10,00,0000'),
          _buildInfoRow('EBITDA', '570.0'),
          _buildInfoRow('Rate', 'N/A'),
          _buildInfoRow('Type Of Scale', 'Untitled'),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Additional Info'),
          const SizedBox(height: 16),
          _buildInfoRow('Website', 'Demoname.Com'),
          _buildInfoRow('Features', 'Untitled'),
          _buildInfoRow('Facilities', 'Untitled'),
          _buildInfoRow('Income Sources', 'Untitled'),
          _buildInfoRow('Reason For Sale', 'Untitled'),
          _buildInfoRow('Posted Time', '20 , 10 , 2024 12.00PM'),
          _buildInfoRow('Top Selling', 'Untitled'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}