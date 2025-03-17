import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_gmaps/app_gmap_provder.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppGMapsView extends StatefulWidget {
  const AppGMapsView({super.key});

  @override
  State<AppGMapsView> createState() => _AppGMapsViewState();
}

class _AppGMapsViewState extends State<AppGMapsView> {
  late AppGMapProvider gmap;

  @override
  void initState() {
    super.initState();
    gmap = AppGMapProvider();
    gmap.getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => gmap,
      child: Consumer<AppGMapProvider>(builder: (context, gmap, child) {
        if (gmap.isLoading) {
          return const Center(
            child: Loader(),
          );
        } else {
          return Scaffold(
            appBar: appBar(
              context,
              appBarheight: 5.h,
              leftWidget: GestureDetector(
                onTap: () {
                  Navigator.pop(
                      context); // Close the map and return to the previous screen
                },
                child: const AppSvg(
                  svgName: arrowBack,
                  boxfit: BoxFit.none,
                ),
              ),
              title: "PICK AN ADDRESS",
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField(
                    textController: gmap.selectedAddress,
                    isTextFieldEnabled: false,
                    placeholder: "Selected Address",
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: gmap.pickedLocation,
                      zoom: 14.0,
                    ),
                    onMapCreated: (controller) {
                      gmap.mapController = controller;
                    },
                    onTap: (LatLng position) async {
                      await gmap.selectLocation(position);
                    },
                    markers: {
                      if (gmap.locationMarker != null) gmap.locationMarker!,
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    child: App3DButton(
                      tap: () {
                        Navigator.pop(context, {
                          'latitude': gmap.pickedLocation.latitude,
                          'longitude': gmap.pickedLocation.longitude,
                          'address': gmap.selectedAddress,
                        });
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      borderColor: greenishBlack,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: whiteColor,
                            size: 20.sp,
                          ),
                          SizedBox(width: 2.5.w),
                          AppTextMedium(
                            text: "Confirm",
                            color: whiteColor,
                            fontFamily: FontFamily.hermann,
                            fontSize: 17.sp,
                          )
                        ],
                      ),
                    )),
              ],
            ),
          );
        }
      }),
    );
  }
}
