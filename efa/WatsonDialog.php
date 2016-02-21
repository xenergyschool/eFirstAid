<?php

namespace app\efa;
 
use Yii; 
use yii\base\Component;
use yii\httpclient\Client;

class WatsonDialog extends Component
{
    public $baseUrl ='https://watson-api-explorer.mybluemix.net/dialog/api/v1/';  //'https://gateway.watsonplatform.net/dialog/api/v1/
    
    public $username = '';
    
    public $password = '';
    
    public $dialog_id = '';
   

    private $_httpClient;

    public function getHttpClient()
    {
        if (!is_object($this->_httpClient)) {
            $this->_httpClient = Yii::createObject([
                'class' => Client::className(),
                'baseUrl' => $this->baseUrl,
                 'responseConfig' => [
                    'format' => Client::FORMAT_JSON
                 ],
            ]);
        }
        
        $auth = base64_encode($this->username . ':' . $this->password);
        $client = $this->_httpClient
                    ->createRequest()
                    ->addHeaders(['Authorization' => 'Basic ' . $auth]);
        
        return $client;
    }

    /**
     * Get Dialogs
     * 
     * 
     **/
     
     public function getDialogs(){
     $response = $this->getHttpClient()
            ->setMethod('get')
            ->setUrl('dialogs')
            ->send();
        if (!$response->isOk) {
            throw new \Exception('Unable to get dialogs data');
        }

        return $response->data;
         
     }
     
     public function updateDialogs(){
         $response = $this->getHttpClient()
            ->setMethod('put')
            ->setUrl('dialogs/' . $this->dialog_id)
             ->setData([
                'dialog_id' => $this->dialog_id,
             ])
             ->addFile('file', Yii::getAlias('@app/efa/core/efa.xml'))
             ->send();
         if (!$response->isOk) {
            throw new \Exception('Unable to get dialogs data');
        }

        return $response->data;
     }
     
     
     public function startConversation($post){
        $data = [
                'dialog_id' => $this->dialog_id,
                'input'=>isset($post['input'])?$post['input']:''
             ];
        if(isset($post['conversation_id']) && $post['conversation_id'] !== 'start'){
            
            $data['conversation_id'] = $post['conversation_id'];
            $data['client_id']  = $post['client_id'];
            
        }
        
         $response = $this->getHttpClient()
            ->setMethod('post')
            ->setUrl('dialogs/' . $this->dialog_id . '/conversation')
             ->setData($data)
             ->send();
             
             
         if (!$response->isOk) {
            throw new \Exception('Unable to get dialogs data');
        }

        return $response->data;
         
         
     }
     
     
     public function getProfile($get){
         
          $data = [
                'dialog_id' => $this->dialog_id,
                'client_id'=>$get['client_id']
             ];
      
         $response = $this->getHttpClient()
            ->setMethod('get')
            ->setUrl('dialogs/' . $this->dialog_id . '/profile')
             ->setData($data)
             ->send();
             
             
         if (!$response->isOk) {
            throw new \Exception('Unable to get dialogs data');
        }

        return $response->data;
     }
   

 }