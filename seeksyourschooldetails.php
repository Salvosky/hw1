<?php

require_once "db.php";

$conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

$query="select * from alunni_dettagli where cf='".$_GET['Cf']."'";

$res=mysqli_query($conn, $query);

if(mysqli_num_rows($res)>0){

    $result=mysqli_fetch_assoc($res);

    echo json_encode($result);

    mysqli_free_result($res);

}
else{

    mysqli_free_result($res);

    $query="select * from docente_classi where cf_insegnante='".$_GET['Cf']."'";

    $res=mysqli_query($conn, $query);

    if(mysqli_num_rows($res)>0){

        $result=mysqli_fetch_assoc($res);

        echo json_encode($result);

        mysqli_free_result($res);

    }

}

mysqli_close($conn);

?>