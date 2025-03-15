import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/home_donor_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonorList extends StatefulWidget {
  const DonorList({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  State<DonorList> createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.donors.isEmpty) {
        return Container(
          height: 120,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 32, color: Colors.grey[400]),
              const SizedBox(height: 8),
              Text(
                "အလှူရှင်များမရှိသေးပါ",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(
            widget.controller.donors.length,
            (index) {
              final animation = Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(
                    (index * 0.1).clamp(0.0, 1.0),
                    ((index + 1) * 0.1).clamp(0.0, 1.0),
                    curve: Curves.easeOutCubic,
                  ),
                ),
              );

              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(30 * (1 - animation.value), 0),
                  child: Opacity(
                    opacity: animation.value,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: child,
                    ),
                  ),
                ),
                child: HomeDonorCard(
                  donor: widget.controller.donors[index],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}