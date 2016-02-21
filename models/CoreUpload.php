<?php

namespace app\models;

use Yii;
use yii\base\Model;
use yii\web\UploadedFile;

class CoreUpload extends Model
{
    /**
     * @var UploadedFile
     */
    public $coreFile;

    public function rules()
    {
        return [
            [['coreFile'], 'file', 'skipOnEmpty' => false, 'extensions' => 'xml'],
        ];
    }
    
    public function upload()
    {
        if ($this->validate()) {
            $this->coreFile->saveAs(Yii::getAlias('@app/efa/core/efa.xml'));
            return true;
        } else {
            return false;
        }
    }
}