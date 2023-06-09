import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/Models/envio.dart';
import 'package:gestor_de_inventario/Models/serviceMovimientos.dart';

class EnvioWidget extends StatefulWidget {
  late Envio envio;
  EnvioWidget(this.envio);

  @override
  State<EnvioWidget> createState() => _Envio_WidgetState(envio);
}

class _Envio_WidgetState extends State<EnvioWidget> {
  late Envio envio;

  _Envio_WidgetState(this.envio);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                              "${envio.fecha.day}-${envio.fecha.month}-${envio.fecha.year}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                        ),
                        Container(
                          child: Text(this.envio.estado,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(this.envio.destino,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            print(envio.id);
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      scrollable: true,
                      title: Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 164, 22, 34))),
                            onPressed: envio.estado == "Entregado"
                                ? null
                                : () async {
                                    ServiceMovimientos serviceMovimientos =
                                        ServiceMovimientos.getInstance();
                                    bool avanzar = await serviceMovimientos
                                        .avanzarEstado(this.envio);
                                    if (avanzar == true) {
                                      envio.avanzarEstado();
                                      Navigator.pop(context);
                                      this.setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Se avanzo el estado del envio"),
                                      ));
                                    } else {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: Text("Error"),
                                                content: Text(
                                                    "No se pudo avanzar el estado del envio"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Ok"))
                                                ],
                                              ));
                                    }
                                  },
                            child: Text(
                              "Avanzar estado",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      content: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: AnotherStepper(
                              activeBarColor: Color.fromARGB(255, 164, 22, 34),
                              barThickness: 6,
                              activeIndex: this.envio.estado == "Creado"
                                  ? 0
                                  : this.envio.estado == "Preparando"
                                      ? 1
                                      : this.envio.estado == "En camino"
                                          ? 2
                                          : this.envio.estado == "Entregado"
                                              ? 3
                                              : 0,
                              stepperList: [
                                StepperData(
                                    title: StepperText(
                                      "Creado",
                                      textStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    subtitle:
                                        StepperText("El envio se ha creado"),
                                    iconWidget: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: this.envio.estado == "Creado"
                                              ? Color.fromARGB(255, 164, 22, 34)
                                              : this.envio.estado ==
                                                          "Preparando" ||
                                                      this.envio.estado ==
                                                          "En camino" ||
                                                      this.envio.estado ==
                                                          "Entregado"
                                                  ? Color.fromARGB(
                                                      255, 164, 22, 34)
                                                  : Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: const Icon(Icons.list_alt,
                                          color: Colors.white),
                                    )),
                                StepperData(
                                    title: StepperText("Preparando"),
                                    subtitle: StepperText(
                                        "El envio se esta preparando para ser enviado"),
                                    iconWidget: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: this.envio.estado ==
                                                  "Preparando"
                                              ? Color.fromARGB(255, 164, 22, 34)
                                              : this.envio.estado ==
                                                          "En camino" ||
                                                      this.envio.estado ==
                                                          "Entregado"
                                                  ? Color.fromARGB(
                                                      255, 164, 22, 34)
                                                  : Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: const Icon(Icons.pallet,
                                          color: Colors.white),
                                    )),
                                StepperData(
                                    title: StepperText("En camino"),
                                    subtitle: StepperText(
                                        "El envio está en camino de la ubicación de destino"),
                                    iconWidget: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: this.envio.estado ==
                                                  "En camino"
                                              ? Color.fromARGB(255, 164, 22, 34)
                                              : this.envio.estado == "Entregado"
                                                  ? Color.fromARGB(
                                                      255, 164, 22, 34)
                                                  : Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: const Icon(Icons.local_shipping,
                                          color: Colors.white),
                                    )),
                                StepperData(
                                    title: StepperText("Entregado",
                                        textStyle: const TextStyle(
                                          color: Colors.grey,
                                        )),
                                    subtitle: StepperText(
                                        "El envio está en camino de la ubicación de destino"),
                                    iconWidget: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: this.envio.estado ==
                                                  "Entregado"
                                              ? Color.fromARGB(255, 164, 22, 34)
                                              : Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: const Icon(Icons.task_alt,
                                          color: Colors.white),
                                    )),
                              ],
                              stepperDirection:
                                  MediaQuery.of(context).size.width > 600
                                      ? Axis.horizontal
                                      : Axis.vertical,
                              iconWidth:
                                  40, // Height that will be applied to all the stepper icons
                              iconHeight:
                                  40, // Width that will be applied to all the stepper icons
                            ),
                          )
                        ],
                      ),
                    ));
          },
        ),
      ),
    );
  }
}
