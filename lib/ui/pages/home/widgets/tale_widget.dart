import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/entities/tale/tale_entity.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';

class TaleWidget extends StatelessWidget {
  final TaleEntity? tale;
  final VoidCallback? onPressed;

  const TaleWidget({
    super.key,
    this.tale,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            _buildThumbWidget(),
            const SizedBox(width: AppDimens.paddingNormal),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    tale?.name ?? '',
                    style: AppTextStyle.blackS16Bold,
                  ),
                  const SizedBox(height: AppDimens.paddingNormal),
                  Expanded(
                    child: Text(
                      tale?.anotherName ?? '',
                      style: AppTextStyle.grayS14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbWidget() {
    return SizedBox(
      width: 80,
      height: 120,
      child: AppCacheImage(
        url: tale?.thumbnailUrl ?? '',
        fit: BoxFit.cover,
      ),
    );
  }
}
