<?php 
$conn = mysqli_connect("localhost", "root", "", "fluttercrud");
$nisn = $_POST["nisn"];
$data = mysqli_query($conn, "delete from siswa where nisn='$nisn' ");

if ($data) {
    echo json_encode(['pesan' => 'sukses']);
} else {
    echo json_encode(['pesan' => 'gagal']);
};


?>