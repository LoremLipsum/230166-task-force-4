DROP DATABASE IF EXISTS task_force;

CREATE DATABASE task_force
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

USE task_force;

CREATE TABLE category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  name VARCHAR(32) NOT NULL,
  label VARCHAR(32) NOT NULL,

  UNIQUE INDEX category_name (name)
);

CREATE TABLE city (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  name VARCHAR(32) NOT NULL,
  lat DECIMAL(9, 6) NULL,
  lng DECIMAL(9, 6) NULL
);

CREATE TABLE user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_executor TINYINT(1) DEFAULT 0,
  raiting FLOAT DEFAULT 0,
  email VARCHAR(64) NOT NULL,
  name VARCHAR(64) NOT NULL,
  password CHAR(60) NOT NULL,
  avatar VARCHAR(128) NULL DEFAULT NULL,
  date_of_birth DATE DEFAULT NULL,
  phone CHAR(11) NULL DEFAULT NULL,
  telegram CHAR(64) NULL DEFAULT NULL,
  city_id INT NULL DEFAULT NULL,

  UNIQUE INDEX user_email (email),

  FOREIGN KEY (city_id) REFERENCES city(id)
);

CREATE TABLE task (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  customer_id INT NOT NULL,
  executor_id INT NULL DEFAULT NULL,
  category_id INT NOT NULL,
  status ENUM('new', 'cencelled', 'in_progress', 'done', 'failed') DEFAULT 'new',
  title VARCHAR(500) NOT NULL,
  text VARCHAR(1000) NOT NULL,
  price DECIMAL(10, 2) UNSIGNED DEFAULT 0,
  deadline TIMESTAMP DEFAULT NULL,

  FULLTEXT INDEX post_text (title, text),

  FOREIGN KEY (customer_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (executor_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES category(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE user_category (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  category_id INT,

  FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES category(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE response (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  task_id INT,
  user_id INT,
  is_approved TINYINT(1) DEFAULT 0,
  message VARCHAR(256) NULL DEFAULT NULL,
  price DECIMAL(10, 2) UNSIGNED NULL DEFAULT NULL,

  FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (task_id) REFERENCES task(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE feedback (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  task_id INT,
  mark TINYINT NOT NULL,
  text VARCHAR(500) NULL DEFAULT NULL,

  FOREIGN KEY (task_id) REFERENCES task(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE file (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  task_id INT,
  user_id INT,
  url VARCHAR(128) NOT NULL,

  FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (task_id) REFERENCES task(id) ON UPDATE CASCADE ON DELETE CASCADE
);
