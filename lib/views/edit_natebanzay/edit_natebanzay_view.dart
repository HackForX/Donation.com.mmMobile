import 'package:donation_com_mm_v2/controllers/edit_natebanzay_controller.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:donation_com_mm_v2/views/edit_natebanzay/widgets/edit_item_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/views/create_natebanzay/widgets/item_dropdown.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';

import 'package:get/get.dart';

class EditNatebanzayView extends GetView<EditNatebanzayController> {
   EditNatebanzayView({super.key,});
final natebanzay=Get.arguments['natebanzay'];

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _quantityController=TextEditingController();
  final TextEditingController _addressController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();
  final TextEditingController _noteController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
   List<String> _photos=[];

  @override
  Widget build(BuildContext context) {
   WidgetsBinding.instance.addPostFrameCallback((_){
      controller.getItems();
      _nameController.text=natebanzay.name;
      _quantityController.text=natebanzay.quantity;
      _addressController.text=natebanzay.address;
      _phoneController.text=natebanzay.phone;
      _noteController.text=natebanzay.note??"";
      if(natebanzay.photos!=null){
        _photos=extractPhotos(natebanzay.photos)  ;
      }
      
      controller.setItem(natebanzay.item);


    });
  return Obx(()=>Scaffold(
      drawer:  DrawerView(),

      appBar: AppBar(
        title: const Text(
          "Donation.com.mm",
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text("ပြင်ဆင်မည်",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.only(top: 14.0),
              child: TextFormField(
               
              controller: _nameController,
                validator: (value){
                  if(value==null||value.isEmpty){
                    return "ပစ္စည်းအမည်လိုအပ်ပါသည်";
                  }
                  return null;
                },
            
                decoration: InputDecoration(
                  
                    hintText: "ပစ္စည်းအမည်",
                
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextFormField(
               
                controller: _quantityController,
                 validator: (value){
                  if(value==null||value.isEmpty){
                    return "အရေအတွက်လိုအပ်ပါသည်";
                  }
                  if(!isBurmeseDigits(value)){
                  return "ဥပမာ-၁၀၀,၂၀၀,၃၀၀(ကွက်လပ်မပါရ)";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "အရေအတွက်",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:14.0),
              child: EditItemDropdown(controller: controller),
            ),
     controller.selectedItem.name=='အမျိုးအစားရွေးပါ'?  const Padding(
               padding: EdgeInsets.only(top: 14.0,left: 10),
              child:    Text("အမျိုးအစားလိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),)
            ):const SizedBox(),
            
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextFormField(
             
                 validator: (value){
                  if(value==null||value.isEmpty){
                    return "လိပ်စာလိုအပ်ပါသည်";
                  }
                  return null;
                },
                controller: _addressController,
                decoration: InputDecoration(
                    hintText: "လိပ်စာ",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextFormField(
             
                keyboardType: TextInputType.number,
                 validator: (value){
                  if(value==null||value.isEmpty){
                    return "ဖုန်းနံပတ်လိုအပ်ပါသည်";
                  }
                  return null;
                },
                

              controller: _phoneController,
                decoration: InputDecoration(
                    hintText: "ဖုန်းနံပတ်",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextFormField(
              
                  validator: (value){
                  if(value==null||value.isEmpty){
                    return "မှတ်ချက်လိုအပ်ပါသည်";
                  }
                  return null;
                },
                controller: _noteController,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "မှတ်ချက်",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
           Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: InkWell(
                onTap: (){
                  controller.pickPhotos();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: ColorApp.bgColorGrey,
                
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:  Text(_photos.isNotEmpty?"ပုံ${_photos.length}ပုံတင်ထားပါသညါ":"ပုံတင်မည်")),
              )
            ),
            // Padding(
            //    padding: const EdgeInsets.only(top: 14.0,left: 10),
            //   child: controller.pickedPhotos.isEmpty||_photos.isEmpty?const Text("ပုံလိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),):const SizedBox(),
            // ),
            const SizedBox(height: 60,),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorApp.kDarkGray,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'English',
                        color: ColorApp.white),
                  )),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorApp.mainColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () {
                    if(_formKey.currentState!.validate()&&controller.selectedItem.name!='အမျိုးအစားရွေးပါ'){
                      controller.editNatebanzay(natebanzay.id,_nameController.text, _quantityController.text, _addressController.text, MySharedPref.getUserId()??11,controller.selectedItem.id, _phoneController.text, "pending",_noteController.text,context);
                    }else{
                      ToastHelper.showErrorToast(context, "လိုအပ်များရှိနေပါသည်");
                    }
                  },
                  child: controller.apiCallStatus==ApiCallStatus.loading?const ButtonLoaderWidget():Text(
                    "Save",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'English',
                        color: ColorApp.white),
                  )),
            ),
          ),
        ]),
      ),
    ));
  }


  bool isBurmeseDigits(String value) {
 final burmeseDigitRegex = RegExp(r'^[\u1040-\u1049]+$');
 print(burmeseDigitRegex.hasMatch(value));
  return  burmeseDigitRegex.hasMatch(value);
}


List<String> extractPhotos(String jsonString) {

  final photosWithoutEscape = jsonString.replaceAll('\\', '');

  final photosWithoutBrackets = photosWithoutEscape.substring(2, photosWithoutEscape.length - 2);

  final imageUrls = photosWithoutBrackets.split('","');

  return imageUrls;
}
}