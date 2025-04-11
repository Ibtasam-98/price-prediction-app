import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:priceprediction/config/sized_box.dart';
import 'package:priceprediction/widget/custom_button.dart';
import '../../config/app_colors.dart';
import '../../controller/house_price_prediction_controller.dart';
import '../../widget/custom_card.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/custom_slider.dart';
import '../../widget/custom_text.dart';


class HousePricePredictionScreen extends StatelessWidget {
  final HousePricePredictionController controller = Get.put(HousePricePredictionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ... (Input fields)
            InputContainer(
              label: 'Area (sqft)',
              index: 0,
              child: SliderInput(
                value: controller.area.value,
                onChanged: (val) => controller.area.value = val,
                min: 100,
                max: 10000,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Bedrooms',
              index: 1,
              child: SliderInput(
                value: controller.bedrooms.value.toDouble(),
                onChanged: (val) => controller.bedrooms.value = val.toInt(),
                min: 1,
                max: 6,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Bathrooms',
              index: 2,
              child: SliderInput(
                value: controller.bathrooms.value.toDouble(),
                onChanged: (val) => controller.bathrooms.value = val.toInt(),
                min: 1,
                max: 4,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Stories',
              index: 3,
              child: SliderInput(
                value: controller.stories.value.toDouble(),
                onChanged: (val) => controller.stories.value = val.toInt(),
                min: 1,
                max: 4,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Parking',
              index: 4,
              child: SliderInput(
                value: controller.parking.value.toDouble(),
                onChanged: (val) => controller.parking.value = val.toInt(),
                min: 0,
                max: 3,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Main Road',
              index: 5,
              child: DropdownInput(
                value: controller.mainroad.value,
                items: ['yes', 'no'],
                onChanged: (val) => controller.mainroad.value = val!,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Guest Room',
              index: 6,
              child: DropdownInput(
                value: controller.guestroom.value,
                items: ['yes', 'no'],
                onChanged: (val) => controller.guestroom.value = val!,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Basement',
              index: 7,
              child: DropdownInput(
                value: controller.basement.value,
                items: ['yes', 'no'],
                onChanged: (val) => controller.basement.value = val!,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Hot Water Heating',
              index: 8,
              child: DropdownInput(
                value: controller.hotwaterheating.value,
                items: ['yes', 'no'],
                onChanged: (val) => controller.hotwaterheating.value = val!,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Air Conditioning',
              index: 9,
              child: DropdownInput(
                value: controller.airconditioning.value,
                items: ['yes', 'no'],
                onChanged: (val) => controller.airconditioning.value = val!,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Preferred Area',
              index: 10,
              child: DropdownInput(
                value: controller.prefarea.value,
                items: ['yes', 'no'],
                onChanged: (val) => controller.prefarea.value = val!,
              ),
            ),
            AppSizedBox.space15h,
            InputContainer(
              label: 'Furnishing Status',
              index: 11,
              child: DropdownInput(
                value: controller.furnishingstatus.value,
                items: ['furnished', 'semi-furnished', 'unfurnished'],
                onChanged: (val) => controller.furnishingstatus.value = val!,
              ),
            ),
            AppSizedBox.space30h,
            Obx(() => CustomButton(
              haveBgColor: true,
              btnTitle: controller.isPredicting.value ? "" : "Predict",
              btnTitleColor: AppColors.white,
              bgColor: AppColors.primary,
              borderRadius: 45.r,
              height: 45.h,
              onTap: controller.isPredicting.value
                  ? null
                  : () {
                controller.predictPrice(context);
              },
              child: controller.isPredicting.value
                  ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              )
                  : null,
            )),
            if (!controller.isPredicting.value)
              Column(
                children: [
                  AppSizedBox.space20h,
                  Obx(() => controller.predictedPrice.value > 0
                      ? Column(
                    children: [
                      CustomText(
                        title: 'Predicted Price: \$${NumberFormat('#,###').format(controller.predictedPrice.value)}',
                        fontSize: 15.sp,
                      ),
                      AppSizedBox.space10h,
                      CustomText(
                        title: 'Classification: ${controller.priceClassification.value}', // Show classification
                        fontSize: 15.sp,
                      ),
                    ],
                  )
                      : SizedBox.shrink()),
                  AppSizedBox.space30h,
                ],
              ),
            AppSizedBox.space30h,
          ],
        ),
      )),
    );
  }
}