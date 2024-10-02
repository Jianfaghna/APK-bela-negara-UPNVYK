import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AplikasiBelaNegara());
}

class AplikasiBelaNegara extends StatelessWidget {
  const AplikasiBelaNegara({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bela Negara',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HalamanLogin(),
    );
  }
}

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  HalamanLoginState createState() => HalamanLoginState();
}

class HalamanLoginState extends State<HalamanLogin> {
  final _formKey = GlobalKey<FormState>();
  final _kontrolerNamaPengguna = TextEditingController();
  final _kontrolerKataSandi = TextEditingController();
  bool _sembunyikanTeks = true;

  void _masuk() {
    if (_formKey.currentState!.validate()) {
      if (_kontrolerNamaPengguna.text == 'awewo' &&
          _kontrolerKataSandi.text == 'akugantenk') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HalamanBeranda(namaPengguna: _kontrolerNamaPengguna.text)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nama pengguna atau kata sandi salah!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Image.asset('assets/logo_upn.png', height: 120),
                  const SizedBox(height: 40),
                  Text(
                    'Selamat Datang',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _kontrolerNamaPengguna,
                    decoration: InputDecoration(
                      labelText: 'Nama Pengguna',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silakan masukkan nama pengguna';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _kontrolerKataSandi,
                    obscureText: _sembunyikanTeks,
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_sembunyikanTeks
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _sembunyikanTeks = !_sembunyikanTeks;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silakan masukkan kata sandi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _masuk,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HalamanBeranda extends StatelessWidget {
  final String namaPengguna;

  const HalamanBeranda({super.key, required this.namaPengguna});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halo, $namaPengguna'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HalamanLogin()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HalamanDetailUPNVY()),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat Datang di UPN "Veteran" Yogyakarta',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tekan untuk melihat detail',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Daftar Fakultas',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: facultyList.length,
                itemBuilder: (context, index) {
                  final faculty = facultyList[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(faculty.imageAsset),
                        radius: 30,
                      ),
                      title: Text(
                        faculty.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          '${faculty.numberOfMajors} Jurusan - ${faculty.numberOfStudents} Mahasiswa'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HalamanDetailFakultas(faculty: faculty),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HalamanDetailUPNVY extends StatelessWidget {
  const HalamanDetailUPNVY({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail UPN "Veteran" Yogyakarta'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/upn.jpg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arah Pendidikan',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Arah pendidikan UPN ”Veteran” Yogyakarta adalah mengembangkan ilmu pengetahuan dan teknologi yang dilandasi oleh nilai-nilai kedisiplinan, kejuangan, kreativitas, keunggulan, kebangsaan, dan kejujuran dalam rangka menunjang pembangunan nasional melalui bidang pendidikan tinggi dalam rangka terciptanya sumber daya manusia yang unggul di era global dengan dilandasi jiwa bela negara.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Visi dan Misi',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Visi: Menjadi universitas unggul dalam pengembangan ilmu pengetahuan, teknologi, dan seni berdasarkan nilai-nilai kejuangan.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Misi: 1. Menyelenggarakan pendidikan dan pengajaran yang berkualitas guna menghasilkan lulusan berdaya saing global yang memiliki jiwa disiplin, berdaya juang dan, kreatif serta berwawasan kebangsaan dan mampu menjadi komponen pendukung dalam sistem pertahanan negara;',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    ' 2. Meningkatkan kuantitas dan kualitas penelitian guna: a. Menunjang pengembangan mutu pendidikan dan pengajaran; b. Mengembangkan dan menerapkan ilmu pengetahuan dan teknologi (IPTEK) untuk menunjang pengabdian kepada masyarakat; dan c. Menghasilkan modal intelektual dan karya ilmiah dalam rangka menunjang pembangunan nasional; dan',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    ' 3. Pengembangan kegiatan pengabdian kepada masyarakat melalui a. Penyediaan layanan ilmu pengetahuan dan teknologi (IPTEK) dalam rangka meningkatkan kesejahteraan masyarakat; b. Peningkatan keberdayaan masyarakat; dan c. Peningkatan reputasi UPN ”Veteran” Yogyakarta.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanDetailFakultas extends StatelessWidget {
  final Faculty faculty;

  const HalamanDetailFakultas({super.key, required this.faculty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(faculty.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              faculty.imageAsset,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faculty.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Jumlah Jurusan: ${faculty.numberOfMajors}'),
                  Text('Jumlah Mahasiswa: ${faculty.numberOfStudents}'),
                  const SizedBox(height: 16),
                  Text(
                    'Galeri',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: faculty.imageUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Image.network(
                            faculty.imageUrls[index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Faculty {
  String name;
  int numberOfMajors;
  int numberOfStudents;
  String imageAsset;
  List<String> imageUrls;

  Faculty({
    required this.name,
    required this.numberOfMajors,
    required this.numberOfStudents,
    required this.imageAsset,
    required this.imageUrls,
  });
}

final List<Faculty> facultyList = [
  Faculty(
    name: 'Fakultas Teknik',
    numberOfMajors: 6,
    numberOfStudents: 2000,
    imageAsset: 'assets/fakultas-teknik.jpg',
    imageUrls: [
      'https://upnyk.ac.id/images/fakultas/teknik1.jpg',
      'https://upnyk.ac.id/images/fakultas/teknik2.jpg',
      'https://pmb.upnyk.ac.id/assets/img/fakultas_fti.png',
    ],
  ),
  Faculty(
    name: 'Fakultas Ekonomi dan Bisnis',
    numberOfMajors: 5,
    numberOfStudents: 1500,
    imageAsset: 'images/fakultas-ekonomi.jpg',
    imageUrls: [
      'https://upnyk.ac.id/images/fakultas/ekonomi1.jpg',
      'https://upnyk.ac.id/images/fakultas/ekonomi2.jpg',
      'https://www.old.upnyk.ac.id/asset/images/DSC_0356.JPG',
    ],
  ),
  Faculty(
    name: 'Fakultas Ilmu Sosial dan Ilmu Politik',
    numberOfMajors: 4,
    numberOfStudents: 1200,
    imageAsset: 'images/fakultas-fisip.jpg',
    imageUrls: [
      'https://upnyk.ac.id/images/fakultas/fisip1.jpg',
      'https://upnyk.ac.id/images/fakultas/fisip2.jpg',
      'https://haluan.co/wp-content/uploads/2024/08/UGM-Beri-Restu-Mahasiswa-Fisipol.jpeg',
    ],
  ),
  Faculty(
    name: 'Fakultas Pertanian',
    numberOfMajors: 3,
    numberOfStudents: 800,
    imageAsset: 'images/fakultas-pertanian.jpg',
    imageUrls: [
      'https://upnyk.ac.id/images/fakultas/pertanian1.jpg',
      'https://upnyk.ac.id/images/fakultas/pertanian2.jpg',
      'https://smaalmasoem.sch.id/assets/img/blog/97a5f816273f72cfa00c9eb8bcd25b6d.jpg',
    ],
  ),
  Faculty(
    name: 'Fakultas Hukum',
    numberOfMajors: 1,
    numberOfStudents: 600,
    imageAsset: 'images/fakultas-hukum.jpg',
    imageUrls: [
      'https://upnyk.ac.id/images/fakultas/hukum1.jpg',
      'https://upnyk.ac.id/images/fakultas/hukum2.jpg',
      'https://pict.sindonews.net/dyn/850/pena/news/2023/11/15/211/1252037/awas-salah-jurusan-ini-beda-jurusan-ilmu-hukum-dan-jurusan-hukum-yang-perlu-diketahui-vuw.jpg',
    ],
  ),
  Faculty(
    name: 'Fakultas Teknologi Mineral',
    numberOfMajors: 5,
    numberOfStudents: 3000,
    imageAsset: 'images/fakultas-ftm.jpg',
    imageUrls: [
      'https://upnyk.ac.id/images/fakultas/ftm1.jpg',
      'https://upnyk.ac.id/images/fakultas/ftm2.jpg',
      'https://geofisika.upnyk.ac.id/public/assets/post/82169585346910407237.png',
    ],
  ),
  Faculty(
    name: 'Fakultas Perikanan',
    numberOfMajors: 3,
    numberOfStudents: 1000,
    imageAsset: 'images/fakultas-ikan.jpg',
    imageUrls: [
      'https://upnyk.ac.id/images/fakultas/ikan1.jpg',
      'https://upnyk.ac.id/images/fakultas/ikan2.jpg',
      'https://joss.co.id/data/uploads/2021/03/akuakultur-FPIK-UNDIP.jpg',
    ],
  ),
];
