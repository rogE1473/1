import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.orange,
      child: Center(
        child: Text(
          'Магазин скинов в Conter-Strike2!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final Function(int) onQuantityChanged;

  ProductCard({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.onQuantityChanged,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      widget.onQuantityChanged(1);
    });
  }

  void _decrementQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
        widget.onQuantityChanged(-1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '₽${widget.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, color: Colors.orange),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            widget.description,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 9),
          widget.imageUrl.startsWith('http')
              ? Image.network(
                widget.imageUrl,
                height: 600,
                width: double.infinity,
                fit: BoxFit.cover,
              )
              : Image.asset(
                widget.imageUrl,
                height: 584,
                width: 587,
                fit: BoxFit.cover,
              ),
          SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.black),
                  onPressed: _decrementQuantity,
                ),
                Text(_quantity.toString(), style: TextStyle(fontSize: 20)),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.black),
                  onPressed: _incrementQuantity,
                ),
                SizedBox(width: 10),
                Text(
                  'В корзине',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _totalItemsInCart = 0;

  void _updateTotalItems(int change) {
    setState(() {
      _totalItemsInCart += change;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(177),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Image.asset(
            'assets/3.jpg',
            width: double.infinity,
            height: 177,
            fit: BoxFit.cover,
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            ProductCard(
              title: 'Dragon Lore',
              description: 'Arctic Warfare Magnum.',
              price: 1000000,
              imageUrl:
                  'https://avatars.mds.yandex.net/i?id=b4df92288870cbc7cc22c4b762988e06_l-5333965-images-thumbs&n=13',
              onQuantityChanged: _updateTotalItems,
            ),
            ProductCard(
              title: 'Desolate Space',
              description: 'M4A1',
              price: 2200,
              imageUrl: 'assets/1.jpg',
              onQuantityChanged: _updateTotalItems,
            ),
            ProductCard(
              title: 'Howl',
              description: 'M4A1.',
              price: 6000000,
              imageUrl: 'assets/2.png',
              onQuantityChanged: _updateTotalItems,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин скинов в Conter-Strike2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.light(
          primary: Colors.teal,
          secondary: Colors.blue,
        ),
      ),
      home: MyHomePage(),
    );
  }
}
