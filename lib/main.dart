import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

import 'dart:html' as html;
import 'dart:ui_web' as ui; // Importación correcta para platformViewRegistry

void main() {
  runApp(Pago());
}

class Pago extends StatefulWidget {
  const Pago({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _PagoState createState() => _PagoState();
}

class _PagoState extends State<Pago> {
  @override
  void initState() {
    super.initState();
    // Registramos un view factory para el elemento HTML personalizado.
    ui.platformViewRegistry.registerViewFactory(
      'payphone-button',
      (int viewId) => html.IFrameElement()
        ..srcdoc = '''
          <!DOCTYPE html>
          <html>
          <head>
            <title>Payphone Button</title>
            <style>
              #pp-button {
                width: 310px;
                height: 310px;
              }
            </style>
          </head>
          <body>
            <div id="pp-button"></div>
            <script src="https://pay.payphonetodoesposible.com/api/button/js?appId=tt0U00eCb02W70mps0kmpQ"></script>
            <script>
              payphone.Button({
                token: 'dvHj45czv-wbVhP-llSmrqy55axr42-Bq3bH00iMpywa9Ww5IwhQd0ucK-ehQrI3dHwGcth-VJrq7fTNilQl3-fJuWKUchlEU8_VTbk8YLBZglvu3lx-KLWtMaUPkkfDs7EsCsxNXyotpN_AekYL3GPizP7NAocV2g5tpwJQmFPHrmo_xoPb98gn56tiVa1h2beJmzNgwZ1_A-rk--TcLJ0Jyp-ldFepBRo3rV_zynJwpd1pTIGTskCWQrxNwG95OQl-Zd_q7HqBPocPBxyurrRWl2QfJw7PqPhpqE-d6NJeRfmgM9xhK2sJ-cSNgQFAQWM5Bg',
                btnHorizontal: true,
                btnCard: true,
                createOrder: function(actions) {
                  return actions.prepare({
                    amount: 100,
                    amountWithoutTax: 100,
                    currency: 'USD',
                    clientTransactionId: 'PDPExpert',
                    lang: 'es'
                  }).then(function(paramlog) {
                    console.log(paramlog);
                    return paramlog;
                  }).catch(function(paramlog2) {
                    console.log(paramlog2);
                    return paramlog2;
                  });
                },
                onComplete: function(model, actions) {
                  // Handle completion
                }
              }).render('#pp-button');
            </script>
          </body>
          </html>
        '''
        ..style.border = 'none'
        ..style.height = '100%'
        ..style.width = '100%',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900], // Fondo azul oscuro
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Botón de pago PayPhone',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: widget.width ?? 350,
                height: widget.height ?? 360,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Fondo blanco del contenedor
                  borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: SizedBox(
                    width: 350,
                    height: 350,
                    child: HtmlElementView(viewType: 'payphone-button'),
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
