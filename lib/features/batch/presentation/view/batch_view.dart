import 'package:flutter/material.dart';

class BatchView extends StatelessWidget {
  BatchView({super.key});
  final batchNameController = TextEditingController();

  final _batchViewFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _batchViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: batchNameController,
                decoration: const InputDecoration(labelText: 'Batch Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter batch name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {}, child: Text('Add Batch')),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
