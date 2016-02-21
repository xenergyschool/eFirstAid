<?php 

namespace app\controllers;

use Yii;
use yii\web\Controller;
use yii\filters\VerbFilter;

class EfaController extends Controller{
    
    
    
    public function actionIndex(){
        
        return $this->render('index');
        
        
    }
    
    public function actionConversation(){
        
             $request = Yii::$app->request;
			// prepare and return a data provider for the "index" 
			$post =  $request->post(); 
				unset($post['_csrf']);
		    	$response = Yii::$app->response;
                $response->format = \yii\web\Response::FORMAT_JSON;
                $response->data = Yii::$app->watsondialog->startConversation($post);
			
			
        
    }
    
    public function actionDialogs(){
        
        	$response = Yii::$app->response;
                $response->format = \yii\web\Response::FORMAT_JSON;
                $response->data = Yii::$app->watsondialog->getDialogs();
        
    }
    
    public function actionProfile(){
        
         $request = Yii::$app->request;
			// prepare and return a data provider for the "index" 
			$get =  $request->get(); 
				unset($get['_csrf']);
		    	$response = Yii::$app->response;
                $response->format = \yii\web\Response::FORMAT_JSON;
                $response->data = Yii::$app->watsondialog->getProfile($get);
        
    }
}