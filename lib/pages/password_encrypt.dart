// import 'package:flutter/material.dart';
// import 'package:project_flutter/pages/login_page.dart';
// import 'package:project_flutter/pages/mysql.dart';
// import 'package:project_flutter/pages/data_table.dart';

// void main() => runApp(passwordPage());

// class passwordPage extends StatefulWidget {
//   const passwordPage({Key? key}) : super(key: key);
//   @override
//   State<passwordPage> createState() => _passwordPageState();
// }

// class _passwordPageState extends State<LoginPage> {
//   final db = Mysql();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     idController.dispose();
//     passwordController.dispose();
//   }

//   Future<List<Profiles>> getSQLData() async {
//     final List<Profiles> profileList = [];
//     final Mysql db = Mysql();
//     await db.getConnection().then((conn) async {
//       // String test = idController.text.toString();
//       await conn.query("SHA1('pw')");
//       await conn
//           .query("SELECT Password FROM User WHERE ID = '${idController.text}'")
//           .then((result) {
//         // password
//         String pass = result.toString();
//         String test_pass = passwordController.text.toString();
//         String pw = pass.substring(20, pass.length - 2);
//         String pw1 = SHA1('pw');

//         if (pw == test_pass) {
//           print("패스워드 일치");
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (BuildContext context) => Sign_up())); // 메인화면으로 바꿀것
//         } else
//           setState(() {
//             print("패스워드 불일치");
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text("비밀번호가 틀립니다." + pass),
//               duration: Duration(milliseconds: 700),
//             ));
//           });
//       });
//       setState(() {});
//     });
//     return profileList;
//   }
// }

// class _Sign_upState extends State<Sign_up> {
//   final db = Mysql();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController idController = TextEditingController(); //ID
//   final TextEditingController passwordController =
//       TextEditingController(); // password
//   final TextEditingController nameController = TextEditingController(); // name
//   final TextEditingController phonenumberController =
//       TextEditingController(); // phone number
//   final TextEditingController addressController =
//       TextEditingController(); // adress
//   final TextEditingController emailController = TextEditingController(); //email

//   void insertData() async {
//     db.getConnection().then((conn) {
//       String sqlQuery =
//           'INSERT into User (ID, Password, Name, Phone_Number, Address, Email) values (?, ?, ?, ?, ?, ?)';
//       conn.query(sqlQuery, [
//         idController.text,
//         passwordController.text,
//         nameController.text,
//         phonenumberController.text,
//         addressController.text,
//         emailController.text
//       ]);
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     idController.dispose();
//     passwordController.dispose();
//     nameController.dispose();
//     phonenumberController.dispose();
//     addressController.dispose();
//     emailController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: AppBar(
//           title: Column(
//             children: <Widget>[
//               Center(
//                 child: Text(
//                   '회원가입',
//                   style: TextStyle(
//                       height: 1.7,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25,
//                       fontFamily: 'Nanum Barumpen',
//                       fontStyle: FontStyle.normal),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: idController, // ID
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.account_tree),
//                     labelText: "아이디를 입력해주세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'ID'),
//                 validator: (id) {
//                   if (id!.isEmpty) {
//                     return "아이디를 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),

//               TextFormField(
//                 obscureText: true, // 비밀번호 적을때 안보이도록
//                 controller: passwordController, // password
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.vpn_key),
//                     labelText: "회원가입할 비밀번호를 입력해주세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'password'),
//                 validator: (password) {
//                   if (password!.isEmpty) {
//                     return "비밀번호를 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),

//               // TextFormField(
//               //   obscureText: true,
//               //   decoration: InputDecoration(
//               //     icon: Icon(Icons.vpn_key),
//               //     labelText: "비밀번호를 한번 더 입력해주세요",
//               //     border: OutlineInputBorder(),
//               //     hintText: 'password'
//               //   ),
//               //   validator: (password) {
//               //     if (password != passwordController) {
//               //       return "비밀번호가 일치하지 않습니다.";
//               //     }
//               //     return null;
//               //   },
//               // ),
//               TextFormField(
//                 controller: nameController, // name
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.vpn_key),
//                     labelText: "이름을 입력해주세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'name'),
//                 validator: (name) {
//                   if (name!.isEmpty) {
//                     return "이름을 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: phonenumberController, //phone number
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.circle),
//                     labelText: "휴대폰 번호를 입력해주세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'phone number'),
//                 validator: (phone) {
//                   if (phone!.isEmpty) {
//                     return "휴대폰 번호를 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),

//               TextFormField(
//                 controller: addressController, // adress
//                 decoration: InputDecoration(
//                   icon: Icon(Icons.circle),
//                   labelText: "주소를 입력해주세요.",
//                   border: OutlineInputBorder(),
//                   hintText: 'adress',
//                 ),
//                 validator: (adress) {
//                   if (adress!.isEmpty) {
//                     return "주소를 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),

//               TextFormField(
//                 controller: emailController, // email
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.circle),
//                     labelText: "회원가입할 이메일을 입력하세요.",
//                     border: OutlineInputBorder(),
//                     hintText: 'E-mail'),
//                 validator: (email) {
//                   if (email!.isEmpty) {
//                     return "이메일을 입력해주세요.";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 16.0),
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     insertData();
//                     print("정상적으로 회원가입이 되었습니다.");
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => LoginPage()));
//                   },
//                   child: Text('회원가입'),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
