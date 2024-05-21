import 'package:donation_com_mm_v2/controllers/natebanzay_details_controller.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NatebanzayCommentsView extends GetView<NatebanzayDetailsController> {
   NatebanzayCommentsView({super.key});

   final natebanzayId=Get.arguments['natebanzay_id'];
 

  final TextEditingController _commentController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => controller.getComments(natebanzayId),);
    return Scaffold(
      appBar: AppBar(title: const Text("မှတ်ချက်များ"),),
      body:Obx(()=>ListView.builder(
        itemCount: controller.comments.length,
        itemBuilder: (BuildContext context, int index) {
          return  Container(
            padding: const EdgeInsets.only(top: 18, left: 15),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
            decoration: const BoxDecoration(color: ColorApp.bgColor),
            child: Row(
              children: [
                 const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(ImagePath.profile),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                             
                            DateFormat('MMM d, y').format(DateTime.parse( controller.comments[index].createdAt))   ,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorApp.dark,
                                    fontFamily: "English"),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                           controller.comments[index].user.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorApp.dark,
                                    fontFamily: "English"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                       controller.comments[index].comment,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorApp.dark,
                            fontFamily: "English"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),),
      bottomNavigationBar: Form(
        key: _formKey,
        child: Padding(
          padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom ),
          child: Container(
                 height: 80,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child:  Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextFormField
                  (
                    
                    controller: _commentController,
                    validator: (value){
                      if(value==null||value.isEmpty){
                  return "မှတ်ချက်ရေးရန်";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      
                      contentPadding: EdgeInsets.all(5),
                      hintStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                      hintText: "မှတ်ချက်ရေးရန်"
                    ),
                  ),
                ),
                Expanded(child: GestureDetector(onTap: (){
               if(_formKey.currentState!.validate()){
                 controller.comment(natebanzayId, MySharedPref.getUserId()!, _commentController.text, context);
                 _commentController.clear() ;
               }
                },child: Image.asset(IconPath.sendIcon,height: 30,),))
              ],
            )
          ),
        ),
      ),
    );
  }
}