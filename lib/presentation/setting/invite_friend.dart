import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:likya_app/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>>? friends;
  List<Map<String, dynamic>> filteredFriends = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _askPermissions();
    fetchFriends();
    searchController.addListener(_filterFriends);
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    } else {
      fetchFriends();
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool _isFetchingFriends = false;

  Future<void> fetchFriends() async {
    if (_isFetchingFriends) return; // Prevent re-entrance
    setState(() {
      _isFetchingFriends = true;
    });

    try {
      List<Contact> fetchedfriends = await FastContacts.getAllContacts();
      setState(() {
        friends = fetchedfriends.map<Map<String, dynamic>>((contributor) {
          return {"contact": contributor, "isSelected": false};
        }).toList();
        filteredFriends = List<Map<String, dynamic>>.from(friends!);
      });
    } catch (e) {
      // Handle the error gracefully
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch contacts: $e')),
      );
      // ignore: avoid_print
      print('Error fetching contacts: $e'); // Log the error for debugging
    } finally {
      setState(() {
        _isFetchingFriends = false;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterFriends() {
    final query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        filteredFriends = List<Map<String, dynamic>>.from(friends!);
      });
      return;
    }

    setState(() {
      filteredFriends = friends!.where((contributor) {
        final contact = contributor["contact"];
        final displayName =
            contact?.structuredName?.displayName?.toLowerCase() ?? '';
        final phoneNumber = contact?.phones?.isNotEmpty == true
            ? contact.phones[0].number.toLowerCase()
            : '';

        return displayName.contains(query) || phoneNumber.contains(query);
      }).toList();
    });
  }

  Future<void> _sendSMS(String message, String recipient) async {
    final Uri uri = Uri(
      scheme: 'sms',
      path: recipient,
      queryParameters: <String, String>{'body': message},
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Impossible d'ouvrir l'application SMS."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inviter un ami",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isFetchingFriends
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        friendsField(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Padding friendsField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recherche de contacts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // Barre de recherche
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Rechercher un contact',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              setState(() {
                if (query.length > 3) {
                  filteredFriends = friends!
                      .where((contributor) =>
                          contributor["contact"]
                              .structuredName
                              .displayName
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          contributor["contact"].phones.any((phone) => phone
                              .number
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase())))
                      .toList();
                } else {
                  filteredFriends = [];
                }
              });
            },
          ),
          const SizedBox(height: 10),
          filteredFriends.isEmpty
              ? const Text("Aucun contact trouvé.")
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredFriends.length,
                  itemBuilder: (context, index) {
                    final contributor = filteredFriends[index];
                    final contact = contributor["contact"];

                    // Extract displayName and phone number safely
                    final displayName =
                        contact?.structuredName?.displayName ?? "Nom inconnu";
                    final phoneNumber = contact?.phones?.isNotEmpty == true
                        ? contact.phones[0].number
                        : "Numéro inconnu";

                    return ListTile(
                      title: Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        phoneNumber,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0xFF99CCCC),
                        child: Text(
                          getInitials(displayName),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        if (phoneNumber != "Numéro inconnu") {
                          const String message =
                              "Bonjour, vous avez été invité(e) à rejoindre notre application Likya.";
                          _sendSMS(message, phoneNumber);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Ce contact n'a pas de numéro de téléphone."),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
        ],
      ),
    );
  }
}
