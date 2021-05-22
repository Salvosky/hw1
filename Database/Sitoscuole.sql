-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 22, 2021 alle 12:37
-- Versione del server: 10.4.18-MariaDB
-- Versione PHP: 8.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sitoscuole`
--
CREATE DATABASE IF NOT EXISTS `sitoscuole` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sitoscuole`;

-- --------------------------------------------------------

--
-- Struttura della tabella `account`
--

CREATE TABLE `account` (
  `Cf` varchar(30) NOT NULL,
  `Username` varchar(30) NOT NULL,
  `Nome` varchar(30) NOT NULL,
  `Cognome` varchar(30) NOT NULL,
  `Password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `account`
--

INSERT INTO `account` (`Cf`, `Username`, `Nome`, `Cognome`, `Password`) VALUES
('Cod10', 'jen', 'Giulio', 'Piccolo', '$2y$10$ENEcMQghyCcRIPrzvIQAze3.g6mGv6hQR2r3zwU7QlDQiE6iSCtRy'),
('Cod100', 'jon', 'Giacomo', 'Villa', '$2y$10$DIVv8HmST0Yw7h5ugOoc.eij7fJ0XGcCwTe1JHwHWtu3Hq7BrAJDi'),
('Cod145', 'pipo', 'Alfonso', 'Signora', '$2y$10$e6N0YijXRSWFkxNl9556XeTZtkm71nPooxB165QQmVbRIozu/CY7y'),
('Cod410', 'Cicciopasticcio', 'Paolino', 'Paperino', '7sg363bcbe2nx3y'),
('Cod635', 'Merlocchio', 'Tizio', 'Geppetto', 'bbcv46nx38b44c');

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `alunni_dettagli`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `alunni_dettagli` (
`cf` varchar(16)
,`nome` varchar(30)
,`cognome` varchar(30)
,`eta` int(11)
,`id_scuola` int(11)
,`scuola` varchar(30)
,`id_classe` int(11)
,`indirizzo` varchar(20)
,`anno` int(11)
,`corso` varchar(1)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `alunni_per_docente`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `alunni_per_docente` (
`cf_insegnante` varchar(16)
,`n_alunni_docente` bigint(21)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `alunno`
--

CREATE TABLE `alunno` (
  `Cf` varchar(16) NOT NULL,
  `Nome` varchar(30) DEFAULT NULL,
  `Cognome` varchar(30) DEFAULT NULL,
  `Nascita` date DEFAULT NULL,
  `Eta` int(11) DEFAULT NULL,
  `id_scuola` int(11) DEFAULT NULL,
  `id_classe` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `alunno`
--

INSERT INTO `alunno` (`Cf`, `Nome`, `Cognome`, `Nascita`, `Eta`, `id_scuola`, `id_classe`) VALUES
('Cod1', 'Luca', 'Pierini', '2007-06-23', 14, 2, 2),
('Cod10', 'Giulio', 'Piccolo', '2003-03-02', 18, 1, 5),
('Cod11', 'Elena', 'Calabrese', '2010-02-01', 11, 3, 6),
('Cod12', 'Luigi', 'Silvestri', '2004-11-11', 17, 1, 3),
('Cod13', 'Samuele', 'Bellini', '2009-01-31', 12, 2, 7),
('Cod2', 'Paolo', 'Guizzanti', '2010-11-21', 11, 3, 1),
('Cod3', 'Brian', 'Perez', '2004-05-09', 17, 1, 3),
('Cod4', 'Caterina', 'Viendalmare', '2010-01-08', 11, 3, 1),
('Cod5', 'Rina', 'Muller', '2008-06-12', 13, 2, 2),
('Cod6', 'Daniela', 'Sponci', '2004-10-31', 17, 1, 3),
('Cod7', 'Greta', 'Ferri', '2009-08-12', 12, 2, 7),
('Cod8', 'Gabriele', 'Mele', '2013-12-21', 8, 3, 4),
('Cod9', 'Giorgio', 'De Luca', '2013-10-05', 8, 3, 4);

--
-- Trigger `alunno`
--
DELIMITER $$
CREATE TRIGGER `assegnascuola` AFTER INSERT ON `alunno` FOR EACH ROW begin
if((select id_scuola from alunno where cf=new.cf) is null) then
update alunno
set id_scuola=(select id 
               from scuola 
   where id in (select id_scuola 
                from edificio 
where nome in (select nome_edificio 
               from classe 
   where id=new.id_classe)))
where cf=new.cf;
end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `setnalun` AFTER INSERT ON `alunno` FOR EACH ROW begin
update classe
set n_alunni=n_alunni+1 where id=new.id_classe;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `setnalun_delete` AFTER DELETE ON `alunno` FOR EACH ROW begin
update classe
set n_alunni=n_alunni-1 where id=old.id_classe;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `classe`
--

CREATE TABLE `classe` (
  `Id` int(11) NOT NULL,
  `Anno` int(11) DEFAULT NULL,
  `Corso` varchar(1) DEFAULT NULL,
  `Indirizzo` varchar(20) DEFAULT NULL,
  `Nome_edificio` varchar(30) DEFAULT NULL,
  `N_Alunni` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `classe`
--

INSERT INTO `classe` (`Id`, `Anno`, `Corso`, `Indirizzo`, `Nome_edificio`, `N_Alunni`) VALUES
(1, 5, 'D', 'Elementare', 'Struttura centrale Galilei', 2),
(2, 2, 'A', 'Medie', 'Palazzo Centrale Bellini', 2),
(3, 1, 'E', 'Scientifico', 'Plesso primario Paolini', 3),
(4, 2, 'C', 'Elementare', 'Struttura centrale Galilei', 2),
(5, 4, 'B', 'Scientifico', 'Plesso secondario Paolini', 1),
(6, 5, 'A', 'Elementare', 'Struttura centrale Galilei', 1),
(7, 1, 'D', 'Medie', 'Palazzo Centrale Bellini', 2);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `classe_dettagli`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `classe_dettagli` (
`id_classe` int(11)
,`anno` int(11)
,`corso` varchar(1)
,`indirizzo` varchar(20)
,`cf` varchar(16)
,`nome` varchar(30)
,`cognome` varchar(30)
,`eta` int(11)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `content`
--

CREATE TABLE `content` (
  `id` int(11) NOT NULL,
  `titolo` varchar(255) DEFAULT NULL,
  `immagine` varchar(255) DEFAULT NULL,
  `testo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `content`
--

INSERT INTO `content` (`id`, `titolo`, `immagine`, `testo`) VALUES
(6, 'Apertura del sito', 'immagine sito 1.jpg', 'Il sito e\' stato aperto. In questa sezione troverai le ultime notizie sulle scuole di tutta Italia');

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `docente_classi`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `docente_classi` (
`cf_insegnante` varchar(16)
,`scuola` varchar(30)
,`id_classe` int(11)
,`anno` int(11)
,`corso` varchar(1)
,`indirizzo` varchar(20)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `docenti_classe`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `docenti_classe` (
`nome` varchar(30)
,`cognome` varchar(30)
,`nascita` date
,`eta` int(11)
,`nomemateria` varchar(20)
,`id` int(11)
,`anno` int(11)
,`corso` varchar(1)
,`indirizzo` varchar(20)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `docenza`
--

CREATE TABLE `docenza` (
  `Cf_Insegnante` varchar(16) NOT NULL,
  `NomeMateria` varchar(20) NOT NULL,
  `Id_classe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `docenza`
--

INSERT INTO `docenza` (`Cf_Insegnante`, `NomeMateria`, `Id_classe`) VALUES
('Cod100', 'Italiano', 1),
('cod100', 'Storia', 3),
('Cod101', 'Matematica', 3),
('cod102', 'Italiano', 3),
('cod103', 'Geometria', 1),
('cod103', 'Matematica', 1),
('cod111', 'Filosofia', 5),
('cod112', 'Educazione Fisica', 5),
('cod113', 'Arte', 4),
('cod114', 'Scienze', 5),
('cod115', 'Arte', 2);

--
-- Trigger `docenza`
--
DELIMITER $$
CREATE TRIGGER `rv1` BEFORE INSERT ON `docenza` FOR EACH ROW begin
if((select count(distinct nomemateria) from docenza
where id_classe=new.id_classe
group by id_classe)>=12) then
signal sqlstate '45000' set message_text="La classe ha gi? 12 materie assegnate";
end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `rv2` BEFORE INSERT ON `docenza` FOR EACH ROW begin
if((select count(distinct id_classe) from docenza
where cf_insegnante=new.cf_insegnante)>=4) then
signal sqlstate '45000' set message_text="Il docente ha gi? 4 docenze";
end if;
if((select count(distinct nomemateria) from docenza
where cf_insegnante=new.cf_insegnante and id_classe=new.id_classe)>=2) then
signal sqlstate '45000' set message_text="Il docente ha gi? 2 materie in quella classe";
end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `verificadocenza` BEFORE INSERT ON `docenza` FOR EACH ROW if((select tipo from impiegato where cf=new.cf_insegnante)<>'Insegnante') then
signal sqlstate '45000' set message_text="L'impiegato non e' un docente";
end if
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `docenza_dettagli`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `docenza_dettagli` (
`nome` varchar(30)
,`cognome` varchar(30)
,`nomemateria` varchar(20)
,`anno` int(11)
,`corso` varchar(1)
,`indirizzo` varchar(20)
,`nome_scuola` varchar(30)
,`n_alunni_docente` bigint(21)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `edificio`
--

CREATE TABLE `edificio` (
  `Nome` varchar(30) NOT NULL,
  `Id_scuola` int(11) DEFAULT NULL,
  `N_piano` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `edificio`
--

INSERT INTO `edificio` (`Nome`, `Id_scuola`, `N_piano`) VALUES
('Palazzo Centrale Bellini', 2, 3),
('Plesso primario Paolini', 1, 5),
('Plesso quarto Paolini', 1, 2),
('Plesso secondario Paolini', 1, 3),
('Plesso terziario Paolini', 1, 2),
('Struttura centrale Galilei', 3, 1);

--
-- Trigger `edificio`
--
DELIMITER $$
CREATE TRIGGER `aggiornanedif` AFTER INSERT ON `edificio` FOR EACH ROW begin
update scuola
set n_edifici=n_edifici+1
where id=new.id_scuola;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `aggiornanedif_delete` AFTER DELETE ON `edificio` FOR EACH ROW begin
update scuola
set n_edifici=n_edifici-1
where id=old.id_scuola;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `rv3` BEFORE INSERT ON `edificio` FOR EACH ROW begin
if((select n_edifici from scuola where id=new.id_scuola)>=3) then
signal sqlstate '45000' set message_text="La scuola ha gi? 3 edifici";
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `esdl_dettagli`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `esdl_dettagli` (
`cf` varchar(16)
,`nome` varchar(30)
,`cognome` varchar(30)
,`eta` int(11)
,`tipo` varchar(20)
,`nome_scuola` varchar(30)
,`data_assunzione` date
,`data_fine_impiego` date
);

-- --------------------------------------------------------

--
-- Struttura della tabella `ex_sede_di_lavoro`
--

CREATE TABLE `ex_sede_di_lavoro` (
  `id_scuola` int(11) NOT NULL,
  `Cf_Impiegato` varchar(16) NOT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `Data_Assunzione` date DEFAULT NULL,
  `Data_fine_impiego` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `ex_sede_di_lavoro`
--

INSERT INTO `ex_sede_di_lavoro` (`id_scuola`, `Cf_Impiegato`, `tipo`, `Data_Assunzione`, `Data_fine_impiego`) VALUES
(1, 'cod103', 'Insegnante', '2010-05-11', '2016-11-15'),
(1, 'Cod108', 'Insegnante', '2015-10-02', '2018-07-10'),
(2, 'cod102', 'Preside', '2011-08-30', '2017-12-10'),
(2, 'cod107', 'Bidello', '2016-01-09', '2019-12-20'),
(2, 'cod111', 'Insegnante', '2012-02-10', '2018-12-22'),
(3, 'cod103', 'Insegnante', '2017-03-03', '2018-12-22');

--
-- Trigger `ex_sede_di_lavoro`
--
DELIMITER $$
CREATE TRIGGER `verificaimpiego` BEFORE INSERT ON `ex_sede_di_lavoro` FOR EACH ROW begin
if(new.data_fine_impiego>(select data_assunzione from sede_di_lavoro where cf_impiegato=new.cf_impiegato)) then
signal sqlstate '45000' set message_text="L'impiegato sta ancora lavorando in una scuola";
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `impiegato`
--

CREATE TABLE `impiegato` (
  `Cf` varchar(16) NOT NULL,
  `Nome` varchar(30) DEFAULT NULL,
  `Cognome` varchar(30) DEFAULT NULL,
  `Nascita` date DEFAULT NULL,
  `Eta` int(11) DEFAULT NULL,
  `Tipo` varchar(20) DEFAULT NULL CHECK (`Tipo` in ('Insegnante','Preside','Bidello')),
  `Stipendio` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `impiegato`
--

INSERT INTO `impiegato` (`Cf`, `Nome`, `Cognome`, `Nascita`, `Eta`, `Tipo`, `Stipendio`) VALUES
('Cod100', 'Giacomo', 'Villa', '1979-01-12', 42, 'Insegnante', 2114),
('Cod101', 'Gennaro', 'Tantaro', '1967-03-13', 54, 'Insegnante', 1992),
('Cod102', 'Valeria', 'Scannella', '1959-01-12', 62, 'Insegnante', 1318),
('Cod103', 'Luigi', 'Barone', '1970-11-09', 51, 'Insegnante', 1224),
('Cod104', 'Tiziana', 'Beretta', '1979-12-27', 42, 'Bidello', 1021),
('Cod105', 'Geronimo', 'Prezioso', '1978-04-07', 43, 'Bidello', 917),
('Cod106', 'Alfonso', 'Cilurzo', '1962-02-03', 59, 'Bidello', 870),
('Cod107', 'Leonarda', 'Parenti', '1961-01-12', 60, 'Bidello', 932),
('Cod108', 'Paolo', 'Cortellesi', '1955-09-23', 66, 'Preside', 2605),
('Cod109', 'Maria', 'Neri', '1970-05-12', 51, 'Preside', 2741),
('Cod110', 'Renato', 'Giurato', '1974-08-02', 47, 'Preside', 2966),
('Cod111', 'Francesco', 'Ferrara', '1970-12-05', 51, 'Insegnante', 1685),
('Cod112', 'Beatrice', 'Antonelli', '1967-03-01', 54, 'Insegnante', 2001),
('Cod113', 'Gianni', 'Bernardi', '1969-02-10', 52, 'Insegnante', 1539),
('Cod114', 'Valerio', 'Villani', '1969-09-09', 52, 'Insegnante', 1998),
('Cod115', 'Marta', 'Messina', '1972-09-08', 49, 'Insegnante', 1330),
('Cod116', 'Fabio', 'De Rosa', '1970-01-16', 51, 'Preside', 2700);

-- --------------------------------------------------------

--
-- Struttura della tabella `incorpora`
--

CREATE TABLE `incorpora` (
  `Nome_Palestra` varchar(30) NOT NULL,
  `Nome_Edificio` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `incorpora`
--

INSERT INTO `incorpora` (`Nome_Palestra`, `Nome_Edificio`) VALUES
('Palestra Bellini', 'Palazzo Centrale Bellini');

-- --------------------------------------------------------

--
-- Struttura della tabella `materia`
--

CREATE TABLE `materia` (
  `Nome` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `materia`
--

INSERT INTO `materia` (`Nome`) VALUES
('Arte'),
('Chimica'),
('Diritto'),
('Educazione Fisica'),
('Filosofia'),
('Francese'),
('Geografia'),
('Geometria'),
('Inglese'),
('Italiano'),
('Latino'),
('Matematica'),
('Religione'),
('Scienze'),
('Storia'),
('Tedesco');

-- --------------------------------------------------------

--
-- Struttura della tabella `palestra`
--

CREATE TABLE `palestra` (
  `Nome` varchar(30) NOT NULL,
  `Tipo` varchar(10) DEFAULT NULL CHECK (`Tipo` in ('Esterna','Interna'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `palestra`
--

INSERT INTO `palestra` (`Nome`, `Tipo`) VALUES
('Palestra Bellini', 'Interna'),
('Palestra Paolini', 'Esterna');

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `persone_db`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `persone_db` (
`cf` varchar(16)
,`nome` varchar(30)
,`cognome` varchar(30)
,`id_scuola` int(11)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `scuola`
--

CREATE TABLE `scuola` (
  `Id` int(11) NOT NULL,
  `Nome` varchar(30) DEFAULT NULL,
  `Via` varchar(50) DEFAULT NULL,
  `Citta` varchar(30) DEFAULT NULL,
  `Grado` int(11) DEFAULT NULL,
  `Ordine` int(11) DEFAULT NULL,
  `N_impiegati_attuali` int(11) DEFAULT 0,
  `N_edifici` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `scuola`
--

INSERT INTO `scuola` (`Id`, `Nome`, `Via`, `Citta`, `Grado`, `Ordine`, `N_impiegati_attuali`, `N_edifici`) VALUES
(1, 'Liceo statale Paolini', 'Via Umberto Scilla 23', 'Bologna', 2, 2, 5, 4),
(2, 'Scuola Media Bellini', 'Via Unita di Italia 5', 'Caserta', 2, 1, 4, 1),
(3, 'Scuola Elementare Galilei', 'Via dei portici', 'Vicenza', 1, 1, 6, 1);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `scuola_dettagli`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `scuola_dettagli` (
`id` int(11)
,`nome` varchar(30)
,`via` varchar(50)
,`citta` varchar(30)
,`anno` int(11)
,`id_classe` int(11)
,`corso` varchar(1)
,`indirizzo` varchar(20)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `sdl_dettagli`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `sdl_dettagli` (
`cf` varchar(16)
,`nome` varchar(30)
,`cognome` varchar(30)
,`eta` int(11)
,`stipendio` float
,`tipo` varchar(20)
,`id_scuola` int(11)
,`nome_scuola` varchar(30)
,`data_assunzione` date
);

-- --------------------------------------------------------

--
-- Struttura della tabella `sede_di_lavoro`
--

CREATE TABLE `sede_di_lavoro` (
  `Id_scuola` int(11) NOT NULL,
  `Cf_Impiegato` varchar(16) NOT NULL,
  `Data_Assunzione` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `sede_di_lavoro`
--

INSERT INTO `sede_di_lavoro` (`Id_scuola`, `Cf_Impiegato`, `Data_Assunzione`) VALUES
(1, 'Cod102', '2018-04-23'),
(1, 'Cod104', '2019-11-01'),
(1, 'Cod110', '2019-02-14'),
(1, 'Cod111', '2019-02-05'),
(1, 'Cod114', '2019-05-02'),
(2, 'Cod103', '2019-02-03'),
(2, 'Cod105', '2018-09-13'),
(2, 'Cod109', '2020-06-01'),
(2, 'cod115', '2017-09-21'),
(3, 'Cod100', '2018-01-30'),
(3, 'Cod101', '2019-01-15'),
(3, 'Cod107', '2020-01-10'),
(3, 'Cod108', '2018-07-15'),
(3, 'Cod112', '2020-01-20'),
(3, 'Cod113', '2018-05-11');

--
-- Trigger `sede_di_lavoro`
--
DELIMITER $$
CREATE TRIGGER `calcolaimp` AFTER INSERT ON `sede_di_lavoro` FOR EACH ROW begin
update scuola
set n_impiegati_attuali=n_impiegati_attuali+1
where id=new.id_scuola;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `calcolaimp_delete` AFTER DELETE ON `sede_di_lavoro` FOR EACH ROW begin
update scuola
set n_impiegati_attuali=n_impiegati_attuali-1
where id=old.id_scuola;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `valutazione`
--

CREATE TABLE `valutazione` (
  `Codice` int(11) NOT NULL,
  `Cf_Alunno` varchar(16) DEFAULT NULL,
  `Cf_Insegnante` varchar(16) DEFAULT NULL,
  `NomeMateria` varchar(20) DEFAULT NULL,
  `Voto` float DEFAULT NULL,
  `Data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `valutazione`
--

INSERT INTO `valutazione` (`Codice`, `Cf_Alunno`, `Cf_Insegnante`, `NomeMateria`, `Voto`, `Data`) VALUES
(1, 'cod2', 'cod100', 'Italiano', 6.5, '2020-02-12'),
(2, 'cod6', 'cod101', 'Matematica', 6.5, '2020-02-12'),
(3, 'cod6', 'cod102', 'Italiano', 7, '2020-01-23'),
(4, 'cod2', 'cod100', 'Italiano', 8.5, '2020-01-23'),
(5, 'cod5', 'cod115', 'Arte', 5, '2020-03-12'),
(6, 'cod2', 'cod103', 'Geometria', 10, '2020-03-02'),
(7, 'cod10', 'cod111', 'Filosofia', 9.5, '2020-01-29'),
(8, 'cod10', 'cod112', 'Educazione Fisica', 7.5, '2020-01-29'),
(9, 'cod12', 'cod102', 'Italiano', 8, '2020-02-01'),
(10, 'cod8', 'cod113', 'Arte', 6.5, '2020-03-12'),
(11, 'cod9', 'cod113', 'Arte', 5.5, '2020-03-12'),
(13, 'Cod4', 'Cod100', 'Storia', 7, '2021-05-16');

--
-- Trigger `valutazione`
--
DELIMITER $$
CREATE TRIGGER `verificavalutazione` BEFORE INSERT ON `valutazione` FOR EACH ROW begin
if not exists(select id 
              from classe 
  where id in (select d.id_classe 
                           from docenza d join alunno a on d.id_classe=a.id_classe 
                           where a.cf=new.cf_alunno and d.cf_insegnante=new.cf_insegnante)) then
signal sqlstate '45000' set message_text="L'alunno o il professore non sono nella stessa classe";
end if;
if not exists(select d.cf_insegnante from docenza d where d.cf_insegnante=new.cf_insegnante and d.nomemateria=new.nomemateria) then 
signal sqlstate '45000' set message_text="L'insegnante non ha la docenza di quella materia";
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `valutazione_dettagli`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `valutazione_dettagli` (
`codice` int(11)
,`cf_alunno` varchar(16)
,`nome_alunno` varchar(30)
,`cognome_alunno` varchar(30)
,`cf_insegnante` varchar(16)
,`nome_insegnante` varchar(30)
,`cognome_insegnante` varchar(30)
,`nomemateria` varchar(20)
,`voto` float
,`data` date
);

-- --------------------------------------------------------

--
-- Struttura per vista `alunni_dettagli`
--
DROP TABLE IF EXISTS `alunni_dettagli`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `alunni_dettagli`  AS SELECT `a`.`Cf` AS `cf`, `a`.`Nome` AS `nome`, `a`.`Cognome` AS `cognome`, `a`.`Eta` AS `eta`, `s`.`Id` AS `id_scuola`, `s`.`Nome` AS `scuola`, `c`.`Id` AS `id_classe`, `c`.`Indirizzo` AS `indirizzo`, `c`.`Anno` AS `anno`, `c`.`Corso` AS `corso` FROM (((`alunno` `a` join `classe` `c` on(`a`.`id_classe` = `c`.`Id`)) join `edificio` `e` on(`c`.`Nome_edificio` = `e`.`Nome`)) join `scuola` `s` on(`e`.`Id_scuola` = `s`.`Id`)) ORDER BY `s`.`Nome` ASC, `c`.`Anno` ASC, `c`.`Corso` ASC, `a`.`Cognome` ASC ;

-- --------------------------------------------------------

--
-- Struttura per vista `alunni_per_docente`
--
DROP TABLE IF EXISTS `alunni_per_docente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `alunni_per_docente`  AS SELECT `d`.`Cf_Insegnante` AS `cf_insegnante`, count(distinct `a`.`Cf`) AS `n_alunni_docente` FROM (`docenza` `d` join `alunno` `a` on(`d`.`Id_classe` = `a`.`id_classe`)) GROUP BY `d`.`Cf_Insegnante` ;

-- --------------------------------------------------------

--
-- Struttura per vista `classe_dettagli`
--
DROP TABLE IF EXISTS `classe_dettagli`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `classe_dettagli`  AS SELECT `c`.`Id` AS `id_classe`, `c`.`Anno` AS `anno`, `c`.`Corso` AS `corso`, `c`.`Indirizzo` AS `indirizzo`, `a`.`Cf` AS `cf`, `a`.`Nome` AS `nome`, `a`.`Cognome` AS `cognome`, `a`.`Eta` AS `eta` FROM (`alunno` `a` join `classe` `c` on(`a`.`id_classe` = `c`.`Id`)) ;

-- --------------------------------------------------------

--
-- Struttura per vista `docente_classi`
--
DROP TABLE IF EXISTS `docente_classi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `docente_classi`  AS SELECT `d`.`Cf_Insegnante` AS `cf_insegnante`, `s`.`nome` AS `scuola`, `s`.`id_classe` AS `id_classe`, `s`.`anno` AS `anno`, `s`.`corso` AS `corso`, `s`.`indirizzo` AS `indirizzo` FROM (`scuola_dettagli` `s` join `docenza` `d` on(`s`.`id_classe` = `d`.`Id_classe`)) ;

-- --------------------------------------------------------

--
-- Struttura per vista `docenti_classe`
--
DROP TABLE IF EXISTS `docenti_classe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `docenti_classe`  AS SELECT `i`.`Nome` AS `nome`, `i`.`Cognome` AS `cognome`, `i`.`Nascita` AS `nascita`, `i`.`Eta` AS `eta`, `d`.`NomeMateria` AS `nomemateria`, `c`.`Id` AS `id`, `c`.`Anno` AS `anno`, `c`.`Corso` AS `corso`, `c`.`Indirizzo` AS `indirizzo` FROM ((`impiegato` `i` join `docenza` `d` on(`i`.`Cf` = `d`.`Cf_Insegnante`)) join `classe` `c` on(`d`.`Id_classe` = `c`.`Id`)) WHERE `i`.`Tipo` = 'Insegnante' ;

-- --------------------------------------------------------

--
-- Struttura per vista `docenza_dettagli`
--
DROP TABLE IF EXISTS `docenza_dettagli`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `docenza_dettagli`  AS SELECT `i`.`Nome` AS `nome`, `i`.`Cognome` AS `cognome`, `d`.`NomeMateria` AS `nomemateria`, `c`.`Anno` AS `anno`, `c`.`Corso` AS `corso`, `c`.`Indirizzo` AS `indirizzo`, `s`.`Nome` AS `nome_scuola`, `apd`.`n_alunni_docente` AS `n_alunni_docente` FROM (((((`impiegato` `i` join `docenza` `d` on(`i`.`Cf` = `d`.`Cf_Insegnante`)) join `classe` `c` on(`d`.`Id_classe` = `c`.`Id`)) join `edificio` `e` on(`c`.`Nome_edificio` = `e`.`Nome`)) join `scuola` `s` on(`e`.`Id_scuola` = `s`.`Id`)) join `alunni_per_docente` `apd` on(`d`.`Cf_Insegnante` = `apd`.`cf_insegnante`)) ;

-- --------------------------------------------------------

--
-- Struttura per vista `esdl_dettagli`
--
DROP TABLE IF EXISTS `esdl_dettagli`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `esdl_dettagli`  AS SELECT `i`.`Cf` AS `cf`, `i`.`Nome` AS `nome`, `i`.`Cognome` AS `cognome`, `i`.`Eta` AS `eta`, `esl`.`tipo` AS `tipo`, `s`.`Nome` AS `nome_scuola`, `esl`.`Data_Assunzione` AS `data_assunzione`, `esl`.`Data_fine_impiego` AS `data_fine_impiego` FROM ((`impiegato` `i` join `ex_sede_di_lavoro` `esl` on(`i`.`Cf` = `esl`.`Cf_Impiegato`)) join `scuola` `s` on(`esl`.`id_scuola` = `s`.`Id`)) ;

-- --------------------------------------------------------

--
-- Struttura per vista `persone_db`
--
DROP TABLE IF EXISTS `persone_db`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `persone_db`  AS SELECT `alunno`.`Cf` AS `cf`, `alunno`.`Nome` AS `nome`, `alunno`.`Cognome` AS `cognome`, `alunno`.`id_scuola` AS `id_scuola` FROM `alunno` ;

-- --------------------------------------------------------

--
-- Struttura per vista `scuola_dettagli`
--
DROP TABLE IF EXISTS `scuola_dettagli`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `scuola_dettagli`  AS SELECT `s`.`Id` AS `id`, `s`.`Nome` AS `nome`, `s`.`Via` AS `via`, `s`.`Citta` AS `citta`, `c`.`Anno` AS `anno`, `c`.`Id` AS `id_classe`, `c`.`Corso` AS `corso`, `c`.`Indirizzo` AS `indirizzo` FROM ((`scuola` `s` join `edificio` `e` on(`e`.`Id_scuola` = `s`.`Id`)) join `classe` `c` on(`c`.`Nome_edificio` = `e`.`Nome`)) ;

-- --------------------------------------------------------

--
-- Struttura per vista `sdl_dettagli`
--
DROP TABLE IF EXISTS `sdl_dettagli`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sdl_dettagli`  AS SELECT `i`.`Cf` AS `cf`, `i`.`Nome` AS `nome`, `i`.`Cognome` AS `cognome`, `i`.`Eta` AS `eta`, `i`.`Stipendio` AS `stipendio`, `i`.`Tipo` AS `tipo`, `s`.`Id` AS `id_scuola`, `s`.`Nome` AS `nome_scuola`, `sl`.`Data_Assunzione` AS `data_assunzione` FROM ((`impiegato` `i` join `sede_di_lavoro` `sl` on(`i`.`Cf` = `sl`.`Cf_Impiegato`)) join `scuola` `s` on(`sl`.`Id_scuola` = `s`.`Id`)) ;

-- --------------------------------------------------------

--
-- Struttura per vista `valutazione_dettagli`
--
DROP TABLE IF EXISTS `valutazione_dettagli`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `valutazione_dettagli`  AS SELECT `v`.`Codice` AS `codice`, `a`.`Cf` AS `cf_alunno`, `a`.`Nome` AS `nome_alunno`, `a`.`Cognome` AS `cognome_alunno`, `i`.`Cf` AS `cf_insegnante`, `i`.`Nome` AS `nome_insegnante`, `i`.`Cognome` AS `cognome_insegnante`, `v`.`NomeMateria` AS `nomemateria`, `v`.`Voto` AS `voto`, `v`.`Data` AS `data` FROM ((`valutazione` `v` join `alunno` `a` on(`a`.`Cf` = `v`.`Cf_Alunno`)) join `impiegato` `i` on(`v`.`Cf_Insegnante` = `i`.`Cf`)) WHERE `i`.`Tipo` = 'Insegnante' ;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`Cf`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- Indici per le tabelle `alunno`
--
ALTER TABLE `alunno`
  ADD PRIMARY KEY (`Cf`),
  ADD KEY `idx_idsc` (`id_scuola`),
  ADD KEY `idx_idcl` (`id_classe`);

--
-- Indici per le tabelle `classe`
--
ALTER TABLE `classe`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Anno` (`Anno`,`Corso`,`Indirizzo`,`Nome_edificio`),
  ADD KEY `idx_ne` (`Nome_edificio`);

--
-- Indici per le tabelle `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `docenza`
--
ALTER TABLE `docenza`
  ADD PRIMARY KEY (`Cf_Insegnante`,`NomeMateria`,`Id_classe`),
  ADD KEY `idx_CfIm` (`Cf_Insegnante`),
  ADD KEY `idx_NM` (`NomeMateria`),
  ADD KEY `idx_idcl` (`Id_classe`);

--
-- Indici per le tabelle `edificio`
--
ALTER TABLE `edificio`
  ADD PRIMARY KEY (`Nome`),
  ADD KEY `idx_idsc` (`Id_scuola`);

--
-- Indici per le tabelle `ex_sede_di_lavoro`
--
ALTER TABLE `ex_sede_di_lavoro`
  ADD PRIMARY KEY (`id_scuola`,`Cf_Impiegato`),
  ADD KEY `idx_idsc` (`id_scuola`),
  ADD KEY `idx_CfIm` (`Cf_Impiegato`);

--
-- Indici per le tabelle `impiegato`
--
ALTER TABLE `impiegato`
  ADD PRIMARY KEY (`Cf`);

--
-- Indici per le tabelle `incorpora`
--
ALTER TABLE `incorpora`
  ADD PRIMARY KEY (`Nome_Palestra`),
  ADD KEY `idx_NP` (`Nome_Palestra`),
  ADD KEY `idx_NE` (`Nome_Edificio`);

--
-- Indici per le tabelle `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`Nome`);

--
-- Indici per le tabelle `palestra`
--
ALTER TABLE `palestra`
  ADD PRIMARY KEY (`Nome`);

--
-- Indici per le tabelle `scuola`
--
ALTER TABLE `scuola`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Nome` (`Nome`,`Via`,`Citta`);

--
-- Indici per le tabelle `sede_di_lavoro`
--
ALTER TABLE `sede_di_lavoro`
  ADD PRIMARY KEY (`Id_scuola`,`Cf_Impiegato`),
  ADD KEY `idx_idsc` (`Id_scuola`),
  ADD KEY `idx_CfIm` (`Cf_Impiegato`);

--
-- Indici per le tabelle `valutazione`
--
ALTER TABLE `valutazione`
  ADD PRIMARY KEY (`Codice`),
  ADD KEY `idx_CfAl` (`Cf_Alunno`),
  ADD KEY `CfIn` (`Cf_Insegnante`),
  ADD KEY `idx_NM` (`NomeMateria`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `content`
--
ALTER TABLE `content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `valutazione`
--
ALTER TABLE `valutazione`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `alunno`
--
ALTER TABLE `alunno`
  ADD CONSTRAINT `alunno_ibfk_1` FOREIGN KEY (`id_scuola`) REFERENCES `scuola` (`Id`),
  ADD CONSTRAINT `alunno_ibfk_2` FOREIGN KEY (`id_classe`) REFERENCES `classe` (`Id`);

--
-- Limiti per la tabella `classe`
--
ALTER TABLE `classe`
  ADD CONSTRAINT `classe_ibfk_1` FOREIGN KEY (`Nome_edificio`) REFERENCES `edificio` (`Nome`);

--
-- Limiti per la tabella `docenza`
--
ALTER TABLE `docenza`
  ADD CONSTRAINT `docenza_ibfk_1` FOREIGN KEY (`Cf_Insegnante`) REFERENCES `impiegato` (`Cf`),
  ADD CONSTRAINT `docenza_ibfk_2` FOREIGN KEY (`NomeMateria`) REFERENCES `materia` (`Nome`),
  ADD CONSTRAINT `docenza_ibfk_3` FOREIGN KEY (`Id_classe`) REFERENCES `classe` (`Id`);

--
-- Limiti per la tabella `edificio`
--
ALTER TABLE `edificio`
  ADD CONSTRAINT `edificio_ibfk_1` FOREIGN KEY (`Id_scuola`) REFERENCES `scuola` (`Id`);

--
-- Limiti per la tabella `ex_sede_di_lavoro`
--
ALTER TABLE `ex_sede_di_lavoro`
  ADD CONSTRAINT `ex_sede_di_lavoro_ibfk_1` FOREIGN KEY (`id_scuola`) REFERENCES `scuola` (`Id`),
  ADD CONSTRAINT `ex_sede_di_lavoro_ibfk_2` FOREIGN KEY (`Cf_Impiegato`) REFERENCES `impiegato` (`Cf`);

--
-- Limiti per la tabella `incorpora`
--
ALTER TABLE `incorpora`
  ADD CONSTRAINT `incorpora_ibfk_1` FOREIGN KEY (`Nome_Palestra`) REFERENCES `palestra` (`Nome`),
  ADD CONSTRAINT `incorpora_ibfk_2` FOREIGN KEY (`Nome_Edificio`) REFERENCES `edificio` (`Nome`);

--
-- Limiti per la tabella `sede_di_lavoro`
--
ALTER TABLE `sede_di_lavoro`
  ADD CONSTRAINT `sede_di_lavoro_ibfk_1` FOREIGN KEY (`Id_scuola`) REFERENCES `scuola` (`Id`),
  ADD CONSTRAINT `sede_di_lavoro_ibfk_2` FOREIGN KEY (`Cf_Impiegato`) REFERENCES `impiegato` (`Cf`);

--
-- Limiti per la tabella `valutazione`
--
ALTER TABLE `valutazione`
  ADD CONSTRAINT `valutazione_ibfk_1` FOREIGN KEY (`Cf_Alunno`) REFERENCES `alunno` (`Cf`),
  ADD CONSTRAINT `valutazione_ibfk_2` FOREIGN KEY (`Cf_Insegnante`) REFERENCES `impiegato` (`Cf`),
  ADD CONSTRAINT `valutazione_ibfk_3` FOREIGN KEY (`NomeMateria`) REFERENCES `materia` (`Nome`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
