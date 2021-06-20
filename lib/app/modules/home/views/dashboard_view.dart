import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:home_fi/app/global_widgets/room_selector.dart';
import 'package:home_fi/app/global_widgets/smart_systems.dart';
import 'package:home_fi/app/global_widgets/user_avathar.dart';
import 'package:home_fi/app/modules/home/controllers/home_controller.dart';
import 'package:home_fi/app/theme/color_theme.dart';
import 'package:home_fi/app/theme/text_theme.dart';

class DashboardView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.067),
      height: size.height,
      width: size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: size.height * 0.08),
          GetBuilder<HomeController>(
            id: 7,
            builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome\nHome, ${controller.userName}',
                    style: HomeFiTextTheme.kSubHeadTextStyle
                        .copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                  GestureDetector(
                    // onTap: () => Get.to(() => ProfileView()),
                    child: UserAvatar(
                      ismale: controller.isMale,
                      radius: size.width * 0.075,
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: size.height * 0.03),
          Expanded(
            child: Container(
              width: size.width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Rooms',
                      style: HomeFiTextTheme.kSub2HeadTextStyle
                          .copyWith(color: Theme.of(context).primaryColorDark),
                    ),
                    SizedBox(height: size.height * 0.02),
                    GetBuilder<HomeController>(
                      init: HomeController(),
                      id: 1,
                      builder: (_) {
                        return Container(
                          width: size.width,
                          height: size.height * 0.12,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.rooms.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: RoomSelector(
                                  roomName: controller.rooms[index].roomName,
                                  roomImageURL:
                                      controller.rooms[index].roomImgUrl,
                                  isSelected: controller.selectedRoom[index],
                                  onTap: () {},
                                ),
                                onTap: () {
                                  controller.roomChange(index);
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    !controller.isReady.value
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          )
                        : StreamBuilder<List<int>>(
                            stream: controller.stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<int>> snapshot) {
                              if (snapshot.hasError) return Text('NULL');

                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                controller.retreveSensorData(snapshot.data);

                                return Container(
                                  width: Get.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TempHumidBanner(
                                        img: 'assets/icons/temperature.png',
                                        title: 'Temperature',
                                        value: '${controller.temp.value}°C',
                                        horizontalPadding: Get.width * 0.035,
                                      ),
                                      TempHumidBanner(
                                        img: 'assets/icons/humidity.png',
                                        title: 'Humidity',
                                        value: '${controller.humidity.value}%',
                                        horizontalPadding: Get.width * 0.044,
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Text('Null');
                              }
                            },
                          ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'Smart Systems',
                      style: HomeFiTextTheme.kSub2HeadTextStyle
                          .copyWith(color: Theme.of(context).primaryColorDark),
                    ),
                    SizedBox(height: size.height * 0.03),
                    GetBuilder<HomeController>(
                      id: 2,
                      builder: (_) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmartSystem(
                                  size: size,
                                  color: GFTheme.lightPurple,
                                  index: 0,
                                  title: 'LED Light',
                                  imageUrl: 'assets/images/icons8-light-96.png',
                                ),
                                SmartSystem(
                                  size: size,
                                  color: GFTheme.lightBlue,
                                  index: 1,
                                  title: 'RGB LED',
                                  imageUrl:
                                      'assets/images/icons8-rgb-lamp-96.png',
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmartSystem(
                                  size: size,
                                  color: GFTheme.lightYellow,
                                  index: 2,
                                  title: 'Music Player',
                                  imageUrl:
                                      'assets/images/icons8-music-record-96.png',
                                ),
                                SmartSystem(
                                  size: size,
                                  color: GFTheme.lightPeach,
                                  index: 3,
                                  title: 'LED Light 2',
                                  imageUrl: 'assets/images/icons8-light-96.png',
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.14),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TempHumidBanner extends GetView<HomeController> {
  final HomeController controller = Get.put(HomeController());
  final double horizontalPadding;
  final String img;
  final String title;
  final String value;

  TempHumidBanner({
    required this.img,
    required this.title,
    required this.value,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.08,
      width: Get.width * 0.4,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: AssetImage(
              img,
            ),
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(flex: 4),
              Text(
                value,
                style: HomeFiTextTheme.kSub2HeadTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(flex: 2),
              Text(
                title,
                style: HomeFiTextTheme.kSub2HeadTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 12,
                ),
              ),
              Spacer(flex: 4),
            ],
          ),
        ],
      ),
    );
  }
}
