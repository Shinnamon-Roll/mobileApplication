import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  // Reference to Firestore Collection 'students'
  final CollectionReference studentsCollection = FirebaseFirestore.instance
      .collection('students');

  // Helper function to calculate grade
  String _calculateGrade(double totalScore) {
    if (totalScore >= 80) return 'A';
    if (totalScore >= 70) return 'B';
    if (totalScore >= 60) return 'C';
    if (totalScore >= 50) return 'D';
    return 'F';
  }

  // Dialog for Add/Edit
  Future<void> _showFormDialog([DocumentSnapshot? document]) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController midtermController = TextEditingController();
    final TextEditingController finalController = TextEditingController();
    final TextEditingController projectController = TextEditingController();

    if (document != null) {
      final data = document.data() as Map<String, dynamic>;
      nameController.text = data['studentName'] ?? '';
      subjectController.text = data['subjectName'] ?? '';
      midtermController.text = (data['scoreMidterm'] ?? 0).toString();
      finalController.text = (data['scoreFinal'] ?? 0).toString();
      projectController.text = (data['scoreProject'] ?? 0).toString();
    }

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            document == null ? 'เพิ่มข้อมูลนักศึกษา' : 'แก้ไขข้อมูลนักศึกษา',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'ชื่อ-นามสกุล'),
                ),
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: 'ชื่อวิชา'),
                ),
                TextField(
                  controller: midtermController,
                  decoration: const InputDecoration(labelText: 'คะแนนกลางภาค'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: finalController,
                  decoration: const InputDecoration(labelText: 'คะแนนปลายภาค'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: projectController,
                  decoration: const InputDecoration(
                    labelText: 'คะแนนเก็บ/โปรเจกต์',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () async {
                final String name = nameController.text;
                final String subject = subjectController.text;
                final double? midterm = double.tryParse(midtermController.text);
                final double? finalScore = double.tryParse(
                  finalController.text,
                );
                final double? project = double.tryParse(projectController.text);

                if (name.isNotEmpty &&
                    subject.isNotEmpty &&
                    midterm != null &&
                    finalScore != null &&
                    project != null) {
                  final data = {
                    'studentName': name,
                    'subjectName': subject,
                    'scoreMidterm': midterm,
                    'scoreFinal': finalScore,
                    'scoreProject': project,
                  };

                  if (document == null) {
                    // Create
                    await studentsCollection.add(data);
                  } else {
                    // Update
                    await studentsCollection.doc(document.id).update(data);
                  }

                  if (context.mounted) Navigator.pop(context);
                } else {
                  // Optional: Show error snackbar or alert if validation fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
                  );
                }
              },
              child: const Text('บันทึก'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ระบบจัดการคะแนนนักศึกษา'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: studentsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('เกิดข้อผิดพลาดในการดึงข้อมูล'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('ยังไม่มีข้อมูล กดปุ่ม + เพื่อเพิ่ม'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              var data = document.data() as Map<String, dynamic>;

              // Safely handle number types (int or double)
              double midterm = (data['scoreMidterm'] ?? 0).toDouble();
              double finalScore = (data['scoreFinal'] ?? 0).toDouble();
              double project = (data['scoreProject'] ?? 0).toDouble();

              double total = midterm + finalScore + project;
              String grade = _calculateGrade(total);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Name and Subject
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${data['studentName']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Chip(
                            label: Text(
                              '${data['subjectName']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Scores Detail
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildScoreColumn('Midterm', midterm),
                          _buildScoreColumn('Final', finalScore),
                          _buildScoreColumn('Project', project),
                        ],
                      ),
                      const Divider(height: 20),

                      // Total and Grade
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Score: ${total.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: grade == 'F'
                                  ? Colors.red[100]
                                  : Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Grade: $grade',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: grade == 'F'
                                    ? Colors.red
                                    : Colors.green[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Actions: Edit / Delete
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.edit, size: 18),
                            label: const Text('แก้ไข'),
                            onPressed: () => _showFormDialog(document),
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 18,
                            ),
                            label: const Text(
                              'ลบ',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              _confirmDelete(context, document.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildScoreColumn(String label, double score) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          score.toStringAsFixed(1),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: const Text('คุณต้องการลบข้อมูลนี้ใช่หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('ยกเลิก'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await studentsCollection.doc(docId).delete();
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('ลบ', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
