import 'package:donation_com_mm_v2/controllers/donor_register_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_nrc_kit/mm_nrc_kit.dart';
import 'package:panara_dialogs/panara_dialogs.dart';


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
                    hintText: "Name *",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextField(
                controller: _companyNameController,
                decoration: InputDecoration(
                    hintText: "Business/Company Name *",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextField(
                controller: _positionController,
                decoration: InputDecoration(
                    hintText: "Position *",
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
                    hintText: "Phone *",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                    hintText: "Address *",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "English")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: NRCField(
  language: NrcLanguage.english,
  nrcValue: "NRC Number *",
  leadingTitleFontSize: 14,
  trailingTitleFontSize: 14,
  leadingTitleColor: Colors.black,
  backgroundColor: Colors.white,
  pickerItemColor: Colors.black,
  borderColor: Colors.grey.withOpacity(0.4),
  borderRadius: 10,
  borderWidth: 0.4,
  contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  onCompleted: (value) {
   _documentNumberController.text=value!;
  },
  onChanged: (value) {
    debugPrint("onChanged : $value");
  },
)
            ),

                Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: InkWell(
                  onTap: () => controller.pickFrontNrc(),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: ColorApp.bgColorGrey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_file_outlined,size: 25,),
                        SizedBox(width: 10,)
,                        Text("Upload Front NRC"),
                      ],
                    ),
                  ),
                ),
              ),
              if (controller.pickedFrontNrc != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Image.file(controller.pickedFrontNrc!, fit: BoxFit.cover),
                    ),
                  ),
                ),
              // Upload Back NRC
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: InkWell(
                  onTap: () => controller.pickBackNrc(),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: ColorApp.bgColorGrey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_file_outlined,size: 25,),
                        SizedBox(width: 10,)
,                        Text("Upload Back NRC"),
                      ],
                    ),
                  ),
                ),
              ),
              if (controller.pickedBackNrc != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Image.file(controller.pickedBackNrc!, fit: BoxFit.cover),
                    ),
                  ),
                ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 14.0),
            //   child: InkWell(
            //     onTap: (){
            //       controller.pickDiscussionImage();
            //     },
            //     child: Container(
            //       padding: const EdgeInsets.all(16),
            //       decoration: const BoxDecoration(
            //         color: ColorApp.bgColorGrey,
                
            //         borderRadius: BorderRadius.all(Radius.circular(15))
            //       ),
            //       child: const Text("Upload NRC"),),
            //   )
            // ),
            //  GetBuilder<DonorRegisterController>(builder: (controller)=>controller.pickedDocumentImage!=null?   Padding(
            //    padding: const EdgeInsets.only(top: 20.0,left: 10),
            //   child: SizedBox(height: 150,width: double.infinity,child: ClipRRect(
            //     borderRadius: const BorderRadius.all(Radius.circular(15)),
            //     child: Image.file(controller.pickedDocumentImage!,fit: BoxFit.cover,)),)
            // ):const SizedBox()),
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
                   
                           if(_nameController.text.isNotEmpty&&_companyNameController.text.isNotEmpty&&_positionController.text.isNotEmpty&&_phoneController.text.isNotEmpty&&_addressController.text.isNotEmpty&&_documentNumberController.text.isNotEmpty&&controller.pickedFrontNrc!=null){
                                controller.register(_nameController.text, _addressController.text, _phoneController.text,_companyNameController.text,_positionController.text, _documentNumberController.text, context);
                           }else{
                            PanaraInfoDialog.showAnimatedGrow(
                  context,
                  message: "Incomplete Info",
                  buttonText: "Okay",
                  onTapDismiss: () {
                    Navigator.pop(context);
                  },
                  panaraDialogType: PanaraDialogType.warning,
                );
                           }
                  
                    },
                  ),
                )),
                const SizedBox(height: 20,)
          ],
        ),
      ),),
    );
  }
}
