import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_event.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_state.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_model.dart';

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
              ElevatedButton(
                onPressed: () {
                  if (_batchViewFormKey.currentState!.validate()) {
                    context.read<BatchViewModel>().add(
                      CreateBatchEvent(batchName: batchNameController.text),
                    );
                  }
                },
                child: Text('Add Batch'),
              ),
              SizedBox(height: 10),
              BlocBuilder<BatchViewModel, BatchState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.batches.isEmpty) {
                    return Center(
                      child: Text(
                        'No batches available',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                  if (state.errorMessage != null) {
                    return Text('Error: ${state.errorMessage}');
                  }
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final batch = state.batches[index];
                        return ListTile(
                          title: Text(batch.batchName),
                          subtitle: Text('${batch.batchId}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              context.read<BatchViewModel>().add(
                                DeleteBatchEvent(batchId: batch.batchId ?? ''),
                              );
                            },
                          ),
                        );
                      },
                      itemCount: state.batches.length,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
