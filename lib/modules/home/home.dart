import 'package:breakingbad/models/charclass.dart';
import 'package:breakingbad/modules/chardetails.dart';
import 'package:breakingbad/modules/home/cubit/cubit.dart';
import 'package:breakingbad/modules/home/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isSearching = false ;
    TextEditingController controller = TextEditingController() ;
    AppBar beforeSearchAppBar= AppBar(
      backgroundColor: Colors.yellow,
      title: const Text('Characters',style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold , fontSize: 30),),
      actions: [
        IconButton(onPressed: (){
          isSearching = true ;
          AppCubit.get(context).changeState() ;
        }, icon: const Icon(Icons.search),iconSize: 30,)
      ],
    ) ;
    AppBar afterSearchAppBar= AppBar(

      backgroundColor: Colors.yellow,
      title: TextFormField(
        controller: controller,
        onChanged: (search){
          if (search.isNotEmpty) {
            AppCubit.get(context).searchChar(search) ;
          }
        },
        decoration: const InputDecoration(
          hintText: 'Search here' ,
          border: InputBorder.none ,

        ),
      ) ,
      actions: [
        IconButton(onPressed: (){
          isSearching = false ;
          AppCubit.get(context).searchCharacters=[] ;
          AppCubit.get(context).changeState() ;
        }, icon: const Icon(Icons.close),iconSize: 30,)
      ],
    ) ;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[800],
          appBar: isSearching==true?afterSearchAppBar:beforeSearchAppBar,
          body: SafeArea(
            child: ConditionalBuilder(
              condition: cubit.characters.isNotEmpty,
              builder: (BuildContext context)=>Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2 ,
                        children: List.generate(cubit.searchCharacters.isNotEmpty?cubit.searchCharacters.length:cubit.characters.length, (index) => buildCharItem(cubit.searchCharacters.isNotEmpty?cubit.searchCharacters[index]:cubit.characters[index],context)),
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2/3,
                        shrinkWrap: true,
                      ),
                    )
                  ],
                ),
              ),
             fallback: (context)=>const Center(child: CircularProgressIndicator(
               color: Colors.red,
             )),
            ),
              ),
        );
      },
    );
  }
  Widget buildCharItem(Character character,context)=>InkWell(
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DetailsScreen(character: character,))) ;
    },
    child: Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(25) ,
        border: Border.all(color: Colors.white,
        width: 5),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(image: NetworkImage(character.img) , width: double.infinity,height: 300,fit: BoxFit.fill)  ,
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    color: Colors.grey[300],
                  ),
                    child: Center(child: Text(character.name , style: const TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,))),
              ],
            ),
          )
        ],
      ),
    ),
  ) ;
}
