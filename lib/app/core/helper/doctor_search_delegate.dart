import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../data/model/doctor_model.dart';
import '../custom_dio/src/custom_dio.dart';
import '../widget/custom_alert.dart';

class DoctorSearchDelegate extends SearchDelegate {
  final Function(DoctorModel) onCardClick;
  final Function(DoctorModel) onBlockClick;
  final Function(DoctorModel) onDeleteClick;

  List<DoctorModel> results = [];

  DoctorSearchDelegate({
    required this.onDeleteClick,
    required this.onCardClick,
    required this.onBlockClick,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: search(),
        builder: (_, snapshot) => results.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return _buildDoctorCard(results[index]);
                },
                itemCount: results.length,
              )
            : const Text('Loading...'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildDoctorCard(results[index]);
      },
      itemCount: results.length,
    );
  }

  Future<void> search() async {
    if (query.length > 2) {
      try {
        final result = await CustomDio().post(
          'super-admin/search-health',
          body: {'data': query},
        );
        results = (result.data['data'] as List)
            .map((e) => DoctorModel.fromMap(e))
            .toList();
      } catch (e) {
        CustomAlert.showError(e.toString());
      }
    }
  }

  Widget _buildDoctorCard(DoctorModel doctor) {
    return InkWell(
      onTap: () => onCardClick(doctor),
      child: Card(
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (doctor.user?.fullName ?? '').text.bold.size(18),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(doctor.user?.profilePicture ?? ''),
                  )
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              (Get.locale?.languageCode == 'ar'
                      ? doctor.category!.nameAr
                      : doctor.category!.nameEn)
                  .text,
              SizedBox(height: 5),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () => onDeleteClick(doctor),
                      child: 'Delete Doctor'.text,
                      textColor: Colors.white,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () => onBlockClick(doctor),
                      child: 'Block'.text,
                      textColor: Colors.white,
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
