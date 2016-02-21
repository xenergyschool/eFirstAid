<?php

$params = require(__DIR__ . '/params.php');

$config = [
    'id' => 'basic',
    'defaultRoute'=>'efa',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'components' => [
        'request' => [
            // !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
            'cookieValidationKey' => 'roAjSNtmwTdrf2J__7kak7GHpUP8F2xF',
        ],
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
        'user' => [
            'identityClass' => 'app\models\User',
            'enableAutoLogin' => true,
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        'mailer' => [
            'class' => 'yii\swiftmailer\Mailer',
            // send all mails to a file by default. You have to set
            // 'useFileTransport' to false and configure a transport
            // for the mailer to send real emails.
            'useFileTransport' => true,
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'db' => require(__DIR__ . '/db.php'),
        
        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [
                
                'admin'=>'efa/index'
            ],
        ],
        'watsondialog'=>[
            
            'class' => 'app\efa\WatsonDialog',
            'baseUrl'=>'https://watson-api-explorer.mybluemix.net/dialog/api/v1/', //'https://gateway.watsonplatform.net/dialog/api/v1/
            'username'=>'dfd28718-fa2a-458a-9077-a2e3cdc106bc',
            'password'=>'Nr2RcpM0cukd',
            'dialog_id'=>'f4f1e1ee-addc-44eb-834a-57dc1b91cb38'
            ],
         'assetManager' => [
          //  'linkAssets' => true,
          //   'appendTimestamp' => true,
             'forceCopy'=> true
        ],
        
        
    ],
    'params' => $params,
];

if (YII_ENV_DEV) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
    ];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
    ];
 
}

return $config;
