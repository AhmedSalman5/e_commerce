import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleCartItem extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String counter;
  final Function() minus;
  final Function() plus;
  final Function() addToWishList;
  final Function() delete;
  const SingleCartItem({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.counter,
    required this.minus,
    required this.plus,
    required this.addToWishList,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green, width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
              ),
              child: Image.network(image),
              // FadeInImage.memoryNetwork(
              //   placeholder: kTransparentImage,
              //   image: image,
              // ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 140,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: minus,
                              child: const CircleAvatar(
                                maxRadius: 13,
                                child: Icon(Icons.remove),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              counter,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: plus,
                              child: const CircleAvatar(
                                maxRadius: 13,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: addToWishList,
                          child: const Text(
                            'Add to wishlist',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // price of products
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '\$',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                        IconButton(
                          onPressed: delete,
                          icon: const Icon(Icons.delete,color: Colors.red,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

