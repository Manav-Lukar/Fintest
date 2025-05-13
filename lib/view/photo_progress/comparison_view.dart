import 'package:fitness/view/photo_progress/HealthReportPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitness/common_widget/icon_title_next_row.dart';
import 'package:fitness/common_widget/round_button.dart';

import '../../common/colo_extension.dart';

class ComparisonView extends StatefulWidget {
  const ComparisonView({super.key});

  @override
  State<ComparisonView> createState() => _ComparisonViewState();
}

class _ComparisonViewState extends State<ComparisonView> {
  DateTime? selectedMonth1;
  DateTime? selectedMonth2;

  // Function to pick a month
  Future<void> _pickMonth(int whichMonth) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
      helpText: 'Select Month',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: TColor.primaryColor1,
              onPrimary: Colors.white,
              onSurface: TColor.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: TColor.primaryColor1,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (whichMonth == 1) {
          selectedMonth1 = DateTime(picked.year, picked.month);
        } else {
          selectedMonth2 = DateTime(picked.year, picked.month);
        }
      });
    }
  }

  // Format the selected month
  String _formatMonth(DateTime? date) {
    return date != null ? DateFormat('MMMM yyyy').format(date) : "Select Month";
  }

  // Function to trigger comparison
  void _compare() {
    if (selectedMonth1 == null || selectedMonth2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select both months.")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SimpleHealthDashboardPage(
          date1: selectedMonth1!,
          date2: selectedMonth2!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: TColor.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset("assets/img/black_btn.png", width: 15),
          ),
        ),
        title: Text(
          "Comparison",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: TColor.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset("assets/img/more_btn.png", width: 15),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            IconTitleNextRow(
              icon: "assets/img/date.png",
              title: "Select Month 1",
              time: _formatMonth(selectedMonth1),
              onPressed: () => _pickMonth(1),
              color: TColor.lightGray,
            ),
            const SizedBox(height: 15),
            IconTitleNextRow(
              icon: "assets/img/date.png",
              title: "Select Month 2",
              time: _formatMonth(selectedMonth2),
              onPressed: () => _pickMonth(2),
              color: TColor.lightGray,
            ),
            const Spacer(),
            RoundButton(
              title: "Compare",
              onPressed: _compare,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
