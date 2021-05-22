<?php

require_once "db.php";

$conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

$query="select * from scuola_dettagli where id=".$_GET['Id_Scuola'];

$res=mysqli_query($conn, $query);

if(mysqli_num_rows($res)>0){

    $result=array();

    while($results=mysqli_fetch_assoc($res)){

        $result[]=$results;

    }

    echo json_encode($result);

    mysqli_free_result($res);
}
else echo json_encode(null);

mysqli_close($conn);

?>