DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify;

CREATE TABLE users(
      id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      email VARCHAR(256) UNIQUE NOT NULL,
      pass VARCHAR(100) NOT NULL,
      user_name VARCHAR(100) NOT NULL,
      birth_date DATE NOT NULL,
      sex_is_male BOOL NOT NULL,
      country VARCHAR(100) NOT NULL,
      postal_code VARCHAR(5) NOT NULL,
      is_premium BOOL NOT NULL,
      subscription_date DATE NULL,
      renovation_date DATE NULL,
      pay_method ENUM('CREDIT CARD','PAYPAL')NULL,
      credit_card_number VARCHAR(10)NULL,
      card_expiration_month INT UNSIGNED NULL,
      card_expiration_year INT UNSIGNED NULL,
      card_security_code INT UNSIGNED NULL,
      paypal_user VARCHAR(256) NULL
);

CREATE TABLE renovations(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    renovation_date DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    spotify_user INT UNSIGNED NOT NULL,
    FOREIGN KEY (spotify_user) REFERENCES users(id)
);

CREATE TABLE playlists(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    spotify_user INT UNSIGNED NOT NULL,
    title VARCHAR(100) NOT NULL,
    number_of_songs INT UNSIGNED NOT NULL,
    creation_date DATE NOT NULL,
    active BOOL NOT NULL,
    deleted_date DATE NULL,
    FOREIGN KEY (spotify_user) REFERENCES users(id)
);

CREATE TABLE artists(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    image VARCHAR(256) NOT NULL
);

CREATE TABLE albums(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    publication_year INT UNSIGNED NOT NULL,
    image VARCHAR(256) NOT NULL,
    artist INT UNSIGNED NOT NULL,
    FOREIGN KEY (artist) REFERENCES artists(id)
);

CREATE TABLE songs(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    seconds_of_duration INT UNSIGNED NOT NULL,
    reproductions INT UNSIGNED NOT NULL,
    album INT UNSIGNED NOT NULL,
    FOREIGN KEY (album) REFERENCES albums(id)
);

CREATE TABLE songs_of_playlists(
    playlist INT UNSIGNED NOT NULL,
    song INT UNSIGNED NOT NULL,
    spotify_user INT UNSIGNED NOT NULL,
    added_date DATE NOT NULL,
    PRIMARY KEY(playlist,song),
    FOREIGN KEY(playlist) REFERENCES playlists(id),
    FOREIGN KEY(song) REFERENCES songs(id)
);

CREATE TABLE follows(
    spotify_user INT UNSIGNED NOT NULL,
    artist INT UNSIGNED NOT NULL,
    PRIMARY KEY(spotify_user,artist),
    FOREIGN KEY(spotify_user) REFERENCES users(id),
    FOREIGN KEY (artist) REFERENCES artists(id)
);

CREATE TABLE artists_relations(
    artist INT UNSIGNED NOT NULL,
    another_artist INT UNSIGNED NOT NULL,
    PRIMARY KEY(artist,another_artist),
    FOREIGN KEY (artist) REFERENCES artists(id),
    FOREIGN KEY (another_artist) REFERENCES artists(id)
);

CREATE TABLE favourites_songs(
    spotify_user INT UNSIGNED NOT NULL,
    song INT UNSIGNED NOT NULL,
    PRIMARY KEY(spotify_user,song),
    FOREIGN KEY (spotify_user) REFERENCES users(id),
    FOREIGN KEY (song) REFERENCES songs(id)
);

CREATE TABLE favourites_albums(
    spotify_user INT UNSIGNED NOT NULL,
    album INT UNSIGNED NOT NULL,
    PRIMARY KEY(spotify_user,album),
    FOREIGN KEY (spotify_user) REFERENCES users(id),
    FOREIGN KEY (album) REFERENCES albums(id)
);
