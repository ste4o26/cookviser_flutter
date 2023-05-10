import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/pages/view_models/cuisine.dart';
import 'package:demo_app/shared/form/input_field.dart';
import 'package:demo_app/shared/form/submit_button.dart';
import 'package:demo_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateCuisine extends StatefulWidget {
  const CreateCuisine({super.key});

  @override
  State<CreateCuisine> createState() => _CreateCuisineState();
}

class _CreateCuisineState extends State<CreateCuisine> {
  final _cuisine = CuisineModel();
  XFile? _image;
  final _formKey = GlobalKey<FormState>();

  FormState? get state => _formKey.currentState;

  bool isInvalidForm(String? arg) {
    if (!state!.validate()) return false;
    state!.save();
    return true;
  }

  Future<void> _upLoadImage() async {
    final ImagePicker picker = ImagePicker();
    final source = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = source;
    });
  }

  void _create() {
    Provider.of<CuisineViewModel>(context, listen: false)
        .register(_cuisine, _image!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) => Dialog(
          child: Container(
              width: constraints.maxWidth * 0.3,
              height: constraints.maxHeight * 0.6,
              padding: const EdgeInsets.all(50),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      const Center(child: Text('Create cuisine')),
                      CustomInputField(
                        initialValue: _cuisine.name,
                        onSaved: (value) => _cuisine.name = value ?? '',
                        onChanged: isInvalidForm,
                        validationCallback: FieldValidator.validateCuisineName,
                        hintText: 'Cuisine name',
                        labelText: 'Enter cuisine name',
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FormButton(
                            content: 'Upload image',
                            callback: _upLoadImage,
                          ),
                          if (_image != null)
                            Expanded(child: Text(_image!.name)),
                        ],
                      ),
                      FormButton(
                        content: 'Create',
                        callback: _create,
                      ),
                    ],
                  )))));
}
