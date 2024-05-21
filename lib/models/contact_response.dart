class ContactResponse {
  final bool status;
  final String message;
  final Contact data;

  const ContactResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) => ContactResponse(
        status: json['status'] as bool,
        message: json['message'] as String,
        data: Contact.fromJson(json['data'])
      );
}

class Contact {
  final int id;
  final String? phone;
  final String? email;
  final String? facebook; // Can be null
  final String? website; // Can be null


  const Contact({
    required this.id,
    required this.email,
    required this.phone,
    required this.facebook,
   required  this.website,
 
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json['id'] as int,

        phone: json['phone'] as String,
        email: json['email'] as String,
        facebook: json['facebook'] as String ,
        website: json['website'] as String,
     
      );
}
