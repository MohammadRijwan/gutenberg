import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gutenberg/core/constant/colors.dart';
import 'package:gutenberg/feature/book/domain/model/book_res_model.dart';
import 'package:pagination_view/pagination_view.dart';

import 'book_vm.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  TextEditingController searchController = TextEditingController();
  late int page;
  late PaginationViewType paginationViewType;
  late GlobalKey<PaginationViewState> key;

  @override
  void initState() {
    page = -1;
    paginationViewType = PaginationViewType.listView;
    key = GlobalKey<PaginationViewState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor2,
      body: SafeArea(
        child: Consumer(builder: (context, ref, _) {
          final _vm = ref.watch(bookVmProvider);
          return Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset('assets/Back.svg'),
                  ),
                  Text(
                    'Fiction',
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      SvgPicture.asset(
                        'assets/Search.svg',
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextFormField(
                            controller: searchController,
                            onChanged: (value) {
                              _vm.onSearch(value);
                            },
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: AppColors.veryDarkGrey,
                              fontWeight: FontWeight.w900,
                            ),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontWeight: FontWeight.w900,
                                ))),
                      ),
                      SizedBox(width: 10.w),
                      if (_vm.searchKey != null) ...[
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _vm.onSearchTap();
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                'assets/Search.svg',
                                height: 35.h,
                                width: 35.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () {
                            searchController.clear();
                            _vm.onClearTap();
                          },
                          child: SvgPicture.asset(
                            'assets/Cancel.svg',
                          ),
                        ),
                      ]
                    ]),
                  ),
                ),
              ),
              Expanded(
                child: _vm.isSearchEnable
                    ? SearchBookDetails(vm: _vm)
                    : BookDetails(vm: _vm),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class BookDetails extends StatelessWidget {
  final vm;
  const BookDetails({Key? key, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: PaginationView<Result>(
        // key: UniqueKey(),
        preloadedItems: [],
        itemBuilder: (BuildContext context, Result book, int index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network('${book.formats.imageJpeg}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                          width: size.width,
                          color: AppColors.darkGrey.withOpacity(0.2),
                          child: const Center(child: Text('No Image')),
                        )),
              ),
            ),
            SizedBox(height: 5.h),
            Flexible(
              child: Text(
                book.title ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.veryDarkGrey,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Flexible(
              child: Text(
                book.authors.isNotEmpty ? book.authors.first.name : '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        paginationViewType: PaginationViewType.gridView,
        pageFetch: vm.fetch,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3),
        onError: (dynamic error) => const Center(
          child: Text('Some error occured'),
        ),
        onEmpty: const Center(
          child: Text('Sorry! This is empty'),
        ),
        bottomLoader: const Center(
          // optional
          child: CircularProgressIndicator(),
        ),
        initialLoader: const Center(
          // optional
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class SearchBookDetails extends StatelessWidget {
  final vm;
  const SearchBookDetails({Key? key, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: PaginationView<Result>(
        preloadedItems: [],
        itemBuilder: (BuildContext context, Result book, int index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network('${book.formats.imageJpeg}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                          width: size.width,
                          color: AppColors.darkGrey.withOpacity(0.2),
                          child: const Center(child: Text('No Image')),
                        )),
              ),
            ),
            SizedBox(height: 5.h),
            Flexible(
              child: Text(
                book.title ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.veryDarkGrey,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Flexible(
              child: Text(
                book.authors.isNotEmpty ? book.authors.first.name : '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        paginationViewType: PaginationViewType.gridView,
        pageFetch: vm.onSearchBook,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3),
        onError: (dynamic error) => const Center(
          child: Text('Some error occured'),
        ),
        onEmpty: const Center(
          child: Text('Sorry! This is empty'),
        ),
        bottomLoader: const Center(
          // optional
          child: CircularProgressIndicator(),
        ),
        initialLoader: const Center(
          // optional
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
