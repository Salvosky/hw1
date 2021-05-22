<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <title>ScuoleItalia</title>
        <link href="https://fonts.googleapis.com/css2?family=Newsreader:ital,wght@1,500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="help.css">
        <script src="university.js" defer></script>
    </head>
    <body>
        <header>
            <nav>
                <div id="home"><a href="homepage.php">Home</a></div>
                <div class="section">
                    <a href="searchschool.php">Cerca scuola</a>
                    <a href="your_school.php">La tua scuola</a>
                    <a href="help.php">Aiuto</a>
                    <a href="profile.php">Profilo</a>
                    <?php session_start(); if(isset($_SESSION['username'])) echo "<a href=logout.php>Esci</a>"; ?>
                </div>
                <div id="tendina">
                    <div></div>
                    <div></div>
                    <div></div>
                </div>
            </nav>
            <h1><strong>ScuoleItalia</strong></h1>
        </header>
        <section>
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