import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umte_project/services/notification_service.dart';
import 'package:umte_project/ui/components/meal/menu.dart';
import 'package:umte_project/ui/components/side_menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notificationService = Get.find<NotificationService>();
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
            iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
            backgroundColor: theme.primaryColor,
            titleTextStyle: theme.textTheme.headlineSmall!
                .copyWith(color: theme.colorScheme.onPrimary),
            title: Row(
              children: [
                Text("Home"),
                Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: CalendarDatePicker(
                                initialCalendarMode: DatePickerMode.day,
                                initialDate: _dateTime,
                                firstDate: DateTime(2020),
                                onDateChanged: (date) {
                                  setState(() {
                                    _dateTime = date;
                                  });
                                },
                                lastDate: DateTime(3000),
                              ),
                            );
                          });
                    },
                    icon: const Icon(Icons.calendar_month_rounded))
              ],
            )),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Menu(_dateTime),
          )
        ]),
      );
    });
  }
}
