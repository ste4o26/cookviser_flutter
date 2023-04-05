import "package:demo_app/domain/cuisine/view_models/cuisine.view_model.dart";
import "package:demo_app/pages/recipes.page.dart";
import "package:flutter/material.dart";

class CuisineList extends StatelessWidget {
  final List<CuisineViewModel> cuisines;

  const CuisineList(this.cuisines, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        crossAxisCount: 5,
        padding: const EdgeInsets.all(10),
        children: List.generate(this.cuisines.length,
            (index) => CuisineCard(this.cuisines[index])));
  }
}

class CuisineCard extends StatelessWidget {
  final CuisineViewModel cuisine;

  const CuisineCard(this.cuisine, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        constraints:
            const BoxConstraints(minHeight: 300, maxHeight: 320, minWidth: 350),
        child: Card(
            elevation: 4,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            color: const Color.fromARGB(150, 19, 194, 254),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CuisineImage(this.cuisine),
                  CuisineName(this.cuisine.name),
                ],
              ),
            ])));
  }
}

class CuisineImage extends StatelessWidget {
  final CuisineViewModel cuisine;

  const CuisineImage(this.cuisine, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipesPage(cuisine.name),
              ),
            ),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image(
                  width: 300,
                  height: 250,
                  fit: BoxFit.fill,
                  image: NetworkImage(this.cuisine.imageUrl),
                ))));
  }
}

class CuisineName extends StatelessWidget {
  final String name;

  const CuisineName(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Text(name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}
