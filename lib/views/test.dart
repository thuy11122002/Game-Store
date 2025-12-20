import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy chiều cao của màn hình (bao gồm cả vùng an toàn như tai thỏ/status bar)
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- PHẦN 1: HÌNH ẢNH (1/2 CHIỀU CAO) ---
            Stack(
              children: [
                Container(
                  height: screenHeight / 2, // Chiếm đúng 1/2 màn hình
                  width: double.infinity,
                  child: Image.network(
                    'https://picsum.photos/800/1200', // Thay bằng link ảnh của bạn
                    fit: BoxFit.cover,
                  ),
                ),
                // Nút X để quay lại
                Positioned(
                  top: MediaQuery.of(context).padding.top +
                      10, // Cách mép trên (tránh status bar)
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ],
            ),

            // --- PHẦN 2: THÔNG TIN BÀI VIẾT (1/2 CHIỀU CAO + CUỘN TIẾP) ---
            Container(
              constraints: BoxConstraints(
                minHeight: screenHeight /
                    2, // Đảm bảo phần chữ chiếm ít nhất 1/2 màn hình
              ),
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Tiêu đề bài viết",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Đây là phần nội dung bài viết. Do sử dụng SingleChildScrollView bao ngoài, nên khi nội dung "
                    "ở đây dài quá nửa màn hình, bạn có thể cuộn xuống để đọc tiếp. \n\nNội dung mẫu dài để test scroll:"
                    "Đây là phần nội dung bài viết. Do sử dụng SingleChildScrollView bao ngoài, nên khi nội dung "
                    "ở đây dài quá nửa màn hình, bạn có thể cuộn xuống để đọc tiếp. \n\nNội dung mẫu dài để test scroll:"
                    "Đây là phần nội dung bài viết. Do sử dụng SingleChildScrollView bao ngoài, nên khi nội dung "
                    "ở đây dài quá nửa màn hình, bạn có thể cuộn xuống để đọc tiếp. \n\nNội dung mẫu dài để test scroll:"
                    "Đây là phần nội dung bài viết. Do sử dụng SingleChildScrollView bao ngoài, nên khi nội dung "
                    "ở đây dài quá nửa màn hình, bạn có thể cuộn xuống để đọc tiếp. \n\nNội dung mẫu dài để test scroll:"
                    "Đây là phần nội dung bài viết. Do sử dụng SingleChildScrollView bao ngoài, nên khi nội dung "
                    "ở đây dài quá nửa màn hình, bạn có thể cuộn xuống để đọc tiếp. \n\nNội dung mẫu dài để test scroll:"
                    "Đây là phần nội dung bài viết. Do sử dụng SingleChildScrollView bao ngoài, nên khi nội dung "
                    "ở đây dài quá nửa màn hình, bạn có thể cuộn xuống để đọc tiếp. \n\nNội dung mẫu dài để test scroll:"
                    "Đây là phần nội dung bài viết. Do sử dụng SingleChildScrollView bao ngoài, nên khi nội dung "
                    "ở đây dài quá nửa màn hình, bạn có thể cuộn xuống để đọc tiếp. \n\nNội dung mẫu dài để test scroll:"
                    "Đây là phần nội dung bài viết. Do sử dụng SingleChildScrollView bao ngoài, nên khi nội dung "
                    "ở đây dài quá nửa màn hình, bạn có thể cuộn xuống để đọc tiếp. \n\nNội dung mẫu dài để test scroll:",
                    style: TextStyle(fontSize: 16, height: 1.5),
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
