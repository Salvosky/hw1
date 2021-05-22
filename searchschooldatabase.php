<?php
        require "db.php";

        if(!isset($_GET['Id'])){

            $result=array();

            $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

            $query=mysqli_real_escape_string($conn, "select * from scuola");

            $res=mysqli_query($conn, $query);

            if(mysqli_num_rows($res)>0){

                while($results=mysqli_fetch_assoc($res))
                {

                    $result[]=$results;   
                    
                }

                echo json_encode($result);

                mysqli_free_result($res);

            }

            mysqli_close($conn);
        }
        /*else{
            $result=array();

            $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

            $query='select * from scuola where nome="'.mysqli_real_escape_string($conn, $_GET['schoolname']).'"';

            $res=mysqli_query($conn, $query);

            if($res){
                while($results=mysqli_fetch_assoc($res))
                {
                    $result[]=$results;   
                }
                echo json_encode($result);
                mysqli_free_result($res);
            }
            else echo json_encode(null);

            mysqli_close($conn);
        }*/
        else{
            $result=array();

            $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

            $query='select * from scuola';

            $res=mysqli_query($conn, $query);

            if(mysqli_num_rows($res)>0){
                
                while($results=mysqli_fetch_assoc($res))
                {
                    if($results['Id']===$_GET['Id']){
                        
                        $result[]=$results;

                    }   
                }

                echo json_encode($result);
                
                mysqli_free_result($res);

            }
            else echo json_encode(null);

            mysqli_close($conn);
        }
?>