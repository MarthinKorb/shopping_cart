import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  final _formData = Map<String, Object>();
  final _formKey = GlobalKey<FormState>();

  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: [
                  ListTile(
                    leading: new Icon(
                      Icons.photo_library,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: new Text(
                      'Galeria',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: new Text(
                      'Câmera',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productArgs = ModalRoute.of(context).settings.arguments as Product;
    if (productArgs != null) {
      _formData.clear();
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
          Navigator.of(context).pop();
          return _showAlertDialog();
        }
      }
      Navigator.of(context).pop();
    }
  }

  AlertDialog _showAlertDialog() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
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
                decoration: InputDecoration(labelText: 'Título', filled: true),
                initialValue: _formData['title'],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (newValue) => _formData['title'] = newValue,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço', filled: true),
                initialValue: _formData['price']?.toString(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_categoryFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (newValue) =>
                    _formData['price'] = double.tryParse(newValue) ?? 0.0,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Categoria', filled: true),
                initialValue: _formData['category'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                focusNode: _categoryFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (newValue) => _formData['category'] = newValue,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Descrição', filled: true),
                initialValue: _formData['description'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                },
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (newValue) => _formData['description'] = newValue,
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Imagem',
                        filled: true,
                      ),
                      // onTap: () {
                      //   _showPicker(context);
                      // },
                      initialValue: _formData['image'] ??
                          'https://s2.glbimg.com/Oo5NXrkvypd6NlsHL1tuEfHXsms=/680x511/s.glbimg.com/po/tt/f/original/2012/07/27/meme-que-imortalizou-a-pose-do-fisico.jpg',
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      // readOnly: true,
                      // controller: _imageUrlController,
                      onSaved: (newValue) => _formData['image'] = newValue,
                      onFieldSubmitted: (_) {
                        _saveForm(context);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
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
