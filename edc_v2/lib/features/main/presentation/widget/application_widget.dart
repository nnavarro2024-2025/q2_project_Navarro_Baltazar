import 'package:cached_network_image/cached_network_image.dart';
import 'package:edc_v2/core/theme/app_colors.dart';
import 'package:edc_v2/core/utils/date_utils.dart';
import 'package:edc_v2/core/utils/url_utils.dart';
import 'package:edc_v2/features/main/domain/entity/application_entity.dart';
import 'package:edc_v2/features/main/presentation/page/single_application_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationWidget extends StatelessWidget {
  final ApplicationEntity applicationEntity;
  final Function(ApplicationEntity)? onTap;

  const ApplicationWidget(
      {super.key, required this.applicationEntity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: (){
          if(onTap!=null){
            onTap!.call(applicationEntity);
          }
          else{
            context.push(SingleApplicationPage.path(applicationEntity.id));
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Builder(builder: (context) {
                    final image = (applicationEntity.images.isNotEmpty)
                        ? applicationEntity.images.first
                        : '';
                    if (image.startsWith('http') || image.startsWith('https')) {
                      return CachedNetworkImage(
                        imageUrl: image,
                        height: 255,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      );
                    }
                    // treat as asset path when it starts with assets/
                    if (image.startsWith('assets/')) {
                      return Image.asset(
                        image,
                        height: 255,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      );
                    }
                    // fallback: assume filename stored on server
                    if (image.isNotEmpty) {
                      return CachedNetworkImage(
                        imageUrl: UrlUtils.buildImageUrl(image),
                        height: 255,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      );
                    }
                    // placeholder
                    return Container(
                      height: 255,
                      width: double.maxFinite,
                      color: AppColors.onSurface,
                      child: const Icon(Icons.image, size: 48),
                    );
                  }),
                ),
                if(applicationEntity.urgent)Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.surface,
                    ),
                    child: Text('Urgent',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.text
                    ),),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [

                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final textPainter = TextPainter(
                              text: TextSpan(
                                text: applicationEntity.title,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              maxLines: 1,
                              textDirection: TextDirection.ltr,
                            )..layout(maxWidth: constraints.maxWidth);
                            
                            return Text(
                              applicationEntity.title,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                              overflow: textPainter.didExceedMaxLines 
                                  ? TextOverflow.ellipsis 
                                  : TextOverflow.clip,
                              maxLines: 1,
                            );
                          },
                        ),
                      ),
                      Text(
                        '${applicationEntity.donorCount ?? 0}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.text.withOpacity(0.7),
                            ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        CupertinoIcons.person_2_fill,
                        size: 20,
                        color: AppColors.text.withOpacity(0.7)
                      ),
                      const Text(' Donated')
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Text(applicationEntity.description,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.text.withOpacity(0.7),
                  ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Text(
                        'Donations Collected: ₱ ${applicationEntity.collectedAmount ?? 0}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.text.withOpacity(0.7)
                        ),
                      ),
                      const Spacer(),
                      Text(
                        applicationEntity.deadline.timeLeft(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.text.withOpacity(0.7)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
