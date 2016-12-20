CREATE TABLE `lab3lib_books` (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`book` varchar(255) NOT NULL,
	`author` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `lab3lib_cart` (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`cart_id` int(10) NOT NULL,
	`book_id` int(10) NOT NULL,
	`status` int(10) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`)
);

CREATE TABLE `lab3lib_extradition` (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`reader_id` int(10) NOT NULL,
	`cart_id` int(10) NOT NULL,
	`librarier_id` int(10) NOT NULL,
	`issued_date` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `lab3lib_librariers` (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`surname` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `lab3lib_readers` (
	`id` int(10) NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`surname` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `lab3lib_cart` ADD CONSTRAINT `lab3lib_cart_fk0` FOREIGN KEY (`book_id`) REFERENCES `lab3lib_books`(`id`) ON DELETE CASCADE;

ALTER TABLE `lab3lib_extradition` ADD CONSTRAINT `lab3lib_extradition_fk0` FOREIGN KEY (`reader_id`) REFERENCES `lab3lib_readers`(`id`) ON DELETE CASCADE;

ALTER TABLE `lab3lib_extradition` ADD CONSTRAINT `lab3lib_extradition_fk1` FOREIGN KEY (`cart_id`) REFERENCES `lab3lib_cart`(`cart_id`) ON DELETE CASCADE;

ALTER TABLE `lab3lib_extradition` ADD CONSTRAINT `lab3lib_extradition_fk2` FOREIGN KEY (`librarier_id`) REFERENCES `lab3lib_librariers`(`id`) ON DELETE CASCADE;
