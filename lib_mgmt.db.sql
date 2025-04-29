BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "books" (
	"book_id"	INTEGER,
	"title"	TEXT NOT NULL,
	"author"	TEXT NOT NULL,
	"publisher"	TEXT NOT NULL,
	"image"	TEXT,
	"total_quantity"	INTEGER NOT NULL,
	"available_quantity"	INTEGER NOT NULL,
	"genre"	TEXT,
	"date_added"	TEXT NOT NULL,
	PRIMARY KEY("book_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "borrowed_books" (
	"borrow_id"	INTEGER,
	"book_id"	INTEGER NOT NULL,
	"user_id"	INTEGER NOT NULL,
	"borrow_date"	TEXT NOT NULL,
	"return_date"	TEXT,
	"status"	TEXT NOT NULL,
	PRIMARY KEY("borrow_id" AUTOINCREMENT),
	FOREIGN KEY("book_id") REFERENCES "books"("book_id"),
	FOREIGN KEY("user_id") REFERENCES "user"("user_id")
);
CREATE TABLE IF NOT EXISTS "user" (
	"user_id"	INTEGER,
	"fname"	TEXT NOT NULL,
	"lname"	TEXT NOT NULL,
	"email"	TEXT NOT NULL UNIQUE,
	"cnumber"	TEXT NOT NULL,
	"username"	TEXT NOT NULL UNIQUE,
	"password"	TEXT NOT NULL,
	"role"	TEXT NOT NULL,
	"email_change_token"	VARCHAR(255),
	"email_change_token_expiry"	TIMESTAMP,
	"pending_email"	TEXT,
	"password_reset_token"	TEXT,
	"password_reset_token_expiry"	TIMESTAMP,
	PRIMARY KEY("user_id" AUTOINCREMENT)
);
INSERT INTO "books" VALUES (2,'To Kill a Mockingbird','Harper Lee','J.B. Lippincott & Co.','To_Kill_a_Mockingbird.jpg',5,4,'Southern Gothic, Legal Drama','2025-04-09');
INSERT INTO "books" VALUES (3,'1984','George Orwell','Secker & Warburg','1984.jpg',5,5,'Dystopian, Political Fiction','2025-04-09');
INSERT INTO "books" VALUES (4,'Pride and Prejudice','Jane Austen','T. Egerton','Pride_and_Prejudice.jpg',2,5,'Romance, Classic Fiction','2025-04-09');
INSERT INTO "books" VALUES (5,'The Catcher in the Rye1','J.D. Salinger','Little, Brown and Company','Catcher-in-the-Rye.webp',3,5,'Coming-of-Age Fiction','2025-04-09');
INSERT INTO "books" VALUES (6,'The Hobbit','J.R.R. Tolkien','George Allen & Unwin','TheHobbit_FirstEdition.jpg',6,5,'Fantasy, Adventure','2025-04-09');
INSERT INTO "books" VALUES (7,'Moby-Dick','Herman Melville','Harper & Brothers','Moby-Dick.jpg',0,5,'Adventure, Classic Fiction','2025-04-14');
INSERT INTO "books" VALUES (8,'The Odyssey','Homer','Penguin Classics','The_Odyssey.jpg',4,5,'Epic Poetry, Mythology','2025-04-09');
INSERT INTO "books" VALUES (9,'Brave New World','Aldous Huxley','Chatto & Windus','BraveNewWorld_FirstEdition.jpg',3,5,'Dystopian, Science Fiction','2025-04-09');
INSERT INTO "books" VALUES (10,'Frankenstein1','Mary Shelley','Lackington, Hughes, Harding, Mavor & Jones','Frankenstein_1818_edition_title_page.jpg',5,5,'Gothic, Science Fiction','2025-04-16');
INSERT INTO "books" VALUES (27,'Whispers of Eternity','Amelia Blake','Sunrise Publishing','https://source.unsplash.com/100x150/?book,1',10,9,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (28,'Whispers of Eternity II','Amelia Blake','Sunrise Publishing','https://source.unsplash.com/100x150/?book,1',10,10,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (29,'The Lost Chronicles','Nathaniel Cole','Maple House','https://source.unsplash.com/100x150/?book,2',8,8,'Adventure','2025-04-28');
INSERT INTO "books" VALUES (30,'Chronicles of Dust','Nathan Parker','Sandstorm Press','https://source.unsplash.com/100x150/?book,40',9,9,'Adventure','2025-04-28');
INSERT INTO "books" VALUES (31,'The Moonlit Court','Penelope Brooks','Silver Crown','https://source.unsplash.com/100x150/?book,41',10,10,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (32,'Secrets Beneath','Grayson King','Depth Publishing','https://source.unsplash.com/100x150/?book,42',8,8,'Mystery','2025-04-28');
INSERT INTO "books" VALUES (33,'Torn Skies','Aurora Ellis','Nimbus Press','https://source.unsplash.com/100x150/?book,43',9,9,'Drama','2025-04-28');
INSERT INTO "books" VALUES (34,'The Bloodstone Prophecy','Miles Turner','Dragonfire Books','https://source.unsplash.com/100x150/?book,44',7,7,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (35,'Wandering Souls','Scarlett Hayes','Soulprint Press','https://source.unsplash.com/100x150/?book,45',6,6,'Drama','2025-04-28');
INSERT INTO "books" VALUES (36,'The Glass Empire','Sawyer Dean','Crystal Books','https://source.unsplash.com/100x150/?book,46',11,11,'Science Fiction','2025-04-28');
INSERT INTO "books" VALUES (37,'Rise of the Valkyries','Eliza Clarke','Valhalla Publishing','https://source.unsplash.com/100x150/?book,47',10,10,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (38,'The Winter Pact','Graham Foster','Snowfall Press','https://source.unsplash.com/100x150/?book,48',7,7,'Adventure','2025-04-28');
INSERT INTO "books" VALUES (39,'Echoes of Ember','Melody Greene','Blazing Star','https://source.unsplash.com/100x150/?book,49',9,9,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (40,'The Hollow Throne','Carter Brooks','Thronehouse Publishing','https://source.unsplash.com/100x150/?book,50',12,12,'Historical','2025-04-28');
INSERT INTO "books" VALUES (41,'Bitter Winds','Jasmine Cole','Northern Lights','https://source.unsplash.com/100x150/?book,51',8,8,'Drama','2025-04-28');
INSERT INTO "books" VALUES (42,'Shadows Over Avalon','Wyatt Monroe','Pendragon Press','https://source.unsplash.com/100x150/?book,52',9,9,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (43,'The Cursed Crown','Isabelle West','Golden Sword Publishing','https://source.unsplash.com/100x150/?book,53',10,10,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (44,'Frozen Whispers','Logan Hayes','Frostfire Books','https://source.unsplash.com/100x150/?book,54',6,6,'Horror','2025-04-28');
INSERT INTO "books" VALUES (45,'The Iron Veil','Mila Parker','Forged Books','https://source.unsplash.com/100x150/?book,55',7,7,'Science Fiction','2025-04-28');
INSERT INTO "books" VALUES (46,'Dance of Blades','Declan Knight','Sword & Quill','https://source.unsplash.com/100x150/?book,56',8,8,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (47,'The Forgotten Fortress','Luna Morgan','Ancient Realms','https://source.unsplash.com/100x150/?book,57',10,10,'Adventure','2025-04-28');
INSERT INTO "books" VALUES (48,'Bonds of Blood and Bone','Owen Clarke','Ashen Crown','https://source.unsplash.com/100x150/?book,58',6,6,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (49,'The Fading Stars','Ella Reed','Stardrift Press','https://source.unsplash.com/100x150/?book,59',11,11,'Drama','2025-04-28');
INSERT INTO "books" VALUES (50,'The Broken Oath','Brody Knight','Silver Fang Press','https://source.unsplash.com/100x150/?book,66',6,6,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (51,'The Harvest of Souls','Emery Cross','Ravenshadow Books','https://source.unsplash.com/100x150/?book,67',7,7,'Horror','2025-04-28');
INSERT INTO "books" VALUES (52,'Garden of Thorns','Adeline James','Thornwood Publishing','https://source.unsplash.com/100x150/?book,68',9,9,'Drama','2025-04-28');
INSERT INTO "books" VALUES (53,'Chronicles of the Rift','Finn Gallagher','Stormgate Press','https://source.unsplash.com/100x150/?book,69',11,11,'Adventure','2025-04-28');
INSERT INTO "books" VALUES (54,'The Sorceress Awakens','Tessa Harper','Arcane Books','https://source.unsplash.com/100x150/?book,70',10,10,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (55,'Ashes of Tomorrow','Xavier Ellis','New Dawn Press','https://source.unsplash.com/100x150/?book,71',8,8,'Science Fiction','2025-04-28');
INSERT INTO "books" VALUES (56,'The Forgotten Song','Amara Quinn','Melody House','https://source.unsplash.com/100x150/?book,72',9,9,'Drama','2025-04-28');
INSERT INTO "books" VALUES (57,'The Firebrand Heir','Peyton Morgan','Flameborne Books','https://source.unsplash.com/100x150/?book,73',7,7,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (58,'City of Twilight','Everett West','Duskfall Press','https://source.unsplash.com/100x150/?book,74',10,10,'Mystery','2025-04-28');
INSERT INTO "books" VALUES (59,'The Gilded Pact','Vivian Cole','Golden Quill','https://source.unsplash.com/100x150/?book,75',8,8,'Historical','2025-04-28');
INSERT INTO "books" VALUES (60,'The Ashen Throne','Gideon Brooks','Graystone Press','https://source.unsplash.com/100x150/?book,76',9,9,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (61,'Vortex of Shadows','Elena Moore','Dark Spiral','https://source.unsplash.com/100x150/?book,77',6,6,'Thriller','2025-04-28');
INSERT INTO "books" VALUES (62,'The Night Weaver','Asher Blake','Silken Moon Publishing','https://source.unsplash.com/100x150/?book,78',7,7,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (63,'Dance of the Forsaken','Cora Lewis','Fallen Star Press','https://source.unsplash.com/100x150/?book,79',10,10,'Romance','2025-04-28');
INSERT INTO "books" VALUES (64,'Thorns and Roses','Easton Price','Bloom Publishing','https://source.unsplash.com/100x150/?book,80',8,8,'Drama','2025-04-28');
INSERT INTO "books" VALUES (65,'Dawn of New Horizons','Eden Brooks','First Light Press','https://source.unsplash.com/100x150/?book,100',11,11,'Science Fiction','2025-04-28');
INSERT INTO "books" VALUES (66,'Rise of the Hollow Ones','Archer Dean','Hollow Crown Books','https://source.unsplash.com/100x150/?book,98',10,10,'Horror','2025-04-28');
INSERT INTO "books" VALUES (67,'The Realm of Shattered Dreams','Quinn Ellis','Dreamfall Publishing','https://source.unsplash.com/100x150/?book,99',8,8,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (68,'Twilight of the Ancients','Weston Clarke','Ancient Dawn','https://source.unsplash.com/100x150/?book,96',6,6,'Historical','2025-04-28');
INSERT INTO "books" VALUES (69,'The Glass Tower','Mia Sullivan','Ivory Flame Publishing','https://source.unsplash.com/100x150/?book,97',7,7,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (70,'The Forgotten Kingdom','Hazel Brooks','Lost Realms','https://source.unsplash.com/100x150/?book,95',9,9,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (71,'The Queens Gambit','Aurora Carter','Regal Books','https://source.unsplash.com/100x150/?book,93',10,10,'Historical','2025-04-28');
INSERT INTO "books" VALUES (72,'The Specters Mask','Declan Hayes','Phantom Press','https://source.unsplash.com/100x150/?book,94',8,8,'Horror','2025-04-28');
INSERT INTO "books" VALUES (73,'The Endless Caravan','Isabelle Monroe','Wanderlust Publishing','https://source.unsplash.com/100x150/?book,89',8,8,'Adventure','2025-04-28');
INSERT INTO "books" VALUES (74,'The Phoenixs Call','Ryder Cooper','Ashes Reborn Press','https://source.unsplash.com/100x150/?book,90',11,11,'Fantasy','2025-04-28');
INSERT INTO "books" VALUES (75,'The Sea of Shattered Glass','Athena Clarke','Crystal Tide','https://source.unsplash.com/100x150/?book,91',9,9,'Fantasy','2025-04-28');
INSERT INTO "borrowed_books" VALUES (9,2,4,'2025-04-10',NULL,'Borrowed');
INSERT INTO "borrowed_books" VALUES (10,3,4,'2025-04-22',NULL,'Cancelled');
INSERT INTO "borrowed_books" VALUES (11,4,4,'2025-04-26','2025-04-27','Returned');
INSERT INTO "borrowed_books" VALUES (12,5,4,'2025-04-21','2025-04-28','Returned');
INSERT INTO "borrowed_books" VALUES (13,6,4,'2025-04-26','2025-04-26','Returned');
INSERT INTO "borrowed_books" VALUES (14,10,4,'2025-04-23',NULL,'Cancelled');
INSERT INTO "borrowed_books" VALUES (15,7,4,'2025-04-27','2025-04-28','Returned');
INSERT INTO "borrowed_books" VALUES (16,2,9,'2025-04-27','2025-04-28','Returned');
INSERT INTO "borrowed_books" VALUES (17,18,4,'2025-04-27','2025-04-27','Returned');
INSERT INTO "borrowed_books" VALUES (18,6,4,'2025-04-27','2025-04-28','Returned');
INSERT INTO "borrowed_books" VALUES (19,2,4,'2025-04-27',NULL,'Pending');
INSERT INTO "borrowed_books" VALUES (20,10,4,'2025-04-27',NULL,'Pending');
INSERT INTO "borrowed_books" VALUES (21,9,4,'2025-04-27','2025-04-28','Returned');
INSERT INTO "borrowed_books" VALUES (22,8,4,'2025-04-28','2025-04-28','Returned');
INSERT INTO "borrowed_books" VALUES (23,6,4,'2025-04-28',NULL,'Pending');
INSERT INTO "borrowed_books" VALUES (24,3,4,'2025-04-28',NULL,'Pending');
INSERT INTO "borrowed_books" VALUES (25,27,4,'2025-04-29',NULL,'Borrowed');
INSERT INTO "user" VALUES (1,'Sean','Padillo','sean.padillo@example.com','+631122334455','anna_admin','Anna123','Admin',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "user" VALUES (2,'Carl','Santos','carl.santos@example.com','+631122334456','carlos_admin','Admin4567','Admin',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "user" VALUES (3,'Mia','Garcia','mia.garcia@example.com','+631122334457','mia_admin','admin789','Admin',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "user" VALUES (4,'Liam','Cruz','liam.cruz@example.com','+631122334458','liam_borrower','Pass123','Borrower',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "user" VALUES (5,'Sofia','Lopez','sofia.lopez@example.com','+631122334459','sofia_borrower','Pass456','Borrower',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "user" VALUES (6,'Noah','Torres','noah.torres@example.com','+631122334465','noah_borrower','pass789','Borrower',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "user" VALUES (7,'Isabella','Ramos','isabella.ramos@example.com','+631122334475','isabella_borrower','pass321','Borrower',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "user" VALUES (8,'Lucas','Morales','lucas.morales@example.com','+631122334485','lucas_borrower','pass654','Borrower',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "user" VALUES (9,'Melgail','Padillo','melgailp31@gmail.com','+631122334495','melgailP','melgailP123','Borrower',NULL,NULL,NULL,NULL,NULL);
COMMIT;
