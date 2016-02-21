<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace app\assets;

use yii\web\AssetBundle;

/**
 * @author Qiang Xue <qiang.xue@gmail.com>
 * @since 2.0
 */
class ThirdAsset extends AssetBundle
{
   public $sourcePath = '@app/vendor/bower';
    public $css = [
        'fontawesome/css/font-awesome.css'
        
        ];
    public $js = [
        'jquery-form/jquery.form.js',
        'riot/riot+compiler.js'
    ];
    
    public $depends = [
        
        'yii\bootstrap\BootstrapAsset',
        'yii\bootstrap\BootstrapPluginAsset'
        ];
   
}
