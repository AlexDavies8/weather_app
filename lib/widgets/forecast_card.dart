import 'package:flutter/material.dart';
import 'package:weather_app/widgets/arc_progress_indicator.dart';

import 'category_indicator.dart';

class ForecastCard extends StatelessWidget {
  final String label;
  final int trees;
  final int grasses;
  final int weeds;

  ForecastCard({required this.label, this.trees = 0, this.grasses = 0, this.weeds = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w500, fontSize: 18))
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 4,
                child: CategoryIndicator(value: this.trees, icon: Icons.park)
              ),
              Expanded(
                flex: 4,
                child: CategoryIndicator(value: this.grasses, icon: Icons.grass)
              ),
              Expanded(
                flex: 4,
                child: CategoryIndicator(value: this.weeds, icon: Icons.spa)
              )
            ]
          ),
        ],
      )
    );
  }
}