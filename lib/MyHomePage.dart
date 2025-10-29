import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Update 1
//https://github.com/SifulIslamForhad/BMI_Calculator_Module_17/blob/main/lib/MyHomePage.dart

    enum Weight_Type { kg, pound }
    enum Height_Type { meter, cm, feet_Inch }


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //---------------------------------------------------

    Weight_Type weight_type = Weight_Type.kg;
    Height_Type height_type = Height_Type.feet_Inch;

    String bmi_result = '';
    String category = '';

   final kg_controller = TextEditingController();
   final pound_controller = TextEditingController();
   final meter_controller = TextEditingController();
   final cm_controller = TextEditingController();
   final feet_controller = TextEditingController();
   final inch_controller = TextEditingController();


    String img = 'https://static.pbcdn.in/cdn/images/bu/health/health-calculators/why-is-bmi-important-image.png';
    String under_weight_img = 'https://www.researchgate.net/publication/263712059/figure/fig2/AS:1088639715024908@1636563342467/The-proband-presented-with-tall-stature-90th-percentile-low-weight-10-25th.jpg';
    String smart_weight_img = 'https://t4.ftcdn.net/jpg/07/60/54/73/360_F_760547313_vFfy53jgtysr5gV8qQaYvvAj1P805s9b.jpg';
    String over_weight_img = 'https://cdn.mos.cms.futurecdn.net/H8rvX2P3WBsGeT7jAxBPBT-600-80.jpg';
    String Obesity_weight_img = 'https://www.fomatmedical.com/wp-content/uploads/2023/08/overweight-persons-body-with-hands-touching-abdomen-concept-obesity-1100x619.jpg';
    String elephant1_weight_img = 'https://t3.ftcdn.net/jpg/09/81/61/98/360_F_981619855_FRsECCI5jOCjwj9xe5LTSMMIvuJaom2q.jpg';
    String elephant2_weight_img = 'https://cdn.jagonews24.com/media/imgAllNew/BG/2015December/andress20151226083319.jpg';
    String invalide_img = 'https://www.itsolutionacademy.com/Other%20All%20Info/img/invalide.png.PNG';

     String category_Select( double bmi ){

      if(bmi <= 18.5){
        setState(() {
          img = under_weight_img;
        });
        return 'Under weight';
      }
      if(bmi < 25){
        setState(() {
          img = smart_weight_img;
        });
        return 'Smart weight';
      }
      if(bmi < 30 ){
        setState(() {
          img = over_weight_img;
        });
        return 'Over weight';
      }
      if(bmi < 35 ){
        setState(() {
          img = Obesity_weight_img;
        });
        return 'Obesity';
      }
      if(bmi <= 40 ){
        setState(() {
          img = elephant1_weight_img;
        });
        return 'ছোট হাতি';
      }
      if(bmi > 40 ){
        setState(() {
          img = elephant2_weight_img;
        });
        return 'বড় হাতি';
      }

      return 'Obese';
   }




   double ? poundTokg(){
     final pound = double.tryParse(pound_controller.text.trim());
     if(pound==null || pound <= 0 ){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Value invalide')));
       setState(() {
         img = invalide_img;
         bmi_result = '';
         category = '';
       });
       return null;
     }
     return pound * 0.45359237;
   }



    double ? cmTo_meter(){
      final cm = double.tryParse(cm_controller.text.trim());

      if(cm == null || cm <= 0 ){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Value invalide')));
        setState(() {
          img = invalide_img;
          bmi_result = '';
          category = '';
        });
        return null;
      }

      return cm / 100.0;
    }



    double ? feet_inch_To_meter(){
      final feet = double.tryParse(feet_controller.text.trim());
      final inch = double.tryParse(inch_controller.text.trim());

      if(feet == null || feet <= 0 || inch == null || inch < 0 ){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Value invalide')));
        setState(() {
          img = invalide_img;
          bmi_result = 'Value empty';
          category = '';
        });
        return null;
      }

      final totel_inch = (feet * 12) + inch;
      if(totel_inch==null || totel_inch <= 0 ){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Value invalide')));
        setState(() {
          img = invalide_img;
          bmi_result = 'Value empty';
          category = '';
        });
        return null;
      }

      return totel_inch * 0.0254 ;
    }




    void calculate(){

      final meter = double.tryParse(meter_controller.text.trim());  //--new
      final weight = double.tryParse(kg_controller.text.trim());

     if(weight==null || weight <= 0 ){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Value invalide')));
       setState(() {
         img = invalide_img;
         bmi_result = 'Value empty';
         category = '';
       });
       return null;
     }


     if(height_type == Height_Type.meter) {
       if(meter == null || meter <= 0){
         ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Value invalid')));
         setState(() {
           img = invalide_img;
           bmi_result = 'Value empty';
           category = '';
         });
         return;
       }
     }


     final weight_final = weight_type == Weight_Type.kg ? weight : poundTokg();

      final height_final = height_type == Height_Type.meter ? meter
         : ( height_type == Height_Type.cm ? cmTo_meter() : feet_inch_To_meter() ) ;  //--new || height_final <= 0

     if(weight_final == null || weight_final <= 0 || height_final == null ){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Value invalide')));
       setState(() {
         img = invalide_img;
         bmi_result = 'Value empty';
         category = '';
       });
       return null;
     }

     final bmi = weight_final / ( height_final * height_final ) ;
     final cat = category_Select(bmi);

     setState(() {
       bmi_result = bmi.toStringAsFixed(3);
       category = cat;
     });

    }



   
   @override
  void dispose() {
    // TODO: implement dispose
     kg_controller.dispose();
     pound_controller.dispose();
     meter_controller.dispose();
     cm_controller.dispose();
     feet_controller.dispose();
     inch_controller.dispose();
    super.dispose();
  }

  //---------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //===============================


      appBar: AppBar(
        backgroundColor: Colors.pink, foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('BMI Calculator', ),
      ),



      body: ListView(
        padding: EdgeInsets.all(10),
        children: [


          Text('Weight Unit', style: Theme.of(context).textTheme.titleLarge),

          SizedBox(height: 10),
          SegmentedButton(segments: [
            ButtonSegment<Weight_Type>(value: Weight_Type.kg, label: Text('KG', style: TextStyle(fontSize: 22))),
            ButtonSegment<Weight_Type>(value: Weight_Type.pound, label: Text('Pound', style: TextStyle(fontSize: 22))),
          ],
              selected: {weight_type},
              onSelectionChanged: (value)=> setState(() => weight_type = value.first ),
            style: SegmentedButton.styleFrom(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              side: BorderSide(color: Colors.purple, width: 2),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 15,
              selectedForegroundColor: Colors.white,
              selectedBackgroundColor: Colors.purple,
            ),
          ),


          SizedBox(height: 20),
          if(weight_type == Weight_Type.kg)...[
            TextFormField(
              controller: kg_controller,
              maxLength: 3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            )
          ]
          else...[
            TextFormField(
              controller: pound_controller,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (Pound)',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],




          //-----------------------------2
          SizedBox(height: 0),
          Text('Height Unit', style: Theme.of(context).textTheme.titleLarge),   //CM

          SizedBox(height: 10),
          SegmentedButton(segments: [
            ButtonSegment<Height_Type>(value: Height_Type.feet_Inch, label: Text('Feet/Inch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ButtonSegment<Height_Type>(value: Height_Type.cm, label: Text('CM', style: TextStyle(fontSize: 22))),
            ButtonSegment<Height_Type>(value: Height_Type.meter, label: Text('Meter', style: TextStyle(fontSize: 22))),
          ],
            selected: {height_type},
            onSelectionChanged: (value)=> setState(() => height_type = value.first ),
            style: SegmentedButton.styleFrom(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              elevation: 15,
              side: BorderSide(color: Colors.purple, width: 2),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              selectedForegroundColor: Colors.white,
              selectedBackgroundColor: Colors.purple,
            ),
          ),


          SizedBox(height: 10),
          if(height_type == Height_Type.meter)...[
                TextFormField(
                  controller: meter_controller,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Height (Meter)',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
          ]
            else if(height_type == Height_Type.cm)...[
            TextFormField(
              controller: cm_controller,
              maxLength: 3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (CM)',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ]
          else...[
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: feet_controller,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Feet',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),

                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: inch_controller,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Inch',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )
              ],
            )
          ],
          //-----------------------------2




          SizedBox(height: 20),
          ElevatedButton(
              onPressed: (){ calculate(); },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: Container( height: 50, child: Center(child: Text('Check BMI Index', style: TextStyle(fontSize: 22))))
          ),


          SizedBox(height: 10),
          Container(
            height: 40, width: double.infinity, color: Colors.pink,
              alignment: Alignment.center,
              child: Text(
                  bmi_result,
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)
              )
          ),



          SizedBox(height: 0),
          Container(
            height: 260, width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
              border: Border.all(color: Colors.pink, width: 5)
            ),
            child: Column(
              children: [

                Expanded(
                  child: Container(
                     child: Image.network(img, fit: BoxFit.fill),
                  ),
                ),

                Container(
                    height: 40, width: double.infinity, color: Colors.pink,
                    alignment: Alignment.center,
                    child: Text(
                        category, maxLines: 1,
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)
                    )
                ),

              ],
            ),
          )


        ],
      ),




      //================================
    );
  }
}
