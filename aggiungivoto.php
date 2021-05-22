<?php

require_once "db.php";

session_start(); 

if(isset($_POST['alunno']) && isset($_POST['materie']) && isset($_POST['vote']) && isset($_POST['date'])){

    $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

    if(isset($_SESSION['username'])){

        $query="select cf from account where username='".$_SESSION['username']."'";

        $res=mysqli_query($conn, $query);

        if(mysqli_num_rows($res)>0){

            $resal3=mysqli_fetch_assoc($res);

        }

        mysqli_free_result($res);

    }

    $query="Insert into valutazione(cf_alunno, cf_insegnante, Nomemateria, Voto, Data) values ('".$_POST['alunno']."', '".$resal3['cf']."', '".$_POST['materie']."', ".$_POST['vote'].", '".$_POST['date']."')";

    $res=mysqli_query($conn, $query);

    if($res){


        header("Location: valutazione.php");

        exit;

    }
    else $error=true;

    mysqli_close($conn);

}

?>

<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <title>ScuoleItalia</title>
        <link href="https://fonts.googleapis.com/css2?family=Newsreader:ital,wght@1,500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="aggiungivoto.css">
        <script src="university.js" defer></script>
        <script src="addvote.js" defer></script>
    </head>
    <body>
        <header>
            <nav>
                <div id="home"><a href="homepage.php">Home</a></div>
                <div class="section">
                    <a href="searchschool.php">Cerca scuola</a>
                    <a href="your_school.php">La tua scuola</a>
                    <?php

                        if(isset($_SESSION['username'])){

                            $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

                            $query="select cf from account where username='".$_SESSION['username']."'";

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
                            }
                            if($result['tipo']==="Alunno" || $result['tipo']==="Insegnante"){

                                echo "<a href=valutazione.php>Voti</a>";

                            }
                        }
                    ?>
                    <a href="profile.php">Profilo</a>
                    <?php if(isset($_SESSION['username'])) echo "<a href=logout.php>Esci</a>"; ?>
                </div>
                <div id="mobile">
                    <div id="tendina">
                        <div class="icon"></div>
                        <div class="icon"></div>
                        <div class="icon"></div>
                    </div>
                </div>
            </nav>
            <div id="menutendina" class="hidden">
                <a href="searchschool.php">Cerca scuola</a>
                <a href="your_school.php">La tua scuola</a>
                <?php

                    if(isset($_SESSION['username'])){

                        $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

                        $query="select cf from account where username='".$_SESSION['username']."'";

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
                        }
                        if($result['tipo']==="Alunno" || $result['tipo']==="Insegnante"){

                            echo "<a href=valutazione.php>Voti</a>";

                        }
                    }
                ?>
                <a href="profile.php">Profilo</a>
                <?php if(isset($_SESSION['username'])) echo "<a href=logout.php>Esci</a>"; ?>
            </div>
            <h1><strong>ScuoleItalia</strong></h1>
        </header>
        <section>
        <?php

        if($result['tipo']!=="Insegnante"){

            header("Location: homepage.php");

            exit;

        }

        ?>
            <h1>Aggiungi voto</h1>
            <div id="error" class="hidden">Inserire un valore in tutti i campi</div>
            <?php 
            
                if(isset($error)){

                    if($error){

                        echo "<div id='errorinsert'>Errore nell'inserimento nel database, riprovare più tardi</div>";

                    }

                } 
            ?>
            <form name="addvote" method="post">
            <label><span class="text">Alunno</span>
                <select name="alunno">
                <option value="">---Selezionare un alunno---</option>
                    <?php

                        $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

                        $query="select id_classe from docenza where cf_insegnante='".$result['cf']."'";

                        $res=mysqli_query($conn, $query);

                        if(mysqli_num_rows($res)>0){

                            while($resal=mysqli_fetch_assoc($res)){

                                mysqli_free_result($res);

                                $query="select * from alunno where id_classe=".$resal['id_classe'];

                                $res=mysqli_query($conn, $query);

                                if(mysqli_num_rows($res)>0){

                                    while($resal2=mysqli_fetch_assoc($res)){

                                        echo "<option value='".$resal2['Cf']."'>".$resal2['Nome']." ".$resal2['Cognome']." ".$resal2['Cf']."</option>";

                                    }

                                }

                            }
                        
                        }
                    ?>
                </select>
            </label>
                <label>Materia
                    <select name="materie">
                    <option value="">---Inserisci Materia---</option>
                    <?php

                        $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

                        $query="select nomemateria from docenza where cf_insegnante='".$result['cf']."'";

                        $res=mysqli_query($conn, $query);

                        if(mysqli_num_rows($res)>0){

                            while($resmat=mysqli_fetch_assoc($res)){

                                echo "<option value='".$resmat['nomemateria']."'>".$resmat['nomemateria']."</option>";

                            }
                        
                        }
                    ?>
                    </select>
                </label>
                <label>Voto
                    <select name="vote">
                        <option value="0">0</option>
                        <option value="0.5">0.5</option>
                        <option value="1">1</option>
                        <option value="1.5">1.5</option>
                        <option value="2">2</option>
                        <option value="2.5">2.5</option>
                        <option value="3">3</option>
                        <option value="3.5">3.5</option>
                        <option value="4">4</option>
                        <option value="4.5">4.5</option>
                        <option value="5">5</option>
                        <option value="5.5">5.5</option>
                        <option value="6">6</option>
                        <option value="6.5">6.5</option>
                        <option value="7">7</option>
                        <option value="7.5">7.5</option>
                        <option value="8">8</option>
                        <option value="8.5">8.5</option>
                        <option value="9">9</option>
                        <option value="9.5">9.5</option>
                        <option value="10">10</option>
                    </select>
                </label> 
                <label>Data<input type="date" name="date"></label>
                <input type="submit" value="Aggiungi">
            </form>
        </section>
        <footer>
            <address>ScuoleItalia.net è un progetto a cura di</address> 
            <p>Ferula Salvatore</p>
            <div>
                della facoltà di ingegneria informatica della
                <a></a>
                , matricola O46002233
            </div>
        </footer>
    </body>
</html>