import 'package:flutter/material.dart';
import 'package:nima/Widgets/custom_text_field.dart';



class CustomStoreForm extends StatelessWidget {
   TextEditingController storeNameController;
   TextEditingController descriptionController;
   TextEditingController geoPiontsController;
   TextEditingController emailController;
   TextEditingController phoneController;
   TextEditingController urlController;

  CustomStoreForm({
    this.storeNameController,
    this.descriptionController,
    this.geoPiontsController,
    this.emailController,
    this.phoneController,
    this.urlController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Informations sur le magasin ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        //------------------------------------------ store name --------------------------------------
        CustomTextFormField2(
          readonly: false,
          validator: (String value) {
            if (value.length == 0) {
              return "Obligatoire * ";
            }
          },
          controller: storeNameController,
          textInputType: TextInputType.visiblePassword,
          hintText: 'nom du magasin',
          icon: Icon(
            Icons.store_sharp,
            color: Colors.black45,
          ),
          isOscureText: false,
        ),
        //------------------------------------------ end store name --------------------------------------
        SizedBox(
          height: 10,
        ),
        CustomTextFormField2(
          readonly: false,
          controller: descriptionController,
          minLines: 4,
          textInputType: TextInputType.multiline,
          hintText: 'description',
          icon: Icon(
            Icons.description,
            color: Colors.black45,
          ),
          isOscureText: false,
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextFormField2(
          readonly: true,
          validator: (String value) {
            if (value.length == 0) {
              return "Obligatoire * ";
            }
          },
          controller: geoPiontsController,
          textInputType: TextInputType.text,
          hintText: 'localisation',
          icon: Icon(
            Icons.location_pin,
            color: Colors.black45,
          ),
          isOscureText: false,
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Contact",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        CustomTextFormField2(
          readonly: false,
          validator: (String value) {
            if (value.length == 0) {
              return "Obligatoire * ";
            }
          },
          controller: emailController,
          textInputType: TextInputType.emailAddress,
          hintText: 'email',
          icon: Icon(
            Icons.mail,
            color: Colors.black45,
          ),
          isOscureText: false,
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextFormField2(
          readonly: false,
          validator: (String value) {
            if (value.length == 0) {
              return "Obligatoire * ";
            }
          },
          controller: phoneController,
          textInputType: TextInputType.phone,
          hintText: 'téléphone',
          icon: Icon(
            Icons.phone,
            color: Colors.black45,
          ),
          isOscureText: false,
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextFormField2(
          readonly: false,
          controller: urlController,
          textInputType: TextInputType.url,
          hintText: 'site web',
          icon: Icon(
            Icons.line_style,
            color: Colors.black45,
          ),
          isOscureText: false,
        ),
      ],
    );
  }
}
