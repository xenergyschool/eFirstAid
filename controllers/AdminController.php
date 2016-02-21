<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\filters\VerbFilter;
use yii\web\UploadedFile;
use app\models\CoreUpload;

class AdminController extends Controller{
    
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
            
                'rules' => [
                      // deny all POST requests
                    [
                        'allow' => false,
                       'roles' => ['*'],
                    ],
                    // allow authenticated users
                    [
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'dialogs' => ['get'],
                    'uploadcore'=>['post']
                ],
            ],
        ];
    }
    
    
    
    public function actionDialogs(){
        
        
        $response = Yii::$app->response;
        $response->format = \yii\web\Response::FORMAT_JSON;
        $response->data = Yii::$app->watsondialog->getDialogs();
        
        
    }
    
    
    public function actionUploadcore(){
        
     $model = new CoreUpload();

        if (Yii::$app->request->isPost) {
            $model->coreFile = UploadedFile::getInstanceByName('coreFile');
            if ($model->upload()) {
                // file is uploaded successfully
                $response = Yii::$app->response;
                $response->format = \yii\web\Response::FORMAT_JSON;
                $response->data = Yii::$app->watsondialog->updateDialogs();
            }
        }

        
        
    }
    
    
}