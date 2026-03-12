DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
USE youtube;


CREATE TABLE channel(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description VARCHAR(512) NOT NULL,
    creationdate DATE NOT NULL
);

CREATE TABLE youtubeuser(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(256) UNIQUE NOT NULL,
    pass VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    dateofbirth DATE NOT NULL,
    sexismale BOOL NOT NULL,
    country VARCHAR(100) NOT NULL,
    postalcode VARCHAR(5) NOT NULL,
    channel INT UNSIGNED NULL,
    FOREIGN KEY (channel) REFERENCES channel(id)
);

CREATE TABLE video(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(256) NOT NULL,
    description VARCHAR(512) NOT NULL,
    sizemb INT UNSIGNED NOT NULL,
    filename VARCHAR(256) NOT NULL,
    durationseconds INT UNSIGNED NOT NULL,
    thumbnail VARCHAR(256) NOT NULL,
    reproductions INT UNSIGNED NOT NULL,
    likes INT UNSIGNED NOT NULL,
    dislikes INT UNSIGNED NOT NULL,
    state ENUM('PUBLIC','HIDDEN','PRIVATE') NOT NULL,
    youtubeuser INT UNSIGNED NOT NULL,
    uploaddate DATETIME NOT NULL,
    FOREIGN KEY(youtubeuser) REFERENCES youtubeuser(id)
);

CREATE TABLE tag(
     id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
     name VARCHAR(100) NOT NULL
);

CREATE TABLE tagsvideos(
    tag INT UNSIGNED NOT NULL,
    video INT UNSIGNED NOT NULL,
    PRIMARY KEY(tag,video),
    FOREIGN KEY (tag) REFERENCES tag(id),
    FOREIGN KEY(video) REFERENCES video(id)
);

CREATE TABLE subscription(
    youtubeuser INT UNSIGNED NOT NULL,
    channel INT UNSIGNED NOT NULL,
    PRIMARY KEY(youtubeuser,channel),
    FOREIGN KEY (youtubeuser) REFERENCES youtubeuser(id),
    FOREIGN KEY(channel) REFERENCES channel(id)
);

CREATE TABLE videolikes(
    youtubeuser INT UNSIGNED NOT NULL,
    video INT UNSIGNED NOT NULL,
    islike BOOL NOT NULL,
    likedate DATETIME NOT NULL,
    PRIMARY KEY(youtubeuser,video),
    FOREIGN KEY(youtubeuser) REFERENCES youtubeuser(id),
    FOREIGN KEY (video) REFERENCES video(id)
);

CREATE TABLE playlist(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    creationdate DATE NOT NULL,
    ispublic BOOL NOT NULL,
    youtubeuser INT UNSIGNED NOT NULL,
    FOREIGN KEY (youtubeuser) REFERENCES youtubeuser(id)
);

CREATE TABLE videosplaylist(
    playlist INT UNSIGNED NOT NULL,
    video INT UNSIGNED NOT NULL,
    PRIMARY KEY(playlist,video),
    FOREIGN KEY(playlist) REFERENCES playlist(id),
    FOREIGN KEY(video) REFERENCES video(id)
);

CREATE TABLE youtubecomment(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content VARCHAR(512) NOT NULL,
    writetime DATETIME NOT NULL,
    youtubeuser INT UNSIGNED NOT NULL,
    video INT UNSIGNED NOT NULL,
    FOREIGN KEY(youtubeuser) REFERENCES youtubeuser(id),
    FOREIGN KEY(video) REFERENCES video(id)
);

CREATE TABLE commentlike(
    youtubecomment INT UNSIGNED NOT NULL,
    youtubeuser INT UNSIGNED NOT NULL,
    islike BOOL NOT NULL,
    liketime DATETIME NOT NULL,
    PRIMARY KEY(youtubecomment,youtubeuser),
    FOREIGN KEY(youtubecomment) REFERENCES youtubecomment(id),
    FOREIGN KEY(youtubeuser) REFERENCES youtubeuser(id)
);
