import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_/models/product.dart';
import 'package:shop_/providers/products_provider.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final productArgs = ModalRoute.of(context).settings.arguments as Product;
      _formData['id'] = productArgs.id;
      _formData['title'] = productArgs.title;
      _formData['price'] = productArgs.price;
      _formData['category'] = productArgs.category;
      _formData['description'] = productArgs.description;
      _formData['image'] = productArgs.image;
    }
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

  Future<void> _saveForm(BuildContext ctx) async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      if (_formData['id'] == null) {
        productsProvider.addProduct(Product.fromMap(_formData));
      } else {
        final success =
            await productsProvider.updateProduct(Product.fromMap(_formData));
        if (!success) {
          return AlertDialog(
            content: Text('Erro ao realizar a atualização do produto'),
            actions: [
              RaisedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      }
      Navigator.of(context).pop();
    }
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
              _saveForm(context);
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
                initialValue: _formData['title'],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (newValue) => _formData['title'] = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                initialValue: _formData['price'].toString(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (newValue) =>
                    _formData['price'] = double.tryParse(newValue) ?? 0.0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Categoria'),
                initialValue: _formData['category'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                focusNode: _categoryFocusNode,
                onFieldSubmitted: (_) {
                  // FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (newValue) => _formData['category'] = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                initialValue: _formData['description'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (newValue) => _formData['description'] = newValue,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da imagem'),
                      initialValue: _formData['image'],
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      // controller: _imageUrlController,
                      onSaved: (newValue) => _formData['image'] = newValue,
                      onFieldSubmitted: (_) {
                        _saveForm(context);
                      },
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
                        // child: Padding(
                        //   padding: const EdgeInsets.all(4.0),
                        //   child: _imageUrlController.text.isEmpty
                        //       ? Text('Informe a URL')
                        //       : FittedBox(
                        //           child: Image.network(_imageUrlController.text),
                        //           fit: BoxFit.cover,
                        //         ),
                        // ),
                        ),
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
