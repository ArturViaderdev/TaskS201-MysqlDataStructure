DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify;

CREATE TABLE spotifyuser(
      id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      email VARCHAR(256) UNIQUE NOT NULL,
      pass VARCHAR(100) NOT NULL,
      username VARCHAR(100) NOT NULL,
      birthdate DATE NOT NULL,
      sexismale BOOL NOT NULL,
      country VARCHAR(100) NOT NULL,
      postalcode VARCHAR(5) NOT NULL,
      ispremium BOOL NOT NULL,
      subscriptiondate DATE NULL,
      renovationdate DATE NULL,
      paymethod ENUM('CREDIT CARD','PAYPAL')NULL,
      ccnumber VARCHAR(10)NULL,
      cardexpirationmonth INT UNSIGNED NULL,
      cardexpirationyear INT UNSIGNED NULL,
      cardsecuritycode INT UNSIGNED NULL,
      paypaluser VARCHAR(256) NULL
);

CREATE TABLE renovations(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    renovationdate DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    spotifyuser INT UNSIGNED NOT NULL,
    FOREIGN KEY (spotifyuser) REFERENCES spotifyuser(id)
);

CREATE TABLE playlist(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    spotifyuser INT UNSIGNED NOT NULL,
    title VARCHAR(100) NOT NULL,
    numberofsongs INT UNSIGNED NOT NULL,
    creationdate DATE NOT NULL,
    active BOOL NOT NULL,
    deleteddate DATE NULL,
    FOREIGN KEY (spotifyuser) REFERENCES spotifyuser(id)
);

CREATE TABLE artist(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    image VARCHAR(256) NOT NULL
);

CREATE TABLE album(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    publicationyear INT UNSIGNED NOT NULL,
    image VARCHAR(256) NOT NULL,
    artist INT UNSIGNED NOT NULL,
    FOREIGN KEY (artist) REFERENCES artist(id)
);

CREATE TABLE song(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    secondsofduration INT UNSIGNED NOT NULL,
    reproductions INT UNSIGNED NOT NULL,
    album INT UNSIGNED NOT NULL,
    FOREIGN KEY (album) REFERENCES album(id)
);

CREATE TABLE playlistsong(
    playlist INT UNSIGNED NOT NULL,
    song INT UNSIGNED NOT NULL,
    spotifyuser INT UNSIGNED NOT NULL,
    addeddate DATE NOT NULL,
    PRIMARY KEY(playlist,song),
    FOREIGN KEY(playlist) REFERENCES playlist(id),
    FOREIGN KEY(song) REFERENCES song(id)
);

CREATE TABLE follow(
    spotifyuser INT UNSIGNED NOT NULL,
    artist INT UNSIGNED NOT NULL,
    PRIMARY KEY(spotifyuser,artist),
    FOREIGN KEY(spotifyuser) REFERENCES spotifyuser(id),
    FOREIGN KEY (artist) REFERENCES artist(id)
);

CREATE TABLE artistsrelation(
    artist INT UNSIGNED NOT NULL,
    anotherartist INT UNSIGNED NOT NULL,
    PRIMARY KEY(artist,anotherartist),
    FOREIGN KEY (artist) REFERENCES artist(id),
    FOREIGN KEY (anotherartist) REFERENCES artist(id)
);

CREATE TABLE favouritesong(
    spotifyuser INT UNSIGNED NOT NULL,
    song INT UNSIGNED NOT NULL,
    PRIMARY KEY(spotifyuser,song),
    FOREIGN KEY (spotifyuser) REFERENCES spotifyuser(id),
    FOREIGN KEY (song) REFERENCES song(id)
);

CREATE TABLE favouritealbum(
    spotifyuser INT UNSIGNED NOT NULL,
    album INT UNSIGNED NOT NULL,
    PRIMARY KEY(spotifyuser,album),
    FOREIGN KEY (spotifyuser) REFERENCES spotifyuser(id),
    FOREIGN KEY (album) REFERENCES album(id)
);
