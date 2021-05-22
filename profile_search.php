<?php

require "db.php";

$username=$_GET['username'];

$conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

$query="select username, nome, cognome, cf from account where username='".$username."'";

$res=mysqli_query($conn, $query);

if(mysqli_num_rows($res)>0){

    $result=mysqli_fetch_assoc($res);

    mysqli_free_result($res);

    $query="select * from alunno where cf='".$result['cf']."'";

    $res=mysqli_query($conn, $query);

    if(mysqli_num_rows($res)>0){

        $result['tipo']="Alunno";

    }else{

        mysqli_free_result($res);

        $query="select tipo from impiegato where cf='".$result['cf']."'";

        $res=mysqli_query($conn, $query);

        if(mysqli_num_rows($res)>0){

            $result['tipo']=mysqli_fetch_row($res)[0];

            mysqli_free_result($res);

        }

    }

    echo json_encode($result);

}

mysqli_close($conn);

?>