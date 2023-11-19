import 'dart:io';

import 'package:e_commerce_app/bloc/cubit_app/app_cubit.dart';
import 'package:e_commerce_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/cubit_app/app_states.dart';

class AccountScreen extends StatelessWidget {

  var nameController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        var userModel = cubit.userInformation!;
        var profileImage = cubit.profileImage;
        nameController.text = userModel['name'];
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Account',style: TextStyle(
              color: Colors.black,
            ),),
          ),
          body: Column(
            children: [
                     Expanded(
                      child: Column(
                        children: [
                          Stack(
                                children: [
                                  SizedBox(
                                      height: 140 ,
                                      width: 140,
                                      child: profileImage == null
                                          ? Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvsGJtwiPbdQn-A7F9_1u1YUNV-IRvHGG-nA&usqp=CAU', fit: BoxFit.cover)
                                          : Image(image: FileImage(profileImage)),),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: (){
                                        cubit.getProfileData();
                                      },
                                      icon: const CircleAvatar(
                                        radius: 20,
                                        child: Icon(Icons.camera_alt_outlined,size: 16,),
                                      ),
                                    ),
                                  ),
                           ],
                        ),
                      ],
                    ),
              ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           userModel['name'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                         const SizedBox(
                           height: 12,
                         ),
                         IconButton(
                             onPressed: (){
                               changeUserName(context);
                             },
                             icon: const Icon(Icons.edit_outlined,size: 16,color: Colors.green,))
                       ],
                     ),
                     Text(
                       userModel['email'],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.shopping_bag_outlined),
                      title: const Text('Your Orders'),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.favorite_outline),
                      title: const Text('Favorite'),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.info_outline),
                      title: const Text('About Us'),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.support_outlined),
                      title: const Text('Support'),
                    ),
                    ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.change_circle_outlined),
                      title: const Text('Change Password'),
                    ),
                    ListTile(
                      onTap: (){

                      },
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Log out'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text('Version 1.0.0'),
                  ],
                ),
              ),
            ],
          ),
        );

      },

    );
  }
   void changeUserName (BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc)
    {
      return Container(
        padding: const EdgeInsets.all(10.0),
        height: 250,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Edit your Name'),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name must be not empty';
                }
                return null;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.person_outline),
            ),
            ),
            const SizedBox(
              height: 12,
            ),
            OutlinedButton(
              child: const Text('Update'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
    );
 }

}


