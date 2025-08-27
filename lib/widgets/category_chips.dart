import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';

class CategoryChips extends StatelessWidget {
  final NewsController controller = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 70,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            final isSelected =
                controller.selectedCategory.value == category.name;

            return GestureDetector(
              onTap: () => controller.fetchNewsByCategory(category.name),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                  ],
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category.icon,
                      size: 20,
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : Colors.grey[700],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category.displayName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? theme.colorScheme.onPrimary
                            : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
