<?php

require "db.php";

$conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

$username=mysqli_real_escape_string($conn, $_GET['username']);

$query="select * from account where username='".$username."'";

$res=mysqli_query($conn, $query);

if(mysqli_num_rows($res)>0){

    echo json_encode(true);

}
else echo json_encode(false);

?>