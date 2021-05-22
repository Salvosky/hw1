<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <title>ScuoleItalia</title>
        <link href="https://fonts.googleapis.com/css2?family=Newsreader:ital,wght@1,500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="homepage.css">
        <script src="university.js" defer></script>
        <script src="holidays.js" defer></script>
        <script src="notices.js" defer></script>
    </head>
    <body>
        <header>
            <nav>
                <div id="home"><a href="homepage.php">Home</a></div>
                <div class="section">
                    <a href="searchschool.php">Cerca scuola</a>
                    <a href="your_school.php">La tua scuola</a>
                    <?php

                        require_once "db.php";

                        session_start(); 

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
            <h1><strong>Benvenuto sul portale di ScuoleItalia </br>
            <?php if(isset($_SESSION['username'])) echo $_SESSION['username'];?> </strong></h1>
        </header>
        <section>
            <div class="hidden favourite">
                <h3>Notizie preferite</h3>
            </div>
            <h3>Notizie del giorno</h3>
            <div class="research">
                <h1>Cerca notizia</h1>
                <input type='text'>
                <h2>Cerca</h2>
            </div>
            <div class="general"></div>
            <div class="holidays">
                <h3>Giorni festivi</h3>
                <div class="researches">
                    <button id="ricercaNormale">Ricerca quest'anno</button>
                    <button id="ricercaConData">Ricerca anno specifico</button>
                    <input type='text'>
                </div>
                <div id="vacanze" class=hidden>
                    <div class="results"></div>
                </div>
            </div>
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