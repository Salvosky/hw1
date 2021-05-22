<?php

require_once "db.php";

$conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

$query="select * from docenti_classe where id='".$_GET['id_classe']."'";

$res=mysqli_query($conn, $query);

if(mysqli_num_rows($res)>0){

    $result=array();

    while($results=mysqli_fetch_assoc($res)){

        $result[]=$results;

    }

    //echo json_encode($result);

    mysqli_free_result($res);
}

$query="select * from classe_dettagli where id_classe='".$_GET['id_classe']."'";

$res=mysqli_query($conn, $query);

if(mysqli_num_rows($res)>0){

    while($results=mysqli_fetch_assoc($res)){

        $result[]=$results;

    }

    echo json_encode($result);

    mysqli_free_result($res);

}

mysqli_close($conn);

?>