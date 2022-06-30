import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product/product.provider.dart';
import '../../providers/product/products.provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var urlPattern = r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  final _form = GlobalKey<FormState>();

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  late Product _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  bool _isInit = true;
  var initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
    if (_imageUrlController.text.isNotEmpty) {
      setState(() {});
    }
  }

  void _saveForm() {
    FormState form = _form.currentState!;
    final isValid = form.validate();
    if (!isValid) return;
    form.save();
    if (_editedProduct.id != null || _editedProduct.id != '') {
      Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
    // form.reset();
  }

  bool checkReg(String val, dynamic pattern) => RegExp(pattern, caseSensitive: false).firstMatch(val) == null ? false : true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false).findById(productId.toString());
        initValue = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                initialValue: initValue['title'],
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocusNode),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a value';
                  }
                  return null;
                },
                onSaved: (val) => Product(
                  id: _editedProduct.id,
                  title: val!,
                  description: _editedProduct.description,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                initialValue: initValue['price'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
                onSaved: (val) => Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  price: val == null ? _editedProduct.price : double.parse(val),
                  imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                initialValue: initValue['description'],
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long';
                  }
                  return null;
                },
                onSaved: (val) => Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: val!,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                  isFavorite: _editedProduct.isFavorite,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 100.0,
                    margin: const EdgeInsets.only(top: 8.0, right: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onEditingComplete: () => setState(() {}),
                      onFieldSubmitted: (_) => _saveForm(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an image URL';
                        }
                        if (checkReg(value, urlPattern)) {
                          // return 'Please enter a valid URL';
                        }
                        return null;
                      },
                      onSaved: (val) => Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: val!,
                        isFavorite: _editedProduct.isFavorite,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () => _saveForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
