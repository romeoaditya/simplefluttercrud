<?php 
$conn = mysqli_connect("localhost", "root", "", "fluttercrud");
$nisn = $_POST["nisn"];
$nama = $_POST["nama"];
$alamat = $_POST["alamat"];
$data = mysqli_query($conn, "insert into siswa set nisn='$nisn', nama='$nama', alamat='$alamat'");

if ($data) {
    echo json_encode(['pesan' => 'sukses']);
} else {
    echo json_encode(['pesan' => 'gagal']);
};


?>