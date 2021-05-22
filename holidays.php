<?php

require_once "db.php";

$apikey="fd2cb6c336df135336f58bf02e9b0a92a8ebde3e";

$curl=curl_init();

if(isset($_GET['year'])){

    curl_setopt($curl, CURLOPT_URL, "https://calendarific.com/api/v2/holidays?api_key=".$apikey."&country=IT&year=".$_GET['year']);

    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

    $holidays=curl_exec($curl);

    echo $holidays;    

}
else echo json_encode(null);

curl_close($curl);

?>