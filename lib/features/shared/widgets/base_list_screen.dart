import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/components/widgets/myp_list_view_widget.dart';
import '../../../../core/components/widgets/search_box_widget.dart';
import '../../../../core/components/widgets/loading_widget.dart';
import '../../../../core/themes/app_colors.dart';
import '../controllers/base_controller.dart';

abstract class BaseListScreen<T, C extends BaseGenericController<T>> extends GetView<C> 
{
  const BaseListScreen({super.key});

  String get title;
  String get searchPlaceholder;
  
  Widget buildListItem(BuildContext context, T item);
  
  List<T> getItems();

  Widget? emptyWidget(BuildContext context) => null;
  Widget? buildFloatingActionButton(BuildContext context) => null;
  Widget? buildHeader(BuildContext context) => null;

  /// Filters support (Optional)
  List<String> get filterNames => [];
  RxString? get selectedFilter => filterNames.firstOrNull?.obs;
  void onFilterSelected(bool selected, String value) {}

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      backgroundColor: AppColors.background.getByBrightness(brightness),
      floatingActionButton: buildFloatingActionButton(context),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchAll(force: true),
        child: SafeArea(
          child: Column(
            children: [
              /// Header (Special filters etc)
              buildHeader(context) ?? const SizedBox.shrink(),

          
              /// Search & Filters
              if (filterNames.isNotEmpty)
                SearchBox.withNLOtFilters(
                  context,
                  searchPlaceholder,
                  searchOnChanged: (value) => controller.searchQuery.value = value,
                  filtersNames: filterNames,
                  initSelect: selectedFilter ?? ''.obs,
                  onSelected: onFilterSelected,
                )
              else
                SearchBox.withLayout(
                  context,
                  searchPlaceholder,
                  searchOnChanged: (value) => controller.searchQuery.value = value,
                ),
              
              const SizedBox(height: 8),

              /// List
              MyPListView.expandedBuilder(
                context,
                isLoading: controller.isLoading,
                loadingWidget: () => const LoadingWidget(),
                emptyWidget: () => emptyWidget(context) ?? const Center(child: Text('لا توجد بيانات')),
                filters: getItems,
                itemBuilder: (context, index, item) => buildListItem(context, item),
                scrollController: controller.scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
