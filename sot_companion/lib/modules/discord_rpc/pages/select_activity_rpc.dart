import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sot_companion/modules/discord_rpc/enums/sot_rpc.dart';

class SelectActivityRPC_Page extends StatefulWidget {
  SelectActivityRPC_Page({Key? key}) : super(key: key);

  @override
  State<SelectActivityRPC_Page> createState() => _SelectActivityRPC_PageState();
}

class _SelectActivityRPC_PageState extends State<SelectActivityRPC_Page> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
            color: Colors.blue.withOpacity(0.8),
            child: ListView(
                children: List.generate(
                    SOTRPC_ActivityCategory.values.length,
                    (index) => _buildCategoryWidget(
                        SOTRPC_ActivityCategory.values[index])))));
  }

  Widget _buildCategoryWidget(SOTRPC_ActivityCategory category) {
    return ListTile(
      title: Text(category.name, style: TextStyle(color: Colors.white)),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(category.image),
        backgroundColor: Colors.transparent,
      ),
      onTap: () async {
        SOTRPC_Activity? activityChoosen = await showModalBottomSheet<void>(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) => SelectActivityInCategoryRPC_Page(category: category,),
                  ) as SOTRPC_Activity;
        if (SOTRPC_Activity != null) {
          Navigator.of(context).pop(activityChoosen);
        }else{
          Navigator.of(context).pop(null);
        }
      },
    );
  }
}

class SelectActivityInCategoryRPC_Page extends StatefulWidget {
  SelectActivityInCategoryRPC_Page({Key? key, required this.category})
      : super(key: key);

  SOTRPC_ActivityCategory category;
  @override
  State<SelectActivityInCategoryRPC_Page> createState() =>
      _SelectActivityInCategoryRPC_PageState();
}

class _SelectActivityInCategoryRPC_PageState
    extends State<SelectActivityInCategoryRPC_Page> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
            color: Colors.blue.withOpacity(0.8),
            child: ListView(
                children: List.generate(
                     widget.category.activities.length,
                    (index) => _buildActivityWidget(
                        widget.category.activities[index])))));
  }

  Widget _buildActivityWidget(SOTRPC_Activity activity) {
    return ListTile(
      title: Text(activity.name, style: TextStyle(color: Colors.white)),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(activity.image),
        backgroundColor: Colors.transparent,
      ),
      onTap: () {
        Navigator.of(context).pop(activity);
      },
    );
  }
}
