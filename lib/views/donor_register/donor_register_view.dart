import 'package:donation_com_mm_v2/controllers/donor_register_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DonorRegisterView extends GetView<DonorRegisterController> {
   DonorRegisterView({super.key});

    final TextEditingController _nameController=TextEditingController();
    final TextEditingController _companyNameController=TextEditingController();
    final TextEditingController _positionController=TextEditingController();
  final TextEditingController _addressController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();
  final TextEditingController _documentNumberController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  DrawerView(),
      appBar: AppBar(
        title: const Text("Donation.com.mm"),
      ),
      body: GetBuilder<DonorRegisterController>(builder: (controller)=>Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: Text("Apply For Donor Account",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w300,
                        fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextField(
                controller: _companyNameController,
                decoration: InputDecoration(
                    hintText: "Business/Company Name",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextField(
                controller: _positionController,
                decoration: InputDecoration(
                    hintText: "Position",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _phoneController,
                decoration: InputDecoration(
                    hintText: "Phone",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                    hintText: "Address",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextField(
                keyboardType: TextInputType.number,

                controller: _documentNumberController,
                decoration: InputDecoration(
                    hintText: "NRC Number",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: InkWell(
                onTap: (){
                  controller.pickDiscussionImage();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: ColorApp.bgColorGrey,
                
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: const Text("Upload NRC"),),
              )
            ),
            Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        backgroundColor: ColorApp.mainColor),
                    child: controller.apiCallStatus==ApiCallStatus.loading?const ButtonLoaderWidget():Text(
                      "Submit",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: ColorApp.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: "English"),
                    ),
                    onPressed: () {
                      controller.register(_nameController.text, _addressController.text, _phoneController.text,_companyNameController.text,_positionController.text, int.parse(_documentNumberController.text), context);
                    },
                  ),
                )),
          ],
        ),
      ),),
    );
  }
}
