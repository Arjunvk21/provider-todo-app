// ignore: file_names
import 'package:dynamic_todo_form_application/provider/productProviderClass.dart';
import 'package:dynamic_todo_form_application/view/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, TextEditingController>> _controllers = [];
  @override
  void initState() {
    _addNewRow();
    super.initState();
  }

  void _addNewRow() {
    setState(() {
      _controllers.add({
        'productName': TextEditingController(),
        'productRate': TextEditingController(),
      });
    });
  }

  double calculateSubtotal() {
    double subtotal = 0.0;
    for (var controllers in _controllers) {
      double price = double.tryParse(controllers['productRate']!.text) ?? 0.00;
      subtotal = subtotal + price;
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey.withOpacity(0.2),
        elevation: 2,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text(
            'Home',
            style: GoogleFonts.aBeeZee(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Stack(
          children: [
            Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Form(
                  key: GlobalKey<FormState>(),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: productProvider.controllers.length,
                          itemBuilder: (context, index) {
                            final productNameController = productProvider
                                .controllers[index]['productname']!;
                            final productPriceController = productProvider
                                .controllers[index]['productprice']!;
                            return Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextFormField(
                                    isProductName: true,
                                    labelText: 'Product Name',
                                    controller: productNameController,
                                  ),
                                  CustomTextFormField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    onChanged: (value) {
                                      productProvider.notifyListeners();
                                    },
                                    isProductName: false,
                                    labelText: 'Price',
                                    controller: productPriceController,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        productProvider.removeRow(index);
                                      },
                                      icon: const Icon(Icons.close))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.10),
                            )),
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 0.20,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Subtotal',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromARGB(255, 73, 73, 73)),
                                    ),
                                    Text(
                                      '\$${productProvider.calculateSubtotal().toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromARGB(255, 73, 73, 73)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.07,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[400],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Text(
                                      'Place order',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
            Positioned(
                bottom: 180.0,
                right: 15.0,
                child: FloatingActionButton(
                  elevation: 8.0,
                  backgroundColor: Colors.blue[400],
                  onPressed: () {
                    context.read<ProductProvider>().addNewRow();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
