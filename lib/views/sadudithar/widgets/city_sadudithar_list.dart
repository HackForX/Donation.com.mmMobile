import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/util/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'city_sadudithar_card.dart';


class CitySaduditharList extends StatefulWidget {
  const CitySaduditharList({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  State<CitySaduditharList> createState() => _CitySaduditharListState();
}

class _CitySaduditharListState extends State<CitySaduditharList> 
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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
      final filteredSadudithars = widget.controller.sadudithars
          .where((sadudithar) => 
              sadudithar.city.name == widget.controller.selectedCity)
          .toList();

      if (widget.controller.sadudithars.isEmpty) {
        return const EmptyWidget();
      }

      final itemsToShow = filteredSadudithars.isEmpty 
          ? widget.controller.sadudithars 
          : filteredSadudithars;

      return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            _animationController.forward();
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(
                itemsToShow.length,
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
                      offset: Offset(50 * (1 - animation.value), 0),
                      child: Opacity(
                        opacity: animation.value,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: child,
                        ),
                      ),
                    ),
                    child: CitySaduditarCard(
                      sadudithar: itemsToShow[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}