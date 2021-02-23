import 'package:flutter/material.dart';
import 'package:shop_/services/database_service.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _categoryFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  void _updateImageUrl() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
  }

  // Future<http.Response> _saveForm() async {
  //   // _formKey.currentState.save();
  //   var response = await http.post(ProductsProvider.apiURL, body: _formData);
  //   print(response.body);
  //   return response;
  // }
  Future<int> _saveForm() async {
    // _formKey.currentState.save();
    var response = await DatabaseService.insert('product', _formData);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (newValue) =>
                    _formData['title'] = double.parse(newValue),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (newValue) => _formData['price'] = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Categoria'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                focusNode: _categoryFocusNode,
                onFieldSubmitted: (_) {
                  // FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (newValue) => _formData['category'] = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (value) {
                  // FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (newValue) => _formData['description'] = newValue,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (newValue) => _formData['image'] = newValue,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                        child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Informe a URL')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                            ),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
