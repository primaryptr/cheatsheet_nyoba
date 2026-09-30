import 'package:flutter/material.dart';
import '../models/book_models.dart';

class DetailPage extends StatefulWidget {
  final BookModel item;

  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

void _toggleFavorite() {
    setState(() {
      widget.item.isFavorite = !widget.item.isFavorite;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.item.isFavorite
              ? '${widget.item.title} ditambahkan ke Favorit!'
              : '${widget.item.title} dihapus dari Favorit.',
        ),
        backgroundColor: widget.item.isFavorite ? Colors.green : Colors.grey[700],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              widget.item.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.item.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey[100],
                child: Image.network(
                  widget.item.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.image, size: 80, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.item.author,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.item.rating} / 5.0',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          widget.item.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: widget.item.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: _toggleFavorite,
                        tooltip: 'Favorit',
                      ),
                    ],
                  ),
                  const Divider(height: 24, thickness: 1),
                  _buildDetailRow('Tahun', '${widget.item.year}'),
                  _buildDetailRow('Genre', widget.item.genre),
                  _buildDetailRow('Halaman', '${widget.item.pages} lembar'),
                  _buildDetailRow('Penerbit', widget.item.publisher),
                  _buildDetailRow('Favorit', widget.item.isFavorite ? 'Ya (Disukai)' : 'Tidak'),
                  const Divider(height: 24, thickness: 1),
                  const Text(
                    'Deskripsi Lengkap:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black87,
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

  // Helper function untuk merender baris detail (Modularisasi UI)
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}