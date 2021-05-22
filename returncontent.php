<?php

require_once "db.php";

$conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

$query="select * from content";

$res=mysqli_query($conn, $query);

if(mysqli_num_rows($res)>0){

    $content=array();

    while($result=mysqli_fetch_assoc($res)){

        $content[]=$result;

    }

    mysqli_free_result($res);

    echo json_encode($content);

    mysqli_close($conn);

}

?>