<?php

require_once "db.php"; 

$conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

$query="select * from valutazione_dettagli where cf_alunno='".$_GET['argument']."'";

$res=mysqli_query($conn, $query);

if(mysqli_num_rows($res)>0){

    $result=array();
    
    for($i=0;$i<mysqli_num_rows($res);$i++){

        $result[]=mysqli_fetch_assoc($res);

    }

    echo json_encode($result);

    mysqli_free_result($res);

}
else json_encode(null);

mysqli_close($conn);

?>