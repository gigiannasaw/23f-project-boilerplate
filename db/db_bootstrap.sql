-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
CREATE DATABASE CafeConnect;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on CafeConnect.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
USE CafeConnect;

-- Put your DDL 

CREATE TABLE IF NOT EXISTS BusinessOwner (
    owner_id int AUTO_INCREMENT PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL
);

CREATE TABLE IF NOT EXISTS Cafe (
    owner_id int NOT NULL,
    time text NOT NULL,
    days text NOT NULL,
    website_link text,
    cafe_id int PRIMARY KEY AUTO_INCREMENT,
    name text NOT NULL,
    street text NOT NULL,
    city text NOT NULL,
    zip int NOT NULL,
    state text NOT NULL,
    has_wifi boolean,
    has_outlets boolean,
    FOREIGN KEY (owner_id) REFERENCES BusinessOwner(owner_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Customer (
    customer_id int AUTO_INCREMENT PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    `rank` int NOT NULL
);

CREATE TABLE IF NOT EXISTS Ratings (
    service_speed int,
    price int,
    noise int,
    options text,
    rating_id int AUTO_INCREMENT NOT NULL,
    customer_id int NOT NULL,
    cafe_id int NOT NULL,
    PRIMARY KEY(rating_id, cafe_id, customer_id),
    FOREIGN KEY (cafe_id) REFERENCES Cafe(cafe_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Student (
    customer_id int PRIMARY KEY,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Critic (
    customer_id int PRIMARY KEY,
    user_status text NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS DailyDrinker (
    customer_id int PRIMARY KEY,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Promotion (
    cafe_id int NOT NULL,
    promo_id int NOT NULL,
    description text NOT NULL,
    title text,
    duration int,
    PRIMARY KEY (cafe_id, promo_id),
    FOREIGN KEY (cafe_id) REFERENCES Cafe(cafe_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Reviews (
    customer_id int NOT NULL,
    cafe_id int,
    review_id int NOT NULL,
    content text,
    PRIMARY KEY (customer_id, review_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cafe_id) REFERENCES Cafe(cafe_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Invite (
    invite_id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
    customer_id int NOT NULL,
    description text NOT NULL,
    cafe_id int NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cafe_id) REFERENCES Cafe(cafe_id) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Add sample data.
INSERT INTO BusinessOwner (owner_id, first_name, last_name)
VALUES
	('1', 'Katerine', 'Duprey'),
	('2', 'Frazier', 'Dallmann'),
	('3', 'Ruthie', 'Grouen'),
	('4', 'Hugues', 'Klesse'),
	('5', 'Phineas', 'Faraday'),
	('6', 'Pryce', 'Meeks'),
	('7', 'Elwin', 'Baiden'),
	('8', 'Cass', 'Gamil'),
	('9', 'Levey', 'Walworth'),
	('10', 'Carlita', 'Freen'),
	('11', 'Karyl', 'Bruinsma'),
	('12', 'Angelica', 'Jupp'),
	('13', 'Shandie', 'Coppenhall'),
	('14', 'Margeaux', 'Mabon'),
	('15', 'Hans', 'Yashin'),
	('16', 'Merci', 'Guage'),
	('17', 'Eliza', 'Treher'),
	('18', 'Leanor', 'Bexon'),
	('19', 'Gabbey', 'Andrus'),
	('20', 'Skyler', 'Rumble'),
	('21', 'Ramon', 'Ravillas'),
	('22', 'Kinna', 'Attack'),
	('23', 'Leonard', 'Junkison'),
	('24', 'Del', 'Twatt'),
	('25', 'Rubie', 'de Bullion'),
	('26', 'Fiann', 'Reavell'),
	('27', 'Conant', 'Blodg'),
	('28', 'Dorey', 'Raoux'),
	('29', 'Bobinette', 'Skinley'),
	('30', 'Cobbie', 'Phuprate'),
	('31', 'Annalise', 'Kirman'),
	('32', 'Devlen', 'Mougenel'),
	('33', 'Lelia', 'Palatini'),
	('34', 'Tina', 'Casajuana'),
	('35', 'Tamas', 'Wardroper'),
	('36', 'Yvette', 'Froom'),
	('37', 'Skip', 'Staples'),
	('38', 'Aurora', 'Varney'),
	('39', 'Alexio', 'Luca'),
	('40', 'Luce', 'Twomey');

INSERT INTO Cafe (cafe_id, owner_id, name, time, days, website_link, street, city, zip, state, has_wifi, has_outlets) VALUES
	('1', '29', 'Caffe Vittoria', '9AM-8PM', 'Monday-Saturday', 'www.caffevittoria.com', 'Boylston Street', 'Boston', '02467', 'Massachusetts', '1', '0'),
	('2', '8', 'Barrington Coffee Roasting Company', '11AM-10PM', 'Monday-Sunday', 'www.barringtoncoffeeroastingcompany.com', 'Beacon Street', 'Boston', '02467', 'Massachusetts', '1', '0'),
	('3', '15', 'Thinking Cup', '7AM-4PM', 'Monday-Sunday (closed every first Sunday of the month)', 'www.thinkingcup.com', 'Boylston Street', 'Boston', '02467', 'Massachusetts', '0', '0'),
	('4', '28', 'Thinking Cup', '8AM-7PM', 'Monday-Friday', 'www.thinkingcup.com', 'Beacon Street', 'Boston', '02128', 'Massachusetts', '1', '0'),
	('5', '22', 'Caffe Paradiso', '8AM-8PM', 'Monday-Saturday', 'www.caffeparadiso.com', 'Commonwealth Avenue', 'Boston', '02203', 'Massachusetts', '0', '1'),
	('6', '10', 'Tatte Bakery & Cafe', '7AM-4PM', 'Monday-Sunday (closed every first Sunday of the month)', 'www.tattebakery&cafe.com', 'Beacon Street', 'Boston', '02215', 'Massachusetts', '0', '0'),
	('7', '40', 'Caffe Vittoria', '10AM-7PM', 'Monday-Thursday (and weekends)', 'www.caffevittoria.com', 'Beacon Street', 'Boston', '02467', 'Massachusetts', '1', '0'),
	('8', '40', 'Jaho Coffee Roaster & Wine Bar Boston', '10AM-4PM', 'Monday-Thursday (and weekends)', 'www.jahocoffeeroaster&winebarboston.com', 'Commonwealth Avenue', 'Boston', '02467', 'Massachusetts', '0', '1'),
	('9', '8', 'Voltage Coffee & Art', '11AM-7PM', 'Monday-Sunday (closed every first Sunday of the month)', 'www.voltagecoffee&art.com', 'Boylston Street', 'Boston', '02467', 'Massachusetts', '0', '1'),
	('10', '5', 'Gracenote Coffee', '10AM-7PM', 'Monday-Saturday', 'www.gracenotecoffee.com', 'Commonwealth Avenue', 'Boston', '02131', 'Massachusetts', '0', '1'),
	('11', '3', 'Blue Bottle Coffee', '11AM-7PM', 'Monday-Sunday', 'www.bluebottlecoffee.com', 'Commonwealth Avenue', 'Boston', '02215', 'Massachusetts', '1', '1'),
	('12', '6', '3 Little Figs', '7AM-8PM', 'Monday-Friday', 'www.3littlefigs.com', 'Beacon Street', 'Boston', '02467', 'Massachusetts', '0', '0'),
	('13', '4', 'Barrington Coffee Roasting Company', '9AM-6PM', 'Monday-Sunday', 'www.barringtoncoffeeroastingcompany.com', 'Boylston Street', 'Boston', '02203', 'Massachusetts', '0', '0'),
	('14', '10', 'Dunkin', '7AM-9PM', 'Monday-Sunday', 'www.dunkin.com', 'Charles Street', 'Boston', '02467', 'Massachusetts', '1', '1'),
	('15', '23', 'Capital One Cafe', '9AM-5PM', 'Monday-Friday', 'www.capitalonecafe.com', 'Beacon Street', 'Boston', '02120', 'Massachusetts', '0', '0'),
	('16', '34', 'Dunkin', '11AM-4PM', 'Monday-Sunday (closed every first Sunday of the month)', 'www.dunkin.com', 'Beacon Street', 'Boston', '02467', 'Massachusetts', '0', '1'),
	('17', '35', 'Jaho Coffee Roaster & Wine Bar Boston', '9AM-6PM', 'Monday-Saturday', 'www.jahocoffeeroaster&winebarboston.com', 'Newbury Street', 'Boston', '02129', 'Massachusetts', '0', '1'),
	('18', '38', 'Refuge Cafe', '7AM-5PM', 'Monday-Thursday (and weekends)', 'www.refugecafe.com', 'Charles Street', 'Boston', '02203', 'Massachusetts', '1', '1'),
	('19', '30', 'George Howell Coffee', '7AM-7PM', 'Monday-Saturday', 'www.georgehowellcoffee.com', 'Commonwealth Avenue', 'Boston', '02120', 'Massachusetts', '0', '1'),
	('20', '23', 'Espresso Yourself', '11AM-10PM', 'Monday-Saturday', 'www.espressoyourself.com', 'Commonwealth Avenue', 'Boston', '02128', 'Massachusetts', '1', '0'),
	('21', '32', 'Ogawa Coffee', '11AM-10PM', 'Monday-Saturday', 'www.ogawacoffee.com', 'Charles Street', 'Boston', '02203', 'Massachusetts', '1', '1'),
	('22', '33', 'Trident Booksellers & Cafe', '11AM-5PM', 'Monday-Saturday', 'www.tridentbooksellers&cafe.com', 'Commonwealth Avenue', 'Boston', '02151', 'Massachusetts', '0', '1'),
	('23', '9', 'George Howell Coffee', '10AM-9PM', 'Monday-Sunday', 'www.georgehowellcoffee.com', 'Newbury Street', 'Boston', '02122', 'Massachusetts', '0', '1'),
	('24', '16', 'Caffe dello Sport', '11AM-7PM', 'Monday-Sunday', 'www.caffedellosport.com', 'Beacon Street', 'Boston', '02467', 'Massachusetts', '0', '0'),
	('25', '17', 'Caffe dello Sport', '9AM-7PM', 'Monday-Friday', 'www.caffedellosport.com', 'Charles Street', 'Boston', '02215', 'Massachusetts', '0', '1'),
	('26', '7', 'Flour Bakery + Cafe', '9AM-6PM', 'Monday-Saturday', 'www.flourbakery+cafe.com', 'Beacon Street', 'Boston', '02467', 'Massachusetts', '1', '1'),
	('27', '33', 'Farmer''s Horse Coffee', '11AM-6PM', 'Monday-Friday', 'www.farmershorsecoffee.com', 'Newbury Street', 'Boston', '02467', 'Massachusetts', '0', '0'),
	('28', '23', 'Pavement Coffeehouse', '10AM-9PM', 'Monday-Friday', 'www.pavementcoffeehouse.com', 'Commonwealth Avenue', 'Boston', '02151', 'Massachusetts', '0', '0'),
	('29', '27', 'Caffe dello Sport', '11AM-6PM', 'Monday-Sunday', 'www.caffedellosport.com', 'Commonwealth Avenue', 'Boston', '02467', 'Massachusetts', '1', '0'),
	('30', '24', 'Starbucks', '11AM-7PM', 'Monday-Saturday', 'www.starbucks.com', 'Charles Street', 'Boston', '02467', 'Massachusetts', '0', '0'),
	('31', '5', '3 Little Figs', '7AM-10PM', 'Monday-Thursday (and weekends)', 'www.3littlefigs.com', 'Commonwealth Avenue', 'Boston', '02215', 'Massachusetts', '1', '1'),
	('32', '4', 'Espresso Yourself', '9AM-8PM', 'Monday-Sunday', 'www.espressoyourself.com', 'Commonwealth Avenue', 'Boston', '02127', 'Massachusetts', '1', '0'),
	('33', '27', 'Capital One Cafe', '11AM-6PM', 'Monday-Friday', 'www.capitalonecafe.com', 'Newbury Street', 'Boston', '02128', 'Massachusetts', '0', '0'),
	('34', '26', 'Crema Cafe', '9AM-8PM', 'Monday-Saturday', 'www.cremacafe.com', 'Charles Street', 'Boston', '02467', 'Massachusetts', '0', '1'),
	('35', '28', 'Common Coffee Company', '8AM-8PM', 'Monday-Saturday', 'www.commoncoffeecompany.com', 'Newbury Street', 'Boston', '02467', 'Massachusetts', '0', '0'),
	('36', '9', 'Crema Cafe', '7AM-4PM', 'Monday-Saturday', 'www.cremacafe.com', 'Newbury Street', 'Boston', '02467', 'Massachusetts', '0', '0'),
	('37', '33', '1369 Coffee House', '11AM-10PM', 'Monday-Saturday', 'www.1369coffeehouse.com', 'Charles Street', 'Boston', '02122', 'Massachusetts', '0', '0'),
	('38', '24', 'Caffe Paradiso', '11AM-7PM', 'Monday-Thursday (and weekends)', 'www.caffeparadiso.com', 'Beacon Street', 'Boston', '02215', 'Massachusetts', '1', '0'),
	('39', '31', 'Capital One Cafe', '9AM-4PM', 'Monday-Thursday (and weekends)', 'www.capitalonecafe.com', 'Beacon Street', 'Boston', '02467', 'Massachusetts', '1', '1'),
	('40', '38', 'George Howell Coffee', '8AM-8PM', 'Monday-Thursday (and weekends)', 'www.georgehowellcoffee.com', 'Beacon Street', 'Boston', '02467', 'Massachusetts', '1', '1');

  INSERT INTO Customer (customer_id, first_name, last_name, `rank`) VALUES
	('1', 'Karoly', 'Elis', '3'),
	('2', 'Annis', 'Postans', '1'),
	('3', 'Violetta', 'Madgwick', '5'),
	('4', 'Devin', 'Brommage', '2'),
	('5', 'Yetta', 'Pellant', '4'),
	('6', 'Faber', 'Ivanuschka', '3'),
	('7', 'Lesley', 'Halms', '5'),
	('8', 'Dorice', 'Dallimore', '5'),
	('9', 'Woodrow', 'Goodsal', '3'),
	('10', 'Ewen', 'Guwer', '3'),
	('11', 'Norry', 'Wimbridge', '1'),
	('12', 'Corney', 'Dei', '4'),
	('13', 'Harman', 'Allan', '1'),
	('14', 'Louisa', 'Timmes', '5'),
	('15', 'Amil', 'Eckford', '5'),
	('16', 'Dewey', 'Lorenzetti', '4'),
	('17', 'Waneta', 'Cowle', '1'),
	('18', 'Brunhilda', 'McGiff', '3'),
	('19', 'Priscella', 'Ondrak', '3'),
	('20', 'Irving', 'Steedman', '5'),
	('21', 'Kial', 'Rankling', '1'),
	('22', 'Dolph', 'Custed', '4'),
	('23', 'Courtney', 'Aronowitz', '1'),
	('24', 'Letty', 'Dowda', '5'),
	('25', 'Foster', 'Pietrusiak', '5'),
	('26', 'Bonnibelle', 'Younghusband', '2'),
	('27', 'Rutledge', 'Woolfitt', '3'),
	('28', 'Linet', 'Toulmin', '4'),
	('29', 'Bronnie', 'Whiff', '2'),
	('30', 'Adrianne', 'Stoffel', '1'),
	('31', 'Quentin', 'Jirsa', '2'),
	('32', 'Jacintha', 'Depka', '4'),
	('33', 'Myrvyn', 'Wheowall', '3'),
	('34', 'Lem', 'Stuck', '3'),
	('35', 'Cirillo', 'Petriello', '5'),
	('36', 'Stanislaw', 'Nathan', '3'),
	('37', 'Ki', 'Stait', '5'),
	('38', 'Elvin', 'Gerin', '4'),
	('39', 'Moyra', 'De Simoni', '3'),
	('40', 'Carissa', 'Shoebottom', '1'),
	('41', 'Faythe', 'Roggerone', '3'),
	('42', 'Cheslie', 'Verecker', '2'),
	('43', 'Carolee', 'Fellenor', '2'),
	('44', 'Licha', 'Want', '3'),
	('45', 'Ludovika', 'Peiro', '5'),
	('46', 'Lucio', 'Macilhench', '4'),
	('47', 'Allistir', 'Dunlop', '1'),
	('48', 'Denyse', 'Jeanet', '3'),
	('49', 'Nolan', 'Macey', '2'),
	('50', 'Gregorio', 'Howgate', '2');


INSERT INTO Critic (customer_id, user_status) VALUES
	('1', 'Novice Critic'),
	('2', 'Expert Critic'),
	('3', 'Master Critic'),
	('4', 'Expert Critic'),
	('5', 'Novice Critic'),
	('6', 'Expert Critic'),
	('7', 'Novice Critic'),
	('8', 'Novice Critic'),
	('9', 'Master Critic'),
	('10', 'Master Critic');

  INSERT INTO DailyDrinker (customer_id) VALUES
	('11'),
	('12'),
	('13'),
	('14'),
	('15'),
	('16'),
	('17'),
	('18'),
	('19'),
	('20');

INSERT INTO Student (customer_id) VALUES
	('21'),
	('22'),
	('23'),
	('24'),
	('25'),
	('26'),
	('27'),
	('28'),
	('29'),
	('30'),
	('31'),
	('32'),
	('33'),
	('34'),
	('35'),
	('36'),
	('37'),
	('38'),
	('39'),
	('40');


  INSERT INTO Ratings (rating_id, service_speed, price, noise, options, customer_id, cafe_id) VALUES
	('1', '3', '2', '4', 'Clean', '16', '14'),
	('2', '5', '1', '5', 'Take-out available', '23', '1'),
	('3', '5', '1', '4', 'Dine-in available', '22', '17'),
	('4', '4', '4', '2', 'Pet-friendly', '9', '15'),
	('5', '3', '1', '4', 'Clean', '36', '12'),
	('6', '1', '1', '2', 'Pet-friendly', '23', '3'),
	('7', '2', '5', '1', 'Great ambience', '45', '34'),
	('8', '1', '1', '3', 'Dine-in available', '46', '7'),
	('9', '5', '4', '3', 'Dine-in available', '38', '34'),
	('10', '3', '4', '3', 'Great ambience', '7', '18'),
	('11', '1', '4', '2', 'Great ambience', '48', '37'),
	('12', '4', '2', '2', 'Dine-in available', '9', '25'),
	('13', '4', '1', '1', 'Pet-friendly', '33', '28'),
	('14', '2', '5', '5', 'Dine-in available', '48', '31'),
	('15', '4', '1', '2', 'Take-out available', '43', '37'),
	('16', '2', '2', '1', 'Great ambience', '3', '28'),
	('17', '3', '3', '2', 'Dine-in available', '48', '29'),
	('18', '2', '3', '2', 'Take-out available', '46', '40'),
	('19', '4', '4', '2', 'Dine-in available', '15', '26'),
	('20', '2', '4', '4', 'Great ambience', '6', '40'),
	('21', '4', '5', '5', 'Dine-in available', '2', '39'),
	('22', '4', '5', '2', 'Quick service', '3', '23'),
	('23', '3', '3', '2', 'Pet-friendly', '37', '12'),
	('24', '4', '5', '3', 'Dine-in available', '8', '4'),
	('25', '5', '2', '2', 'Clean', '30', '38'),
	('26', '5', '1', '1', 'Quick service', '42', '17'),
	('27', '5', '2', '5', 'Dine-in available', '2', '34'),
	('28', '4', '1', '1', 'Great ambience', '21', '16'),
	('29', '2', '4', '4', 'Quick service', '37', '37'),
	('30', '5', '1', '2', 'Quick service', '27', '8'),
	('31', '4', '3', '1', 'Clean', '15', '34'),
	('32', '1', '4', '3', 'Great ambience', '24', '38'),
	('33', '5', '1', '2', 'Quick service', '14', '4'),
	('34', '3', '1', '5', 'Dine-in available', '6', '16'),
	('35', '5', '2', '2', 'Quick service', '3', '28'),
	('36', '2', '4', '4', 'Dine-in available', '50', '6'),
	('37', '5', '3', '1', 'Take-out available', '36', '33'),
	('38', '4', '3', '5', 'Clean', '27', '30'),
	('39', '4', '1', '2', 'Take-out available', '9', '3'),
	('40', '3', '5', '2', 'Great ambience', '26', '26'),
	('41', '1', '2', '5', 'Quick service', '20', '24'),
	('42', '2', '3', '2', 'Dine-in available', '45', '9'),
	('43', '2', '3', '4', 'Dine-in available', '40', '40'),
	('44', '2', '4', '3', 'Pet-friendly', '43', '23'),
	('45', '5', '3', '3', 'Great ambience', '2', '13'),
	('46', '2', '2', '3', 'Clean', '12', '34'),
	('47', '1', '3', '4', 'Clean', '35', '29'),
	('48', '3', '5', '4', 'Great ambience', '21', '35'),
	('49', '2', '3', '3', 'Quick service', '1', '27'),
	('50', '4', '4', '4', 'Take-out available', '8', '14');


  INSERT INTO Reviews (review_id, customer_id, cafe_id, content) VALUES
	('1', '26', '38', 'This cafe is a hidden gem! The pastries are divine and the coffee is superb.'),
	('2', '10', '34', 'The cafe was overcrowded and it took forever to get our orders.'),
	('3', '35', '24', 'The cafe had a nice ambiance but the prices were a bit high.'),
	('4', '33', '28', 'The cafe had a trendy vibe but the prices were too high for what you get.'),
	('5', '19', '32', 'The coffee was too bitter for my liking and the prices were steep.'),
	('6', '47', '19', 'The cafe had a unique menu with interesting flavor combinations.'),
	('7', '16', '7', 'The coffee here is top-notch and the staff is always welcoming.'),
	('8', '13', '9', 'The cafe had a nice variety of pastries but the coffee was average.'),
	('9', '11', '6', 'This cafe is a hidden gem! The pastries are divine and the coffee is superb.'),
	('10', '43', '39', 'I would not recommend this cafe. The service was terrible and the food was tasteless.'),
	('11', '19', '2', 'This cafe is a must-visit for coffee lovers. The baristas are skilled and the coffee is outstanding.'),
	('12', '19', '31', 'The coffee was too bitter for my liking and the prices were steep.'),
	('13', '18', '6', 'The cafe had a welcoming atmosphere but the wait times were long.'),
	('14', '32', '35', 'This cafe is a must-visit for coffee lovers. The baristas are skilled and the coffee is outstanding.'),
	('15', '6', '9', 'The cafe had a charming decor but the menu options were limited.'),
	('16', '9', '35', 'I had a mixed experience at this cafe. The drinks were great but the food was disappointing.'),
	('17', '12', '10', 'I had a mixed experience at this cafe. The drinks were great but the food was disappointing.'),
	('18', '36', '11', 'The cafe had a cozy atmosphere but the menu options were limited.'),
	('19', '10', '20', 'I love coming to this cafe for its relaxing atmosphere and tasty treats.'),
	('20', '36', '11', 'The cafe was overcrowded and it took forever to get our orders.'),
	('21', '44', '40', 'I had a terrible experience at this cafe. The food was cold and the service was rude.'),
	('22', '14', '33', 'This cafe is a hidden gem! The pastries are divine and the coffee is superb.'),
	('23', '26', '13', 'I would not recommend this cafe. The service was terrible and the food was tasteless.'),
	('24', '45', '28', 'The coffee here is top-notch and the staff is always welcoming.'),
	('25', '26', '6', 'The coffee was too bitter for my liking and the prices were steep.'),
	('26', '13', '32', 'The cafe was overcrowded and it took forever to get our orders.'),
	('27', '21', '18', 'The cafe was overcrowded and it took forever to get our orders.'),
	('28', '46', '3', 'The cafe had a nice selection of drinks but the seating was uncomfortable.'),
	('29', '9', '31', 'I was disappointed with the quality of the food at this cafe.'),
	('30', '2', '6', 'The coffee tasted watered down and the pastries were dry.');


  INSERT INTO Promotion (cafe_id, promo_id, description, title, duration) VALUES
	('10', '1', 'Free upgrade to a large size on any drink', 'Limited Offer', '14'),
	('18', '2', 'get one free!', 'Limited Offer', '13'),
	('33', '3', 'Buy one coffee', 'Cafe Promotion!', '27'),
	('11', '4', 'Free upgrade to a large size on any drink', 'Limited Offer', '23'),
	('5', '5', 'Kids eat free on Sundays', 'Cafe Promotion!', '13'),
	('2', '6', '20% off your first online order', 'Promo Unlocked', '30'),
	('21', '7', 'Kids eat free on Sundays', 'New Promotion!', '11'),
	('1', '8', 'Buy one coffee', 'New Promotion!', '2'),
	('6', '9', 'Happy Hour: 2-for-1 drinks from 4pm-6pm', 'Limited Offer', '29'),
	('22', '10', 'get one free!', 'New Promotion!', '25'),
	('38', '11', 'Free small coffee with any breakfast item purchase', 'Promo Unlocked', '12'),
	('19', '12', 'get one free!', 'New Promotion!', '14'),
	('17', '13', '20% off your first online order', 'Promo Unlocked', '26'),
	('16', '14', 'Free small coffee with any breakfast item purchase', 'New Promotion!', '13'),
	('3', '15', 'Happy Hour: 2-for-1 drinks from 4pm-6pm', 'New Promotion!', '8'),
	('8', '16', 'Free small coffee with any breakfast item purchase', 'Promo Unlocked', '16'),
	('20', '17', 'get one free!', 'Cafe Promotion!', '11'),
	('25', '18', 'Free dessert with any lunch special', 'New Promotion!', '6'),
	('39', '19', '10% off your total bill with this coupon', 'Promo Unlocked', '26'),
	('14', '20', 'Free refill with any large coffee purchase', 'New Promotion!', '28'),
	('36', '21', 'get one free!', 'Promo Unlocked', '3'),
	('37', '22', '20% off your first online order', 'Cafe Promotion!', '22'),
	('28', '23', 'Kids eat free on Sundays', 'Cafe Promotion!', '17'),
	('12', '24', 'Free upgrade to a large size on any drink', 'Limited Offer', '4'),
	('13', '25', '10% off your total bill with this coupon', 'Promo Unlocked', '12'),
	('34', '26', 'Free dessert with any lunch special', 'Promo Unlocked', '8'),
	('7', '27', 'Happy Hour: 2-for-1 drinks from 4pm-6pm', 'New Promotion!', '16'),
	('29', '28', 'Buy one coffee', 'Promo Unlocked', '11'),
	('26', '29', '50% off all pastries', 'Promo Unlocked', '12'),
	('40', '30', '10% off your total bill with this coupon', 'New Promotion!', '23'),
	('35', '31', '10% off your total bill with this coupon', 'Cafe Promotion!', '24'),
	('32', '32', 'Buy one coffee', 'New Promotion!', '8'),
	('10', '33', 'Free dessert with any lunch special', 'New Promotion!', '22'),
	('6', '34', 'Free upgrade to a large size on any drink', 'Promo Unlocked', '8'),
	('38', '35', 'Free small coffee with any breakfast item purchase', 'Promo Unlocked', '26'),
	('12', '36', '20% off your first online order', 'Promo Unlocked', '19'),
	('3', '37', 'Happy Hour: 2-for-1 drinks from 4pm-6pm', 'Promo Unlocked', '10'),
	('26', '38', 'Happy Hour: 2-for-1 drinks from 4pm-6pm', 'Cafe Promotion!', '8'),
	('4', '39', 'Kids eat free on Sundays', 'Promo Unlocked', '30'),
	('25', '40', '50% off all pastries', 'Promo Unlocked', '19');


  INSERT INTO Invite (invite_id, customer_id, description, cafe_id) VALUES
	('1', '47', 'Join us for a cozy evening of live music and delicious treats!', '21'),
	('2', '5', 'Experience the magic of our themed tea party with enchanting decorations and delightful pastries.', '40'),
	('3', '26', 'Indulge in a decadent chocolate tasting event', '30'),
	('4', '36', 'featuring the finest artisanal chocolates from around the world.', '10'),
	('5', '1', 'Celebrate the flavors of autumn with our pumpkin spice latte tasting and seasonal pastry selection.', '33'),
	('6', '1', 'Embark on a culinary journey with our exclusive chef''s table event', '9'),
	('7', '23', 'showcasing innovative dishes and wine pairings.', '34'),
	('8', '8', 'Join us for a fun-filled trivia night', '22'),
	('9', '14', 'complete with tasty appetizers and refreshing beverages.', '12'),
	('10', '23', 'Experience the art of coffee brewing with our interactive workshop', '33'),
	('11', '30', 'where you''ll learn the secrets of a perfect cup.', '14'),
	('12', '44', 'Celebrate the arrival of spring with our floral-themed high tea', '10'),
	('13', '27', 'featuring delicate sandwiches and floral-infused teas.', '28'),
	('14', '36', 'Join us for a special brunch event', '40'),
	('15', '30', 'featuring a mouthwatering buffet of breakfast favorites and bottomless mimosas.', '25'),
	('16', '7', 'Indulge in a gourmet cheese and wine pairing event', '1'),
	('17', '5', 'where you''ll discover the perfect combinations of flavors.', '10'),
	('18', '7', 'Experience the flavors of the Mediterranean with our authentic Greek cuisine showcase', '32'),
	('19', '20', 'complete with live music.', '7'),
	('20', '11', 'Join us for a relaxing evening of jazz music', '4'),
	('21', '3', 'accompanied by a selection of fine wines and artisanal cheeses.', '28'),
	('22', '5', 'Celebrate the holidays with our festive gingerbread house decorating event', '5'),
	('23', '3', 'perfect for the whole family.', '17'),
	('24', '14', 'Embark on a culinary adventure with our international street food festival', '27'),
	('25', '6', 'featuring flavors from around the globe.', '34'),
	('26', '47', 'Join us for a hands-on cocktail making class', '38'),
	('27', '4', 'where you''ll learn to craft signature drinks like a pro.', '2'),
	('28', '31', 'Experience the art of latte art with our barista workshop', '11'),
	('29', '21', 'where you''ll create beautiful designs on your coffee.', '10'),
	('30', '43', 'Celebrate the flavors of summer with our tropical fruit tasting event', '29');
