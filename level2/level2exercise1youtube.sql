DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
USE youtube;


CREATE TABLE channels(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description VARCHAR(512) NOT NULL,
    creation_date DATE NOT NULL
);

CREATE TABLE users(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(256) UNIQUE NOT NULL,
    pass VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    sex_is_male BOOL NOT NULL,
    country VARCHAR(100) NOT NULL,
    postalcode VARCHAR(5) NOT NULL,
    channel INT UNSIGNED NULL,
    FOREIGN KEY (channel) REFERENCES channels(id)
);

CREATE TABLE videos(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(256) NOT NULL,
    description VARCHAR(512) NOT NULL,
    size_mb INT UNSIGNED NOT NULL,
    filename VARCHAR(256) NOT NULL,
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
     name VARCHAR(100) NOT NULL
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
