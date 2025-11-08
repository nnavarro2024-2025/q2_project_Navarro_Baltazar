import 'package:edc_v2/features/main/domain/entity/application_entity.dart';

// Dummy applications used when backend is not available.
final List<ApplicationEntity> dummyApplications = [
  ApplicationEntity(
    id: 'org_soulciety',
    title: 'Soulciety Non-Profit Organization',
    status: ApplicationStatus.inProgress,
    description:
        'Soulciety is a Philippine-based non-profit that bridges technology and education by donating refurbished computers and electronic devices to underprivileged schools and students. Their mission is to promote digital inclusion and support youth empowerment through access to technology.',
    amount: 3000000,
    collectedPercentage: 0,
    collectedAmount: 2000000,
    donorCount: 34,
    urgent: false,
    images: [
      'assets/images/soulciety.jpeg',
    ],
    deadline: DateTime.now().add(const Duration(days: 45)),
  ),
  ApplicationEntity(
    id: 'org_adaptech',
    title: 'Adaptech Philippines',
    status: ApplicationStatus.inProgress,
    description:
        'Adaptech Philippines provides refurbished laptops, tablets, and mobile devices to students in need, especially in rural communities. The organization also runs digital literacy workshops and e-waste recycling programs to create a sustainable tech ecosystem for education.',
    amount: 1000000,
    collectedPercentage: 0,
    collectedAmount: 100000,
    donorCount: 52,
    urgent: false,
    images: ['assets/images/adaptech2.jpg',
    ],
    deadline: DateTime.now().add(const Duration(days: 20)),
  ),
  ApplicationEntity(
    id: 'org_edfoundation',
    title: 'Education Foundation of the Philippines Inc.',
    status: ApplicationStatus.inProgress,
    description:
        'The Education Foundation of the Philippines Inc. supports public schools and low-income students by providing educational materials, learning equipment, and financial aid. Their projects aim to close the learning gap between urban and rural communities.',
    amount: 1300000,
    collectedPercentage: 0,
    collectedAmount: 130000,
    donorCount: 18,
    urgent: false,
    images: ['assets/images/edfoundation.jpg'],
    deadline: DateTime.now().add(const Duration(days: 90)),
  ),
  ApplicationEntity(
    id: 'org_youngfocus',
    title: 'Young Focus for Education and Development Foundation, Inc.',
    status: ApplicationStatus.inProgress,
    description:
        'Young Focus Philippines works in Tondo, Manila, helping children and youth get access to education and personal development opportunities. The foundation provides scholarships, learning centers, and family support to break the cycle of poverty through education.',
    amount: 2200000,
    collectedPercentage: 0,
    collectedAmount: 1200000,
    donorCount: 27,
    urgent: false,
    images: ['assets/images/youngfocus.jpg'],
    deadline: DateTime.now().add(const Duration(days: 30)),
  ),
  ApplicationEntity(
    id: 'org_iecep',
    title: 'IECEP Foundation, Inc.',
    status: ApplicationStatus.inProgress,
    description:
        'The IECEP Foundation supports education and training for electronics engineers and underprivileged students. They provide scholarships, mentorship, and technical resources to strengthen the field of electronics and communication engineering in the Philippines.',
    amount: 4500000,
    collectedPercentage: 0,
    collectedAmount: 2100000,
    donorCount: 22,
    urgent: false,
    images: ['assets/images/iecep.jpeg'],
    deadline: DateTime.now().add(const Duration(days: 60)),
  ),
];


// Additional details for the dummy applications. Keys are application IDs.
final Map<String, Map<String, dynamic>> dummyApplicationDetails = {


  "org_soulciety": {
  "mission": "We donate used computers from Silicon Valley to schools in the provinces of the Philippines, to bridge the digital divide and provide access to technology for students who lack it. (since 2009)",
  "members": ['LBC Cargo (featured sponsor)'],
  "address": "28924 Ruus Rd, Hayward, CA 94544, USA",
  "website": "https://www.soulciety.org",
  "social": {
    "facebook": "https://www.facebook.com/groups/soulciety1",
    "twitter": "https://twitter.com/soulciety"
  }
},
"org_adaptech": {
  "mission": "To provide technological access, skills and opportunities for Filipino students from underserved communities, by refurbishing used devices and delivering digital‐literacy workshops.",  
  "members": ["Sancho Syquia (founder)"],  
  "address": "",  
  "website": "https://adaptechph.org",  
  "social": {
    "facebook": "https://facebook.com/adaptechph",  
    "twitter": ""
  }
},

  'org_edfoundation':  {
  "mission": "To provide students in the urban and rural provinces of the Philippines with the necessary materials needed for them to succeed in the classroom, and to raise awareness of unequal education and make positive changes for all Filipino children." ,
  "members": ["Gemma Adolfo-Mechure (CEO)", "Dr. Miko Mechure (COO)"],
  "address": "P.O. Box 1144, Woodinville WA 98072, USA",
  "website": "https://www.edfoundationph.org",
  "social": {
    "facebook": "https://www.facebook.com/edfoundationph",
    "twitter": ""
  }
},
  'org_youngfocus': {
  "mission": "To give under-privileged children and young people in the Philippines the chance to develop themselves intellectually, emotionally, psychologically and spiritually through education and community programs.",
  "members": ["Young Focus Philippines staff & volunteers"],
  "address": "284 Dayao Street, Tondo, Manila, Philippines",
  "website": "https://www.youngfocus.org",
  "social": {
    "facebook": "https://www.facebook.com/youngfocus.org",
    "twitter": ""
  }
},
  'org_iecep': {
  "mission": "To support electronics engineers and under-privileged individuals by providing resources and equipment in the electronics and technology fields in the Philippines.",
  "members": ["Electronics Engineers of the Philippines Foundation Inc. board"],
  "address": "Co-working Office, Cross Roads Mall M. Cuenco Avenue, Cebu City 6000, Philippines",
  "website": "https://iecepfoundation.org",
  "social": {
    "facebook": "https://www.facebook.com/iecepfoundation",
    "twitter": ""
  }
},
};
