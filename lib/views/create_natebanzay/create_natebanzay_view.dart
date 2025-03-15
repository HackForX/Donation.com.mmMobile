import 'package:donation_com_mm_v2/controllers/create_natebanzay_controller.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:donation_com_mm_v2/views/create_natebanzay/widgets/item_dropdown.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class CreateNatebanzayView extends GetView<CreateNatebanzayController> {
   CreateNatebanzayView({super.key});

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _quantityController=TextEditingController();
  final TextEditingController _addressController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();
  final TextEditingController _noteController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
   WidgetsBinding.instance.addPostFrameCallback((_){
      controller.getItems();
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
                child: Text("ပစ္စည်းလှူမည်",
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
                  
                    hintText: "ပစ္စည်းအမည် *",
                
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
                  // if(!isBurmeseDigits(value)){
                  // return "ဥပမာ-၁၀၀,၂၀၀,၃၀၀(ကွက်လပ်မပါရ)";
                  // }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "အရေအတွက် *",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:14.0),
              child: ItemDropdown(controller: controller),
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
                    hintText: "လိပ်စာ *",
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
                    hintText: "ဖုန်းနံပတ် *",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                  validator: (value){
                  if(value==null||value.isEmpty){
                    return "မှတ်ချက်လိုအပ်ပါသည်";
                  }
                  return null;
                },
                controller: _noteController,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "မှတ်ချက် *",
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
                  child: const Text("ပုံတင်မည် *"),),
              )
            ),
            Padding(
               padding: const EdgeInsets.only(top: 14.0,left: 10),
              child: controller.pickedPhotos.isEmpty?const SizedBox():SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: controller.pickedPhotos.map((e) => ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: SizedBox(
                    height: 120,
                    width: 200,
                    child: Image.file(e,fit: BoxFit.cover,)),
                ))).toList(),),)),
              Padding(
               padding: const EdgeInsets.only(top: 14.0,left: 10),
              child: controller.pickedPhotos.isEmpty?const Text("ပုံလိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),):const SizedBox(),
            ),
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
                      controller.createNatebanzay(_nameController.text, _quantityController.text, _addressController.text, MySharedPref.getUserId()??11,controller.selectedItem.id, _phoneController.text, "pending",_noteController.text,context);
                    }else{
                   PanaraInfoDialog.showAnimatedGrow(
                  context,
                  // title: "Donation.com.mm",
                  message: "Incomplete Info",
                  buttonText: "Okay",
                  onTapDismiss: () {
                    Navigator.pop(context);
                  },
                  panaraDialogType: PanaraDialogType.warning,
                );
                    }
                  },
                  child: Text(
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
}