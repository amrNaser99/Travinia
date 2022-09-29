import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/shared_widgets/custom_text_field.dart';

class buildSearchBar extends StatelessWidget {
  const buildSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomTextField(
                hintText: 'London',
                validatorText: 'Please fill the Field',
                controller:
                    BlocProvider.of<ExploreCubit>(context).searchController,
                inputType: TextInputType.text,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.filter_list,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
