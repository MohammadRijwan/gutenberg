import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gutenberg/core/constant/colors.dart';
import 'package:gutenberg/feature/home/ui/home_vm.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor2,
      body: Consumer(builder: (context, ref, _) {
        final _vm = ref.watch(homeVmProvider);
        return SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/Pattern.svg',
                    height: size.height * 0.32,
                    width: size.width,
                    color: AppColors.primaryColor.withOpacity(0.2),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Text(
                          'Gutenberg \nProject',
                          style: TextStyle(
                            fontSize: 48.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'A social cataloging website that allows you to freely search its database of books, annotations, and reviews',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.veryDarkGrey,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _vm.menuList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    _vm.onCommonTapped();
                  },
                  child: CommonIconCard(
                    menuModel: _vm.menuList[index],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class CommonIconCard extends StatelessWidget {
  final MenuModel menuModel;
  const CommonIconCard({Key? key, required this.menuModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                menuModel.iconPath,
                height: 20.h,
                width: 20.w,
              ),
              SizedBox(width: 5.w),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  menuModel.title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.veryDarkGrey,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/Next.svg',
                height: 20.h,
                width: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
