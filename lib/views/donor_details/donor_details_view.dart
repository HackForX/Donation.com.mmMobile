import 'package:flutter/material.dart';
import 'package:donation_com_mm_v2/models/donor_response.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:intl/intl.dart';

class DonorDetailsView extends StatelessWidget {
  final Donor donor;

  const DonorDetailsView({
    Key? key,
    required this.donor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'အလှူရှင်အချက်အလက်',
          style: TextStyle(
            color: ColorApp.secondaryColor,
            fontFamily: "Myanmar",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorApp.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildDonorHeader(context),
            _buildDonorDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDonorHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorApp.mainColor.withOpacity(0.05),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: ColorApp.mainColor.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(
              child: donor.profile != null
                  ? Image.network(
                      donor.profile,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(ImagePath.donor),
                    )
                  : Image.asset(ImagePath.donor),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            donor.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ColorApp.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Myanmar",
                ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ColorApp.mainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'အလှူရှင်',
              style: TextStyle(
                color: ColorApp.mainColor,
                fontFamily: "Myanmar",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonorDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildDetailItem(
            context,
            'ဖုန်းနံပါတ်',
            donor.phone,
            Icons.phone,
          ),
          _buildDetailItem(
            context,
            'မှတ်ပုံတင်သည့်နေ့',
            DateFormat('MMMM d, yyyy').format(donor.createdAt),
            Icons.calendar_today,
          ),
          if (donor.document != null)
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorApp.mainColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: ColorApp.mainColor.withOpacity(0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'မှတ်ပုံတင်',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: ColorApp.secondaryColor,
                          fontFamily: "Myanmar",
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      donor.document,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.error_outline),
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorApp.mainColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: ColorApp.mainColor),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: ColorApp.mainColor.withOpacity(0.6),
                      fontFamily: "Myanmar",
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: ColorApp.mainColor,
                      fontFamily: "Myanmar",
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}