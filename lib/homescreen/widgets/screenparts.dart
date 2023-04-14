import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_page/const.dart';
// import 'package:control_page/dummydata/dummydata.dart';
import 'package:control_page/homescreen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget firstPart(BuildContext context, List trains, String station) {
  return Container(
    decoration: const BoxDecoration(color: Colors.black),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Control Page',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: menuTextColor),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                      color: ColorTheme.gold,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text('Admin',
                        // style: TextStyle(color: pageTextColor),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: pageTextColor,
                            )),
                  )),
            ],
          ),
          const SizedBox(
            height: 150,
          ),
          Expanded(
            child: Container(
              width: 150,
              // height: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return buildTrainListItem(trains[index], context, index);
                },
                itemCount: trains.length,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget secondPart(BuildContext context, List trains, String date) {
  return Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        color: ColorTheme.blueGray,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status', style: Theme.of(context).textTheme.bodyLarge),
          Text(date),
          Container(
              width: double.infinity,
              height: 200,
              child: Image(
                image: AssetImage('assets/images/train.png'),
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Stations',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            trains[itemSelect]['stations']
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            // trainsData[selectedTrainName]!['stations']!
            //     .toString()

            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Seats',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Number of booked seats:8',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            'Number of available seats:40',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ));
}

Widget thirdPart(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 80.0,
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 12.0,
                          percent: 24 / 50,
                          progressColor: ColorTheme.saimon,
                          center: Text("${24.toString()}°C",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                        const SizedBox(height: 15),
                        title('Temperature', context),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 80.0,
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 12.0,
                          percent: 50 / 100,
                          progressColor: ColorTheme.saimon,
                          center: Text(50.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                        const SizedBox(height: 15),
                        title('Humidity', context),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                sensorIcon('Flame', true, context),
                const Spacer(),
                Row(
                  children: [
                    sensorIcon('Door Lock', false, context),
                    const Spacer(),
                    sensorIcon('Lights', true, context),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildTrainListItem(String text, context, int index) {
  return GestureDetector(
    onTap: () {
      itemSelect = index;
      selectedTrainName = text;
      AppCubit.get(context).selectPage();
    },
    child: MouseRegion(
      onEnter: (event) {
        itemHover = index;
        AppCubit.get(context).hoverEffect();
      },
      onExit: (event) {
        itemHover = index;
        AppCubit.get(context).hoverEffect();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isHover && itemHover == index
                    ? Colors.white54
                    : itemSelect == index
                        ? Colors.white54
                        : Colors.white)),
      ),
    ),
  );
}

Widget title(String text, BuildContext context) {
  return Text(text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(fontWeight: FontWeight.bold, color: ColorTheme.lightGray));
}

Widget sensorIcon(String text, var state, BuildContext context) {
  return Container(
      padding: const EdgeInsets.all(8),
      height: 130,
      width: 130,
      decoration: BoxDecoration(
          color: ColorTheme.blueGray, borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Icon(
          text == 'Flame'
              ? Icons.fire_extinguisher_outlined
              : text == 'Lights'
                  ? Icons.lightbulb
                  : state
                      ? Icons.lock_open_outlined
                      : Icons.lock,
          size: 85,
          color: state
              ? text == 'Flame'
                  ? Colors.red
                  : ColorTheme.primaryColor
              : ColorTheme.lightGray,
        ),
        title(text, context),
      ]));
}
