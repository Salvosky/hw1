<?php
    /*require_once "db.php";

    $error=false;

    if(!empty($_POST['username']) && !empty($_POST['password'])){

        $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

        $username=mysqli_real_escape_string($conn, $_POST['username']);

        $password=mysqli_real_escape_string($conn, $_POST['password']);
    
        $password_hash=password_hash($password, PASSWORD_BCRYPT);

        $query="select username from account where username='".$username."'";

        $res=mysqli_query($conn, $query);

        if(mysqli_num_rows($res)>0){

            $error=true;

        }
        else{

            $query="Insert into account (Username, Password) values ('".$username."', '".$password_hash."')";

            $res=mysqli_query($conn, $query);

            if(!$res){

                $error=true;

            }

            header("Location: login.php");

        }
    }*/
    require_once "db.php";

    if(!empty($_POST['username']) && !empty($_POST['password']) && !empty($_POST['nome']) && !empty($_POST['cognome'])){

            $conn=mysqli_connect($db['host'], $db['username'], $db['password'], $db['db']) or die(mysqli_connect_error());

            $username=mysqli_real_escape_string($conn, $_POST['username']);

            $nome=mysqli_real_escape_string($conn, $_POST['nome']);
           
            $cognome=mysqli_real_escape_string($conn, $_POST['cognome']);

            $cf=mysqli_real_escape_string($conn, $_POST['cf']);

            $password=mysqli_real_escape_string($conn, $_POST['password']);

            $password=password_hash($password, PASSWORD_BCRYPT);

            $query="select username from account where username='".$username."' or cf='".$cf."'";

            $res=mysqli_query($conn, $query);

            if(mysqli_num_rows($res)>0){

                $error="<p>Errore nella registrazione, riprovare</p>";

            }
            else{

                $query="Insert into account (Cf, Username, Nome, Cognome, Password) values ('".$cf."', '".$username."', '".$nome."', '".$cognome."', '".$password."')";

                $res=mysqli_query($conn, $query) or die(mysqli_connect_error());

                header("Location: login.php");

            }
        }
?>

<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <title>ScuoleItalia</title>
        <link href="https://fonts.googleapis.com/css2?family=Newsreader:ital,wght@1,500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="register.css">
        <script src="university.js" defer></script>
        <script src="register_page.js" defer></script>
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
                    <?php session_start(); if(isset($_SESSION['username'])) echo "<a href=logout.php>Esci</a>"; ?>
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
        <div class="hidden" id="error"><p></p></div>
        <?php if(isset($error)) echo "$error";?>
            <div class="title">Registrazione</div>
            <div id="register">
                <form name="register" method="post">
                    <label>Inserisci Username<input type="text" name="username"></label>
                    <label>Inserisci Nome<input type="text" name="nome"></label>
                    <label>Inserisci Cognome<input type="text" name="cognome"></label>
                    <label>Inserisci Codice Fiscale<input type="text" name="cf"></label>
                    <label>Inserisci Password<input type="password" name="password"></label>
                    <label>Conferma Password<input type="password" name="confirm"></label>
                    <label><strong>Accetto i termini e le condizioni d'uso</strong><input type="checkbox" name="check"></label>
                    <label><span></span><input type="submit" name="submit" value="Registrati">
                </form>
            </div>
            <div class="text">La password deve contenere almeno una maiuscola ed un numero, e deve essere almeno di 8 caratteri</div>
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