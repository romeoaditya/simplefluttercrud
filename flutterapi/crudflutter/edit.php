<?php 
$conn = mysqli_connect("localhost", "root", "", "fluttercrud");
$id = $_POST["id"];
$nisn = $_POST["nisn"];
$nama = $_POST["nama"];
$alamat = $_POST["alamat"];
$data = mysqli_query($conn, "update siswa set nisn='$nisn', nama='$nama', alamat='$alamat' where id='$id' ");

if ($data) {
    echo json_encode(['pesan' => 'sukses']);
} else {
    echo json_encode(['pesan' => 'gagal']);
};


?>