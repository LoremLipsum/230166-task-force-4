<?php

return [
    'class' => 'yii\db\Connection',
    'dsn' => 'mysql:host=127.0.0.1;dbname=taskforce',
    'username' => 'margo',
    'password' => '',
    'charset' => 'utf8',
    'on afterOpen' => function ($event) {
        // $event->sender refers to the DB connection
        $event->sender->createCommand("SET time_zone = '+00:00'")->execute();
    }

    // Schema cache options (for production environment)
    //'enableSchemaCache' => true,
    //'schemaCacheDuration' => 60,
    //'schemaCache' => 'cache',
];
