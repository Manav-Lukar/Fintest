import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/icon_title_next_row.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/view/workout_tracker/exercises_stpe_details.dart';
import 'package:fitness/view/workout_tracker/workout_schedule_view.dart';
import 'package:flutter/material.dart';

import '../../common_widget/exercises_set_section.dart';

class WorkoutDetailView extends StatefulWidget {
  final Map dObj;
  const WorkoutDetailView({super.key, required this.dObj});

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  List latestArr = [
    {
      "image": "assets/img/Workout1.png",
      "title": "Fullbody Workout",
      "time": "Today, 03:00pm"
    },
    {
      "image": "assets/img/Workout2.png",
      "title": "Upperbody Workout",
      "time": "June 05, 02:00pm"
    },
  ];

  List youArr = [
    {"image": "assets/img/barbell.png", "title": "Barbell"},
    {"image": "assets/img/skipping_rope.png", "title": "Skipping Rope"},
    {"image": "assets/img/bottle.png", "title": "Bottle 1 Liters"},
  ];

  List exercisesArr = [
    {
      "name": "Set 1",
      "set": [
        {"image": "assets/img/img_1.png", "title": "Warm Up", "value": "05:00"},
        {
          "image": "assets/img/img_2.png",
          "title": "Jumping Jack",
          "value": "12x"
        },
        {"image": "assets/img/img_1.png", "title": "Skipping", "value": "15x"},
        {"image": "assets/img/img_2.png", "title": "Squats", "value": "20x"},
        {
          "image": "assets/img/img_1.png",
          "title": "Arm Raises",
          "value": "00:53"
        },
        {
          "image": "assets/img/img_2.png",
          "title": "Rest and Drink",
          "value": "02:00"
        },
      ],
    },
    {
      "name": "Set 2",
      "set": [
        {"image": "assets/img/img_1.png", "title": "Warm Up", "value": "05:00"},
        {
          "image": "assets/img/img_2.png",
          "title": "Jumping Jack",
          "value": "12x"
        },
        {"image": "assets/img/img_1.png", "title": "Skipping", "value": "15x"},
        {"image": "assets/img/img_2.png", "title": "Squats", "value": "20x"},
        {
          "image": "assets/img/img_1.png",
          "title": "Arm Raises",
          "value": "00:53"
        },
        {
          "image": "assets/img/img_2.png",
          "title": "Rest and Drink",
          "value": "02:00"
        },
      ],
    }
  ];

  // Added functionality for favorite toggling
  bool isFavorite = false;

  // Added functionality for starting workout
  void startWorkout() {
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Start Workout", 
              style: TextStyle(color: TColor.black, fontWeight: FontWeight.bold)),
          content: Text("Are you ready to start ${widget.dObj["title"]} workout?",
              style: TextStyle(color: TColor.gray)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: TColor.gray)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Here you would navigate to workout execution screen
                // For now, we'll just show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Workout started!"),
                    backgroundColor: TColor.primaryColor1,
                  ),
                );
              },
              child: Text("Start", 
                  style: TextStyle(color: TColor.primaryColor1, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: TColor.primaryG)),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: TColor.lightGray,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    "assets/img/black_btn.png",
                    width: 15,
                    height: 15,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    // Show options menu when more button is pressed
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: TColor.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.share, color: TColor.primaryColor1),
                                title: Text("Share Workout", style: TextStyle(color: TColor.black)),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Add share functionality here
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.info_outline, color: TColor.primaryColor1),
                                title: Text("Workout Info", style: TextStyle(color: TColor.black)),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Add workout info display here
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: TColor.lightGray,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      "assets/img/more_btn.png",
                      width: 15,
                      height: 15,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            ),
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 0,
              leading: Container(),
              expandedHeight: media.width * 0.5,
              flexibleSpace: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/detail_top.png",
                  width: media.width * 0.75,
                  height: media.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 50,
                        height: 4,
                        decoration: BoxDecoration(
                            color: TColor.gray.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.dObj["title"].toString(),
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "${widget.dObj["exercises"].toString()} | ${widget.dObj["time"].toString()} | 320 Calories Burn",
                                  style: TextStyle(
                                      color: TColor.gray, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Toggle favorite status
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Image.asset(
                              isFavorite ? "assets/img/fav_fill.png" : "assets/img/fav.png",
                              width: 15,
                              height: 15,
                              fit: BoxFit.contain,
                              color: isFavorite ? Colors.red : null,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      IconTitleNextRow(
                          icon: "assets/img/time.png",
                          title: "Schedule Workout",
                          time: "5/27, 09:00 AM",
                          color: TColor.primaryColor2.withOpacity(0.3),
                          onPressed: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => const WorkoutScheduleView()
                              )
                            );
                          }),
                      SizedBox(
                        height: media.width * 0.02,
                      ),
                      IconTitleNextRow(
                          icon: "assets/img/difficulity.png",
                          title: "Difficulty",  // Fixed typo in title
                          time: "Beginner",
                          color: TColor.secondaryColor2.withOpacity(0.3),
                          onPressed: () {
                            // Show difficulty selection dialog
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Select Difficulty", 
                                      style: TextStyle(color: TColor.black, fontWeight: FontWeight.bold)),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: Text("Beginner", style: TextStyle(color: TColor.black)),
                                        trailing: Icon(Icons.check, color: TColor.primaryColor1),
                                        onTap: () => Navigator.pop(context),
                                      ),
                                      ListTile(
                                        title: Text("Intermediate", style: TextStyle(color: TColor.black)),
                                        onTap: () => Navigator.pop(context),
                                      ),
                                      ListTile(
                                        title: Text("Advanced", style: TextStyle(color: TColor.black)),
                                        onTap: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "You'll Need",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "${youArr.length} Items",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.5,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: youArr.length,
                            itemBuilder: (context, index) {
                              var yObj = youArr[index] as Map? ?? {};
                              return Container(
                                  margin: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: media.width * 0.35,
                                        width: media.width * 0.35,
                                        decoration: BoxDecoration(
                                            color: TColor.lightGray,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          yObj["image"].toString(),
                                          width: media.width * 0.2,
                                          height: media.width * 0.2,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          yObj["title"].toString(),
                                          style: TextStyle(
                                              color: TColor.black,
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exercises",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "${exercisesArr.length} Sets",  // Changed to exercisesArr.length for correct count
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: exercisesArr.length,
                          itemBuilder: (context, index) {
                            var sObj = exercisesArr[index] as Map? ?? {};
                            return ExercisesSetSection(
                              sObj: sObj,
                              onPressed: (obj) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExercisesStepDetails(
                                      eObj: obj,
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundButton(
                        title: "Start Workout", 
                        onPressed: startWorkout  // Connected to startWorkout function
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}