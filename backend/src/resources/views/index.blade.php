<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bengkel Otomotif Jaya Makmur</title>
    <link rel="stylesheet" href="{{ asset('css/styles.css') }}">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f2f2;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #f7b8d0;
            padding: 20px;
            text-align: center;
        }
        .product-container {
            display: flex;
            justify-content: space-around;
            padding: 20px;
        }
        .product {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 15px;
            text-align: center;
            width: 30%;
        }
        .product img {
            max-width: 100%;
            border-radius: 10px;
        }
        .product h4 {
            color: #f7a9b9;
        }
        .product p {
            color: #555;
        }
        .search-bar {
            text-align: center;
            margin-top: 20px;
        }
        .search-bar input {
            padding: 10px;
            width: 60%;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        footer {
            text-align: center;
            background-color: #f7b8d0;
            padding: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <header>
        <h1>Selamat datang di Bengkel Otomotif Jaya Makmur</h1>
    </header>

    <div class="search-bar">
        <input type="text" placeholder="Cari produk...">
    </div>

    <div class="product-container">
        <div class="product">
            <img src="https://example.com/image1.jpg" alt="Ban Motor">
            <h4>ASPIRA TL Premio Sportivo 80/80-14 FR</h4>
            <p>Rp 243,000.00</p>
            <p>Tubeless/Matic</p>
        </div>
        <div class="product">
            <img src="https://example.com/image2.jpg" alt="Van Belt">
            <h4>Van Belt Honda Vario 160 K2s</h4>
            <p>Rp 135,000.00</p>
            <p>Untuk motor: Stylo 160 (2024 - Sekarang)</p>
        </div>
        <div class="product">
            <img src="https://example.com/image3.jpg" alt="Kampas Rem">
            <h4>Kampas Rem (Disk) Cakram Depan</h4>
            <p>Rp 51,000.00</p>
            <p>Untuk motor: BeAT dan BeAT Street K1A (2020 - 2024)</p>
        </div>
    </div>

    <footer>
        <p>© 2025 Bengkel Otomotif Jaya Makmur</p>
    </footer>

</body>
</html>
