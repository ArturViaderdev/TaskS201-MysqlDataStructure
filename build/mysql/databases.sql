DROP DATABASE IF EXISTS optics;
CREATE DATABASE optics CHARACTER SET utf8mb4;
USE optics;

CREATE TABLE suppliers (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  street VARCHAR(100) NOT NULL,
  num INT NOT NULL,
  door VARCHAR(4) NOT NULL,
  floor_house VARCHAR(4) NOT NULL,
  city VARCHAR(100) NOT NULL,
  postal_code VARCHAR(5) NOT NULL,
  country VARCHAR(100),
  telephone VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  nif VARCHAR(9) NOT NULL UNIQUE
);

CREATE TABLE brands (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    supplier INT UNSIGNED NOT NULL,
    FOREIGN KEY (supplier) REFERENCES suppliers(id)
);

CREATE TABLE glasses (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    brand INT UNSIGNED NOT NULL,
    model VARCHAR(100) NOT NULL UNIQUE,
    left_lens_prescription DECIMAL(4,2) NOT NULL,
    right_lens_prescription DECIMAL(4,2) NOT NULL,
    frametype ENUM('RIMLEESS','PLASTIC','METAL')NOT NULL,
    framecolor VARCHAR(10) NOT NULL,
    left_lens_color VARCHAR(10) NOT NULL,
    right_lens_color VARCHAR(10) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (brand) REFERENCES brands(id)
);

CREATE TABLE clients (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    postal_code VARCHAR(5) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL,
    recommended_by VARCHAR(100) NULL
);

