import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_getx_api_demo/sccreen/data_screen/data_controller.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final DataController dataController = Get.put(DataController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          dataController.isMoreDataAvailable.value &&
          !dataController.isLoading.value) {
        dataController.dataPosts();
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (dataController.dataList.isEmpty &&
              dataController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: dataController.dataList.length,
            itemBuilder: (context, index) {
              if (index < dataController.dataList.length) {
                final data = dataController.dataList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(data.id.toString())),
                    title: Text(data.title.toString()),
                    subtitle: Text(data.body.toString()),
                  ),
                );
              } else {
                return Obx(() => dataController.isMoreDataAvailable.value
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox());
              }
            },
          );
        }),
      ),
    );
  }
}
