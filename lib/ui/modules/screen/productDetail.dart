import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/ui/modules/model/plantmodel.dart';
import 'package:plant_app/ui/modules/mycart/bloc/eventfirebase_bloc.dart';
import 'package:plant_app/ui/modules/mycart/event_repository.dart';

import 'package:plant_app/ui/modules/widgets/counter.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.plantModel});
  final PlantModel plantModel;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final EventRepository _eventRepository = EventRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          SvgPicture.asset('assets/svg/heart1.svg'),
          const Icon(Icons.ios_share_rounded),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.plantModel.imageURL),
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
                height: 350,
              ),
              Text(
                widget.plantModel.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "\$${widget.plantModel.price.toString()}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const CounterWidget(),
                ],
              ),
              InkWell(
                onTap: () {
                  try {
                    context
                        .read<EventBloc>()
                        .add(AddEvent(plantModel: widget.plantModel));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to cart'),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to add to cart: $e'),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  height: 40,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart),
                        const Text("Add to Cart"),
                        const Spacer(),
                        Text("\$${widget.plantModel.price.toString()}"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