CREATE TABLE employees(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE sales(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    glass INT UNSIGNED,
    client INT UNSIGNED NOT NULL,
    sold_date DATE NOT NULL,
    employee INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    FOREIGN KEY (glass) REFERENCES glasses(id),
    FOREIGN KEY (client) REFERENCES clients(id),
    FOREIGN KEY (employee) REFERENCES employees(id)
);

INSERT INTO suppliers(name,street,num,door,floor_house,city,postal_code,country,telephone,fax,NIF) VALUES('General óptica','calle de la calle',10,'1',"2",'Barcelona',08911,'spain','933333333','934444444','34467543E');

INSERT INTO suppliers(name,street,num,door,floor_house,city,postal_code,country,telephone,fax,NIF) VALUES('Óptica martinez','calle de la calle',10,'1','2','Barcelona',08911,'spain','933333333','934444444','34467543B');

INSERT INTO brands(name,supplier) VALUES('Rayban',1);

INSERT INTO brands(name,supplier) VALUES('Martinez',1);

INSERT INTO glasses(brand,model,left_lens_prescription,right_lens_prescription,frametype,framecolor,left_lens_color,right_lens_color,price) VALUES(1,'Classicglass',2,2,'PLASTIC','red','red','red',100);

INSERT INTO glasses(brand,model,left_lens_prescription,right_lens_prescription,frametype,framecolor,left_lens_color,right_lens_color,price) VALUES(2,'ModernGlass',2,2,'PLASTIC','blue','blue','blue',100);


INSERT INTO clients(name,postal_code,phone,email,registration_date,recommended_by) VALUES('Pedro Reyes','09999','933333333','pedro@gmail.com','2024-01-01',null);

INSERT INTO employees(name) VALUES('Juan Costa');

INSERT INTO sales(glass,client,sold_date,employee,quantity) VALUES(1,1,'2025-01-01',1,1);
INSERT INTO sales(glass,client,sold_date,employee,quantity) VALUES(1,1,'2026-01-01',1,1);
INSERT INTO sales(glass,client,sold_date,employee,quantity) VALUES(1,1,'2027-01-01',1,1);

DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

 CREATE TABLE provinces (
   id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(100) NOT NULL
 );

CREATE TABLE cities (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    province INT UNSIGNED,
    FOREIGN KEY (province) REFERENCES provinces(id)
 );

CREATE TABLE customers (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    postal_code VARCHAR(5) NOT NULL,
    city INT UNSIGNED NOT NULL,
    phone_number VARCHAR(12) NOT NULL,
    FOREIGN KEY (city) REFERENCES cities(id)
);

CREATE TABLE shops (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(100) NOT NULL,
    postal_code VARCHAR(5) NOT NULL,
    city INT UNSIGNED,
    FOREIGN KEY (city) REFERENCES cities(id)
);

CREATE TABLE employees (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surnames VARCHAR(100) NOT NULL,
    nif VARCHAR(9) NOT NULL,
    phone VARCHAR(12) NOT NULL,
    shop INT UNSIGNED,
    delivery_driver BOOL NOT NULL,
    FOREIGN KEY(shop) REFERENCES shops(id)
);

CREATE TABLE orders (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer INT UNSIGNED NOT NULL,
    order_date DATETIME NOT NULL,
    delivery BOOL NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    shop INT UNSIGNED NOT NULL,
    delivered_by INT UNSIGNED NULL,
    FOREIGN KEY (customer) REFERENCES customers(id),
    FOREIGN KEY (shop) REFERENCES shops(id),
    FOREIGN KEY (delivered_by) REFERENCES employees(id)
);

CREATE TABLE pizza_categories (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(256) NOT NULL,
    photo VARCHAR(256) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    product_type ENUM('PIZZA','BURGER','DRINK') NOT NULL,
    pizza_category INT UNSIGNED NULL,
    FOREIGN KEY (pizza_category) REFERENCES pizza_categories(id)
);

CREATE TABLE products_from_orders (
    the_order INT UNSIGNED NOT NULL,
    product INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    FOREIGN KEY (product) REFERENCES products(id),
    FOREIGN KEY (the_order) REFERENCES orders(id),
    PRIMARY KEY (the_order,product)
);



INSERT INTO provinces (name) VALUES ('Barcelona'),('Madrid');

INSERT INTO cities (name, province) VALUES ('Barcelona', 1),('Madrid', 2);

INSERT INTO customers ( first_name,last_name,address,postal_code,city,phone_number)
VALUES('Pedro','Reyes','calle de la calle',09999,1,'933333333');

INSERT INTO shops (address, postal_code, city) VALUES("Calle calle", '08888', 1);

INSERT INTO employees (name, surnames, nif, phone, shop, delivery_driver) VALUES("Paco","Torras Garcia",'48473637E','933444334',1,false);

INSERT INTO orders (customer,order_date,delivery,total_price,shop,delivered_by)
VALUES(1, '2025-01-01', false, 20, 1, null), (1,'2025-07-01',true,10,1,1);

INSERT INTO pizza_categories(name) VALUES('Italiana');

INSERT INTO products(name,description,photo,price,product_type,pizza_category) VALUES('Cuatro quesos','Pizza con cuatro quesos','cuatro.jpg',10,'PIZZA',1),
                                                                                    ('Cocacola','Botella de cocacola de 100cl','cocacola.jpg',10,'DRINK',null);

INSERT INTO products_from_orders(the_order,product,quantity) VALUES(1,1,1),(1,2,1);

DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
USE youtube;

CREATE TABLE countries(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE users(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(256) UNIQUE NOT NULL,
    pass VARCHAR(100) NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    sex ENUM('MALE','FEMALE') NOT NULL,
    country INT UNSIGNED NOT NULL,
    postal_code VARCHAR(5) NOT NULL,
    FOREIGN KEY(country) REFERENCES countries(id)
);

CREATE TABLE channels(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description VARCHAR(512) NOT NULL,
    creation_date DATE NOT NULL,
    youtube_user INT UNSIGNED UNIQUE NOT NULL,
    FOREIGN KEY (youtube_user) REFERENCES users(id)
);

CREATE TABLE videos(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(256) NOT NULL,
    description VARCHAR(512) NOT NULL,
    size_mb INT UNSIGNED NOT NULL,
    file_name VARCHAR(256) NOT NULL,
    duration_seconds INT UNSIGNED NOT NULL,
    thumbnail VARCHAR(256) NOT NULL,
    reproductions INT UNSIGNED NOT NULL,
    likes INT UNSIGNED NOT NULL,
    dislikes INT UNSIGNED NOT NULL,
    state ENUM('PUBLIC','HIDDEN','PRIVATE') NOT NULL,
    youtube_user INT UNSIGNED NOT NULL,
    upload_date DATETIME NOT NULL,
    FOREIGN KEY(youtube_user) REFERENCES users(id)
);

CREATE TABLE tags(
     id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
     name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE tags_videos(
    tag INT UNSIGNED NOT NULL,
    video INT UNSIGNED NOT NULL,
    PRIMARY KEY(tag,video),
    FOREIGN KEY (tag) REFERENCES tags(id),
    FOREIGN KEY(video) REFERENCES videos(id)
);

CREATE TABLE subscriptions(
    youtube_user INT UNSIGNED NOT NULL,
    channel INT UNSIGNED NOT NULL,
    PRIMARY KEY(youtube_user,channel),
    FOREIGN KEY (youtube_user) REFERENCES users(id),
    FOREIGN KEY(channel) REFERENCES channels(id)
);

CREATE TABLE likes_of_videos(
    youtube_user INT UNSIGNED NOT NULL,
    video INT UNSIGNED NOT NULL,
    is_like BOOL NOT NULL,
    like_date DATETIME NOT NULL,
    PRIMARY KEY(youtube_user,video),
    FOREIGN KEY(youtube_user) REFERENCES users(id),
    FOREIGN KEY (video) REFERENCES videos(id)
);

CREATE TABLE playlists(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    creation_date DATE NOT NULL,
    is_public BOOL NOT NULL,
    youtube_user INT UNSIGNED NOT NULL,
    FOREIGN KEY (youtube_user) REFERENCES users(id)
);

CREATE TABLE videos_playlists(
    playlist INT UNSIGNED NOT NULL,
    video INT UNSIGNED NOT NULL,
    PRIMARY KEY(playlist,video),
    FOREIGN KEY(playlist) REFERENCES playlists(id),
    FOREIGN KEY(video) REFERENCES videos(id)
);

CREATE TABLE comments(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content VARCHAR(512) NOT NULL,
    write_time DATETIME NOT NULL,
    youtube_user INT UNSIGNED NOT NULL,
    video INT UNSIGNED NOT NULL,
    FOREIGN KEY(youtube_user) REFERENCES users(id),
    FOREIGN KEY(video) REFERENCES videos(id)
);

CREATE TABLE likes_of_comments(
    youtube_comment INT UNSIGNED NOT NULL,
    youtube_user INT UNSIGNED NOT NULL,
    is_like BOOL NOT NULL,
    like_time DATETIME NOT NULL,
    PRIMARY KEY(youtube_comment,youtube_user),
    FOREIGN KEY(youtube_comment) REFERENCES comments(id),
    FOREIGN KEY(youtube_user) REFERENCES users(id)
);

INSERT INTO countries(name) VALUES('Spain');

INSERT INTO users(email,pass,user_name,date_of_birth,sex,country,postal_code) VALUES('pedro@gmail.com','pedro123','PedroReyes','1990-01-01','MALE',1,'09999');

INSERT INTO channels(name,description,creation_date,youtube_user) VALUES('PrograTuto','Tutoriales de programación','2020-01-01',1);

INSERT INTO videos(title,description,size_mb,file_name,duration_seconds,thumbnail,reproductions,likes,dislikes,state,youtube_user,upload_date) VALUES('Tutorial Java','Un tutorial de java',2000,'video.mp4',2000,'video.png',100,1,0,'PUBLIC',1,'2020-01-02');

INSERT INTO tags(name) VALUES('Programación');

INSERT INTO tags_videos VALUES(1,1);

INSERT INTO users(email,pass,user_name,date_of_birth,sex,country,postal_code) VALUES('juan@gmail.com','juan123','JuanCosta','1990-01-01','MALE',1,'09999');

INSERT INTO channels(name,description,creation_date,youtube_user) VALUES('CociTuto','Tutoriales de cocina','2021-01-01',2);

INSERT INTO subscriptions(youtube_user, channel) VALUES(1,2);

INSERT INTO likes_of_videos(youtube_user,video,is_like,like_date) VALUES(2,1,true,'2020-02-02');

INSERT INTO playlists(name,creation_date,is_public,youtube_user) VALUES('Programación','2021-01-01',true,2);

INSERT INTO videos_playlists(playlist,video) VALUES(1,1);

INSERT INTO comments(content,write_time,youtube_user,video) VALUES('muy bueno','2021-01-01',2,1);

INSERT INTO likes_of_comments(youtube_comment,youtube_user,is_like,like_time) VALUES(1,1,true,'2021-01-02');

DROP DATABASE IF EXISTS spotify;

CREATE DATABASE spotify CHARACTER SET utf8mb4;

USE spotify;

CREATE TABLE countries (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
  );

CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(256) UNIQUE NOT NULL,
    pass VARCHAR(100) NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    sex ENUM('MALE', 'FEMALE') NOT NULL,
    country INT UNSIGNED NOT NULL,
    postal_code VARCHAR(5) NOT NULL,
    is_premium BOOL NOT NULL,
    FOREIGN KEY (country) REFERENCES countries (id)
  );

CREATE TABLE subscriptions (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    subscription_date DATE NULL,
    renovation_date DATE NULL,
    pay_method ENUM('CREDIT CARD', 'PAYPAL') NULL,
    credit_card_number VARCHAR(10) NULL,
    card_expiration_month INT UNSIGNED NULL,
    card_expiration_year INT UNSIGNED NULL,
    card_security_code INT UNSIGNED NULL,
    paypal_user VARCHAR(256) NULL,
    spotify_user INT UNSIGNED NOT NULL,
    FOREIGN KEY (spotify_user) REFERENCES users (id)
  );

CREATE TABLE renovations (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    renovation_date DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    subscription INT UNSIGNED NOT NULL,
    FOREIGN KEY (subscription) REFERENCES subscriptions (id)
  );

CREATE TABLE playlists (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    spotify_user INT UNSIGNED NOT NULL,
    title VARCHAR(100) NOT NULL,
    number_of_songs INT UNSIGNED NOT NULL,
    creation_date DATE NOT NULL,
    active BOOL NOT NULL,
    deleted_date DATE NULL,
    FOREIGN KEY (spotify_user) REFERENCES users (id)
  );

CREATE TABLE artists (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    image VARCHAR(256) NOT NULL
  );

CREATE TABLE albums (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    publication_year INT UNSIGNED NOT NULL,
    image VARCHAR(256) NOT NULL,
    artist INT UNSIGNED NOT NULL,
    FOREIGN KEY (artist) REFERENCES artists (id)
  );

CREATE TABLE songs (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    seconds_of_duration INT UNSIGNED NOT NULL,
    reproductions INT UNSIGNED NOT NULL,
    album INT UNSIGNED NOT NULL,
    FOREIGN KEY (album) REFERENCES albums (id)
  );

CREATE TABLE songs_of_playlists (
    playlist INT UNSIGNED NOT NULL,
    song INT UNSIGNED NOT NULL,
    spotify_user INT UNSIGNED NOT NULL,
    added_date DATE NOT NULL,
    PRIMARY KEY (playlist, song),
    FOREIGN KEY (playlist) REFERENCES playlists (id),
    FOREIGN KEY (song) REFERENCES songs (id),
    FOREIGN KEY (spotify_user) REFERENCES users (id)
  );

CREATE TABLE follows (
    spotify_user INT UNSIGNED NOT NULL,
    artist INT UNSIGNED NOT NULL,
    PRIMARY KEY (spotify_user, artist),
    FOREIGN KEY (spotify_user) REFERENCES users (id),
    FOREIGN KEY (artist) REFERENCES artists (id)
  );

CREATE TABLE artists_relations (
    artist INT UNSIGNED NOT NULL,
    another_artist INT UNSIGNED NOT NULL,
    PRIMARY KEY (artist, another_artist),
    FOREIGN KEY (artist) REFERENCES artists (id),
    FOREIGN KEY (another_artist) REFERENCES artists (id)
  );

CREATE TABLE favourites_songs (
    spotify_user INT UNSIGNED NOT NULL,
    song INT UNSIGNED NOT NULL,
    PRIMARY KEY (spotify_user, song),
    FOREIGN KEY (spotify_user) REFERENCES users (id),
    FOREIGN KEY (song) REFERENCES songs (id)
  );

CREATE TABLE favourites_albums (
    spotify_user INT UNSIGNED NOT NULL,
    album INT UNSIGNED NOT NULL,
    PRIMARY KEY (spotify_user, album),
    FOREIGN KEY (spotify_user) REFERENCES users (id),
    FOREIGN KEY (album) REFERENCES albums (id)
  );

INSERT INTO countries (name) VALUES('Spain'),('France');

INSERT INTO users (email,pass,user_name,birth_date,sex,country,postal_code,is_premium)
VALUES('pedro@gmail.com','pedro123','pedroreyes','1980-01-01','MALE',1,'09999',true);

INSERT INTO subscriptions (subscription_date,renovation_date,pay_method,credit_card_number,card_expiration_month,card_expiration_year,card_security_code,paypal_user,spotify_user) VALUES('2021-01-01','2022-01-01','PAYPAL',null,null,null,null,'pedro@gmail.com',1);

INSERT INTO renovations (renovation_date, total, subscription) VALUES('2021-01-01', 100, 1);

INSERT INTO playlists (spotify_user,title,number_of_songs,creation_date,active,deleted_date)VALUES(1, 'drum and bass', 0, '2021-01-01', true, null);

INSERT INTO artists (name, image)VALUES('paco', 'paco.png');

INSERT INTO albums (title, publication_year, image, artist)VALUES('temas', 2020, 'temas.png', 1);

INSERT INTO songs (title, seconds_of_duration, reproductions, album)VALUES('tema', 200, 1, 1);

INSERT INTO songs_of_playlists(playlist,song,spotify_user,added_date) VALUES(1,1,1,'2021-01-01');

UPDATE playlists SET number_of_songs=number_of_songs+1 WHERE id=1;

INSERT INTO follows(spotify_user,artist) VALUES(1,1);

INSERT INTO artists (name, image)VALUES('juan', 'juan.png');

INSERT INTO artists_relations(artist,another_artist) VALUES(1,2);

INSERT INTO favourites_songs(spotify_user,song) VALUES(1,1);

INSERT INTO favourites_albums(spotify_user,album) VALUES(1,1);
