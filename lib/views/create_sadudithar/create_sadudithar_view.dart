import 'package:donation_com_mm_v2/controllers/create_natebanzay_controller.dart';
import 'package:donation_com_mm_v2/controllers/create_sadudithar_controller.dart';
import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:donation_com_mm_v2/views/create_natebanzay/widgets/item_dropdown.dart';
import 'package:donation_com_mm_v2/views/create_sadudithar/widgets/category_dropdown.dart';
import 'package:donation_com_mm_v2/views/create_sadudithar/widgets/city_dropdown.dart';
import 'package:donation_com_mm_v2/views/create_sadudithar/widgets/map_view.dart';
import 'package:donation_com_mm_v2/views/create_sadudithar/widgets/sub_category_dropdown.dart';
import 'package:donation_com_mm_v2/views/create_sadudithar/widgets/township_dropdown.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateSaduditharView extends GetView<CreateSaduditharController> {
   CreateSaduditharView({super.key});

  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();
  final TextEditingController _estimatedAmountController=TextEditingController();
  final TextEditingController _estimatedTimeController=TextEditingController();
  final TextEditingController _estimatedQuantityController=TextEditingController();
  final TextEditingController _addressController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   WidgetsBinding.instance.addPostFrameCallback((_){
      controller.getCategories();
      controller.getCities();
 
    });
  return Obx( ()=>Scaffold(
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
                child: Text("စတုဒိသာကျွေးမည်",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.only(top: 20.0),
              child: TextFormField(
              controller: _titleController,
                validator: (value){
                  if(value==null||value.isEmpty){
                    return "အလှုအမည်လိုအပ်ပါသည်";
                  }
                  return null;
                },
            
                decoration: InputDecoration(
                  
                    hintText: "အလှုအမည်",
                
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                controller: _descriptionController,
                 validator: (value){
                  if(value==null||value.isEmpty){
                    return "အကြောင်းအရာလိုအပ်ပါသည်";
                  }
               
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "အကြောင်းအရာ",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                controller: _addressController,
                 validator: (value){
                  if(value==null||value.isEmpty){
                    return "နေရာလိုအပ်ပါသည်";
                  }
               
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "နေရာ",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: CategoryDropDown(controller: controller),
            ),
           controller.selectedCategory=='အမျိုးအစားရွေးပါ'?   const Padding(
               padding: EdgeInsets.only(top: 20.0,left: 10),
              child:   Text("အမျိုးအစားလိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),)
             ):const SizedBox(),
                 Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: SubCategoryDropDown(controller: controller),
            ),
             controller.selectedSubCategory.name=='အမျိုးအစားခွဲရွေးပါ'?   const Padding(
               padding: EdgeInsets.only(top: 20.0,left: 10),
              child:   Text("အမျိုးအစားခွဲလိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),)
             ):const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                 validator: (value){
                  if(value==null||value.isEmpty){
                    return "အရေအတွက်လိုအပ်ပါသည်";
                  }
                  //    if(!isBurmeseDigits(value)){
                  // return "ဥပမာ-၁၀၀,၂၀၀,၃၀၀(ကွက်လပ်မပါရ)";
                  // }
                  return null;
                },
                controller: _estimatedQuantityController,
                decoration: InputDecoration(
                    hintText: "အရေအတွက်",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                 validator: (value){
                  if(value==null||value.isEmpty){
                    return "ခန့်မှန်းလိုအပ်ပါသည်";
                  }
                    
                  return null;
                },
                controller: _estimatedAmountController,
                decoration: InputDecoration(
                    hintText: "ခန့်မှန်းကုန်ကျငွေ",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                 validator: (value){
                  if(value==null||value.isEmpty){
                    return "အလှုအချိန်လိုအပ်ပါသည်";
                  }
                    
                  return null;
                },
                controller: _estimatedTimeController,
                decoration: InputDecoration(
                    hintText: "အလှုအချိန်",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
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
            ),Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: CityDropDown(controller: controller),
            ),
                controller.selectedCity.name=='မြို့ရွေးပါ'?   const Padding(
               padding: EdgeInsets.only(top: 20.0,left: 10),
              child:   Text("မြို့လိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),)
             ):const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: TownshipDropDown(controller: controller),
            ),
                controller.selectedTownship.name=='မြို့နယ်ရွေးပါ'?   const Padding(
               padding: EdgeInsets.only(top: 20.0,left: 10),
              child:   Text("မြို့နယ်လိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),)
             ):const SizedBox(),
              Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: InkWell(
                onTap: ()async{
              var date= await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2024),
  lastDate: DateTime(2025),
);
//  String formattedDate = DateFormat('MMM d, y').format(date!);
 controller.setEventDate(date!);
// print(formattedDate);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: ColorApp.bgColorGrey,
                
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:  Text(controller.eventDate==null?"နေ့ရက်":DateFormat('MMM d,y').format(controller.eventDate!)),),
              )
            ),
                controller.eventDate==null?   const Padding(
               padding: EdgeInsets.only(top: 20.0,left: 10),
              child:   Text("နေ့ရက်လိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),)
             ):const SizedBox(),
             Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: InkWell(
                onTap: ()async{
     
                  if(controller.eventDate==null){
ToastHelper.showErrorToast(context, "နေ့ရက်အရင်ရွေးရမည်");
                  }{
     var time=     await showTimePicker(
  context: context,
initialTime: TimeOfDay.now()
);
 DateTime tempDate =  DateTime(controller.eventDate!.year, controller.eventDate!.month,controller.eventDate!.day, time!.hour, time.minute);
    // var dateFormat = ; 
    controller.setSelectedStartTime(tempDate);
                  }

                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: ColorApp.bgColorGrey,
                
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:  Text(controller.selectedStartTime==null?"စတင်မည့်အချိန်":DateFormat("h:mm a").format(controller.selectedStartTime!)),),
              )
            ),
                controller.selectedStartTime==null?   const Padding(
               padding: EdgeInsets.only(top: 20.0,left: 10),
              child:   Text("စတင်မည့်အချိန်လိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),)
             ):const SizedBox(),
             Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: InkWell(
                onTap: ()async{


                  if(controller.eventDate==null){
ToastHelper.showErrorToast(context, "နေ့ရက်အရင်ရွေးရမည်");
                  }{
     var time=     await showTimePicker(
  context: context,
initialTime: TimeOfDay.now()
);
 DateTime tempDate =  DateTime(controller.eventDate!.year, controller.eventDate!.month,controller.eventDate!.day, time!.hour, time.minute);
    // var dateFormat = ; 
    controller.setSelectedEndTime(tempDate);

                  }




                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: ColorApp.bgColorGrey,
                
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:  Text(controller.selectedEndTime==null?"ပြီးဆုံးမည့်အချိန်":DateFormat("h:mm a").format(controller.selectedEndTime!)),),
              )
            ),
                controller.selectedEndTime==null?   const Padding(
               padding: EdgeInsets.only(top: 20.0,left: 10),
              child:   Text("ပြီးဆုံးမည့်အချိန်လိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),)
             ):const SizedBox(),
               Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: InkWell(
                onTap: (){
                  controller.pickImage();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: ColorApp.bgColorGrey,
                
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: const Text("ပုံတင်မည်"),),
              )
            ),
          GetBuilder<CreateSaduditharController>(builder: (controller)=>controller.pickedImage==null?  const Padding(
               padding: EdgeInsets.only(top: 20.0,left: 10),
              child: Text("ပုံလိုအပ်ပါသည်",style: TextStyle(color: ColorApp.lipstick,fontSize: 12,fontWeight: FontWeight.w200,fontFamily: "Myanmar"),)
            ):const SizedBox()),
             Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: InkWell(
                onTap: (){
                  Get.to(()=>const MapView());
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: ColorApp.bgColorGrey,
                
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:  Text(controller.pickedAddress),),
              )
            ),
            const SizedBox(height: 25,),
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
                    if(_formKey.currentState!.validate()&&controller.eventDate!=null&&controller.selectedStartTime!=null&&controller.selectedEndTime!=null){
                         controller.createSadudithar(CreateSaduditharModel(title: _titleController.text, description: _descriptionController.text, categoryId: controller.selectedSubCategory.id, cityId: controller.selectedCity.id, townshipId: controller.selectedTownship.id, type: controller.selectedCategory, estimatedAmount:int.parse( _estimatedAmountController.text), estimatedTime: _estimatedTimeController.text, estimatedQuantity: _estimatedQuantityController.text, actualStartTime: controller.selectedStartTime!, actualEndTime: controller.selectedEndTime!, address: _addressController.text, phone: _phoneController.text, status: "pending", eventDate: controller.eventDate!, latitude:controller.pickedLat, longitude: controller.pickedLong), context);
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
  return  burmeseDigitRegex.hasMatch(value);
}
}