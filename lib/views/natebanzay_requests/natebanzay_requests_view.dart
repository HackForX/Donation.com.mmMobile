import 'package:donation_com_mm_v2/controllers/natebanzay_request_controller.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/views/chat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NatebanzayRequestsView extends GetView<NatebanzayRequestController> {
 
   NatebanzayRequestsView({super.key,});

final natebanzayId=Get.arguments['natebanzay_id'];


  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_){
controller.getRequests(natebanzayId);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("တောင်းဆိုထားသူများ"),
      ),
      body: Obx(()=>ListView.builder(
        itemCount: controller.natebanzaysRequests.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            elevation: 0,
            color: ColorApp.mainColor,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
         child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(()=>     Text(switchStatus(controller.natebanzaysRequests[index].status),style: const TextStyle(color: ColorApp.white,fontWeight: FontWeight.w600,fontSize: 15),),),
                     const SizedBox(height: 10,),
                Text(controller.natebanzaysRequests[index].requester.name,style: const TextStyle(color: ColorApp.white,fontWeight: FontWeight.w600,fontSize: 15),),
                const SizedBox(height: 10,),
                 Text(controller.natebanzaysRequests[index].requester.phone,style: const TextStyle(color: ColorApp.white,fontWeight: FontWeight.w600,fontSize: 12),),

              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  
                  onTap: (){
                  showInfoDialog(context, () {
                                 controller.acceptRequest(controller.natebanzaysRequests[index].id,context);
                     }, "လက်ခံမှာသေချာပီလား နောက်တစ်ကြိမ်ပြန်လုပ်၍မရပါ");
                  }, child:  Text("လက်ခံမည်",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,color: ColorApp.green),))
                  ,
                  const SizedBox(height: 10,),
                  InkWell(
                  
                  onTap: (){
                    showInfoDialog(context, () {
                                 controller.rejectRequest(controller.natebanzaysRequests[index].id,context);
                     }, "ငြင်းပယ်မှာသေချာပီလား နောက်တစ်ကြိမ်ပြန်လုပ်၍မရပါ");
           
                  }, child:  Text("ငြင်းပယ်မည်",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,color: ColorApp.lipstick),)),
                  const SizedBox(height: 10,),

               controller.natebanzaysRequests[index].status=='Accepted'?    InkWell(
                  
                  onTap: (){
                 Get.toNamed(Routes.chat,arguments: {
                  'requester_id':controller.natebanzaysRequests[index].requesterId,
                  'uploader_id':controller.natebanzaysRequests[index].uploaderId,
                  'isRequester':false
                 });
           
                  }, child:  Text("စကားပြောမည်",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,color: ColorApp.secondaryColor),)):const SizedBox()
              ],
            ),
          )
         ],),
       ),
          );
        },
      ),)
      
    );
  }


void showInfoDialog(BuildContext context,VoidCallback onTap,String title){
showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Donation.com.mm'),
            content:  Text(title),
            actions: [
              TextButton(
                onPressed: () =>Get.back(),
                child: const Text('မလုပ်တော့ပါ'),
              ),
              TextButton(
                onPressed: () {
                 onTap();
                  Get.back();
                },
                child: const Text('လုပ်မည်'),
              ),
            ],
          ),
        );
}

String switchStatus(String status){
  switch (status) {
    case 'pending':
      return 'စောင့်ဆိုင်းဆဲ';
       case 'Accepted':
      return 'လက်ခံပြီး';
      case 'Rejected':
      return 'ငြင်းပယ်ပြီး';
      
    default: return '';
  }
}

}