--
-- База данных: `lab2Library`
--
CREATE DATABASE IF NOT EXISTS `lab2Library` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `lab2Library`;

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE IF NOT EXISTS `books` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `book` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`id`, `book`, `author`) VALUES
(1, 'Book1', 'Author1'),
(2, 'Book2', 'Author2'),
(3, 'Book3', 'Author3'),
(4, 'Book4', 'Author4');

--
-- Триггеры `books`
--
DROP TRIGGER IF EXISTS `delFromCartByBook`;
DELIMITER //
CREATE TRIGGER `delFromCartByBook` BEFORE DELETE ON `books`
 FOR EACH ROW delete from `cart` where `cart`.`book_id` = old.`id`
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `cart`
--

CREATE TABLE IF NOT EXISTS `cart` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cart_id` int(10) NOT NULL,
  `book_id` int(10) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cart_fk0` (`book_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `cart`
--

INSERT INTO `cart` (`id`, `cart_id`, `book_id`, `status`) VALUES
(1, 1, 4, '1'),
(2, 1, 2, '0'),
(3, 2, 1, '0');

--
-- Триггеры `cart`
--
DROP TRIGGER IF EXISTS `delFromExtraditionByCart`;
DELIMITER //
CREATE TRIGGER `delFromExtraditionByCart` BEFORE DELETE ON `cart`
 FOR EACH ROW delete from `extradition` where `extradition`.`cart_id` = old.`cart_id`
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `extradition`
--

CREATE TABLE IF NOT EXISTS `extradition` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `reader_id` int(10) NOT NULL,
  `cart_id` int(10) NOT NULL,
  `librarier_id` int(10) NOT NULL,
  `issued_date` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `extradition_fk0` (`reader_id`),
  KEY `extradition_fk1` (`cart_id`),
  KEY `extradition_fk2` (`librarier_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `extradition`
--

INSERT INTO `extradition` (`id`, `reader_id`, `cart_id`, `librarier_id`, `issued_date`) VALUES
(1, 1, 1, 1, '5.07.2016'),
(2, 2, 2, 2, '11.12.2016');

-- --------------------------------------------------------

--
-- Структура таблицы `librariers`
--

CREATE TABLE IF NOT EXISTS `librariers` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `librariers`
--

INSERT INTO `librariers` (`id`, `name`, `surname`) VALUES
(1, 'librarier1', 'Surname1'),
(2, 'librarier2', 'Surname2'),
(3, 'librarier3', 'Surname3');

--
-- Триггеры `librariers`
--
DROP TRIGGER IF EXISTS `delFromExtraditionByLibrarier`;
DELIMITER //
CREATE TRIGGER `delFromExtraditionByLibrarier` BEFORE DELETE ON `librariers`
 FOR EACH ROW delete from `extradition` where `extradition`.`librarier_id` = old.`id`
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `readers`
--

CREATE TABLE IF NOT EXISTS `readers` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `readers`
--

INSERT INTO `readers` (`id`, `name`, `surname`) VALUES
(1, 'reader1', 'Surname1'),
(2, 'reader2', 'Surname2'),
(3, 'reader3', 'Surname3');

--
-- Триггеры `readers`
--
DROP TRIGGER IF EXISTS `delFromExtraditionByReader`;
DELIMITER //
CREATE TRIGGER `delFromExtraditionByReader` BEFORE DELETE ON `readers`
 FOR EACH ROW delete from `extradition` where `extradition`.`reader_id` = old.`id`
//
DELIMITER ;
