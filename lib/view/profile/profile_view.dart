import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/setting_row.dart';
import '../../common_widget/title_subtitle_cell.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool notificationEnabled = true;
  bool isEditing = false;
  
  // User data
  Map<String, dynamic> userData = {
    "name": "Manav Lukar",
    "program": "Weight Training Program",
    "height": 178, // cm
    "weight": 75, // kg
    "age": 27,
    "bmi": 23.7, // calculated BMI
    "bodyFat": 18.5, // percentage
    "goalWeight": 72, // kg
    "profileImage": "assets/img/u2.png" // assuming you'll replace this with Manav's image
  };
  
  // Controllers for editing text fields
  late TextEditingController nameController;
  late TextEditingController programController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController ageController;
  late TextEditingController bodyFatController;
  late TextEditingController goalWeightController;
  
  @override
  void initState() {
    super.initState();
    // Initialize controllers with current values
    nameController = TextEditingController(text: userData["name"].toString());
    programController = TextEditingController(text: userData["program"].toString());
    heightController = TextEditingController(text: userData["height"].toString());
    weightController = TextEditingController(text: userData["weight"].toString());
    ageController = TextEditingController(text: userData["age"].toString());
    bodyFatController = TextEditingController(text: userData["bodyFat"].toString());
    goalWeightController = TextEditingController(text: userData["goalWeight"].toString());
  }
  
  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    programController.dispose();
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    bodyFatController.dispose();
    goalWeightController.dispose();
    super.dispose();
  }
  
  // Calculate BMI based on height and weight
  double calculateBMI() {
    double height = double.parse(heightController.text) / 100; // convert cm to m
    double weight = double.parse(weightController.text);
    return weight / (height * height);
  }
  
  // Save changes to userData
  void saveChanges() {
    setState(() {
      userData["name"] = nameController.text;
      userData["program"] = programController.text;
      userData["height"] = double.parse(heightController.text);
      userData["weight"] = double.parse(weightController.text);
      userData["age"] = int.parse(ageController.text);
      userData["bodyFat"] = double.parse(bodyFatController.text);
      userData["goalWeight"] = double.parse(goalWeightController.text);
      
      // Recalculate BMI
      userData["bmi"] = calculateBMI();
      
      isEditing = false;
    });
  }

  List accountArr = [
    {"image": "assets/img/p_personal.png", "name": "Personal Data", "tag": "1"},
    {"image": "assets/img/p_achi.png", "name": "Achievement", "tag": "2"},
    {
      "image": "assets/img/p_activity.png",
      "name": "Activity History",
      "tag": "3"
    },
    {
      "image": "assets/img/p_workout.png",
      "name": "Workout Progress",
      "tag": "4"
    }
  ];

  List otherArr = [
    {"image": "assets/img/p_contact.png", "name": "Contact Us", "tag": "5"},
    {"image": "assets/img/p_privacy.png", "name": "Privacy Policy", "tag": "6"},
    {"image": "assets/img/p_setting.png", "name": "Setting", "tag": "7"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: Text(
          "Profile",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
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
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isEditing)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: TColor.primaryColor1.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TColor.primaryColor1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: TColor.primaryColor1, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Editing Mode: Make changes and tap Save when done",
                            style: TextStyle(
                              color: TColor.primaryColor1,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: TColor.primaryColor1),
                          onPressed: () {
                            setState(() {
                              // Reset controllers
                              nameController.text = userData["name"].toString();
                              programController.text = userData["program"].toString();
                              heightController.text = userData["height"].toString();
                              weightController.text = userData["weight"].toString();
                              ageController.text = userData["age"].toString();
                              bodyFatController.text = userData["bodyFat"].toString();
                              goalWeightController.text = userData["goalWeight"].toString();
                              
                              isEditing = false;
                            });
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      userData["profileImage"],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isEditing
                            ? TextField(
                                controller: nameController,
                                style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                                  hintText: "Enter name",
                                ),
                              )
                            : Text(
                                userData["name"],
                                style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        isEditing
                            ? TextField(
                                controller: programController,
                                style: TextStyle(
                                  color: TColor.gray,
                                  fontSize: 12,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                                  hintText: "Enter program",
                                ),
                              )
                            : Text(
                                userData["program"],
                                style: TextStyle(
                                  color: TColor.gray,
                                  fontSize: 12,
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 25,
                    child: RoundButton(
                      title: isEditing ? "Save" : "Edit",
                      type: RoundButtonType.bgGradient,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        setState(() {
                          if (isEditing) {
                            saveChanges();
                          } else {
                            isEditing = true;
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: isEditing 
                    ? _buildEditableCell(
                        controller: heightController,
                        subtitle: "Height",
                        suffix: "cm",
                        keyboardType: TextInputType.number,
                      )
                    : TitleSubtitleCell(
                        title: "${userData["height"]}cm",
                        subtitle: "Height",
                      ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: isEditing 
                    ? _buildEditableCell(
                        controller: weightController,
                        subtitle: "Weight",
                        suffix: "kg",
                        keyboardType: TextInputType.number,
                      )
                    : TitleSubtitleCell(
                        title: "${userData["weight"]}kg",
                        subtitle: "Weight",
                      ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: isEditing 
                    ? _buildEditableCell(
                        controller: ageController,
                        subtitle: "Age",
                        suffix: "yo",
                        keyboardType: TextInputType.number,
                      )
                    : TitleSubtitleCell(
                        title: "${userData["age"]}yo",
                        subtitle: "Age",
                      ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TitleSubtitleCell(
                      title: isEditing 
                        ? calculateBMI().toStringAsFixed(1)
                        : "${userData["bmi"]}",
                      subtitle: "BMI",
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: isEditing 
                    ? _buildEditableCell(
                        controller: bodyFatController,
                        subtitle: "Body Fat",
                        suffix: "%",
                        keyboardType: TextInputType.number,
                      )
                    : TitleSubtitleCell(
                        title: "${userData["bodyFat"]}%",
                        subtitle: "Body Fat",
                      ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: isEditing 
                    ? _buildEditableCell(
                        controller: goalWeightController,
                        subtitle: "Goal",
                        suffix: "kg",
                        keyboardType: TextInputType.number,
                      )
                    : TitleSubtitleCell(
                        title: "${userData["goalWeight"]}kg",
                        subtitle: "Goal",
                      ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: accountArr.length,
                      itemBuilder: (context, index) {
                        var iObj = accountArr[index] as Map? ?? {};
                        return SettingRow(
                          icon: iObj["image"].toString(),
                          title: iObj["name"].toString(),
                          onPressed: () {
                            // Handle navigation based on tag
                            switch(iObj["tag"]) {
                              case "1":
                                // Navigate to Personal Data
                                break;
                              case "2":
                                // Navigate to Achievement
                                break;
                              case "3":
                                // Navigate to Activity History
                                break;
                              case "4":
                                // Navigate to Workout Progress
                                break;
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/img/p_notification.png",
                                height: 15, width: 15, fit: BoxFit.contain),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                "Pop-up Notification",
                                style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            CustomAnimatedToggleSwitch<bool>(
                              current: notificationEnabled,
                              values: const [false, true],
                              dif: 0.0,
                              indicatorSize: const Size.square(30.0),
                              animationDuration:
                                  const Duration(milliseconds: 200),
                              animationCurve: Curves.linear,
                              onChanged: (b) => setState(() => notificationEnabled = b),
                              iconBuilder: (context, local, global) {
                                return const SizedBox();
                              },
                              defaultCursor: SystemMouseCursors.click,
                              onTap: () => setState(() => notificationEnabled = !notificationEnabled),
                              iconsTappable: false,
                              wrapperBuilder: (context, global, child) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                        left: 10.0,
                                        right: 10.0,
                                        
                                        height: 30.0,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                             gradient: LinearGradient(
                                                colors: TColor.secondaryG),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50.0)),
                                          ),
                                        )),
                                    child,
                                  ],
                                );
                              },
                              foregroundIndicatorBuilder: (context, global) {
                                return SizedBox.fromSize(
                                  size: const Size(10, 10),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: TColor.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50.0)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black38,
                                            spreadRadius: 0.05,
                                            blurRadius: 1.1,
                                            offset: Offset(0.0, 0.8))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Health Metrics",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            title: "BMI Status",
                            value: isEditing 
                              ? _getBmiStatus(calculateBMI()) 
                              : _getBmiStatus(userData["bmi"]),
                            color: isEditing 
                              ? _getBmiStatusColor(calculateBMI()) 
                              : _getBmiStatusColor(userData["bmi"]),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildMetricCard(
                            title: "Progress",
                            value: isEditing 
                              ? "${((double.parse(weightController.text) - double.parse(goalWeightController.text)) / double.parse(weightController.text) * 100).toStringAsFixed(1)}%" 
                              : "${((userData["weight"] - userData["goalWeight"]) / userData["weight"] * 100).toStringAsFixed(1)}%",
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Other",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: otherArr.length,
                      itemBuilder: (context, index) {
                        var iObj = otherArr[index] as Map? ?? {};
                        return SettingRow(
                          icon: iObj["image"].toString(),
                          title: iObj["name"].toString(),
                          onPressed: () {
                            // Handle navigation based on tag
                            switch(iObj["tag"]) {
                              case "5":
                                // Navigate to Contact Us
                                break;
                              case "6":
                                // Navigate to Privacy Policy
                                break;
                              case "7":
                                // Navigate to Settings
                                break;
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildMetricCard({required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: TColor.gray,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEditableCell({
    required TextEditingController controller, 
    required String subtitle,
    String? suffix,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: TColor.lightGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: TextStyle(
              color: TColor.gray,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              color: TColor.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              border: InputBorder.none,
              suffix: suffix != null ? Text(suffix) : null,
            ),
          ),
        ],
      ),
    );
  }
  
  String _getBmiStatus(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }
  
  Color _getBmiStatusColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }
}