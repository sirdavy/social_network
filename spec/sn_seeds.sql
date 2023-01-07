TRUNCATE TABLE users, posts RESTART IDENTITY; -- replace with your own table name.
-- TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (username, email) VALUES ('Hannibal', 'hannibubs@lector.com');
INSERT INTO users (username, email) VALUES ('Darth', 'darthur@vader.net');

INSERT INTO posts (title, content, views, user_id) VALUES ('Great nibbles', 'Liver, fava beans, chianti', 10, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Why everyone sucks', 'Is it just me or do...', 9, 2);