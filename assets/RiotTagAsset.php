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
class RiotTagAsset extends AssetBundle
{
   public $sourcePath = '@app/efa/riottags';
  
    public $js = [
        'app-efa.tag',
        'app-admin.tag'
    ];
    
    public $jsOptions = [
        'type'=>'riot/tag'
        
        ];
        
    public $depends = [];
      
   
}
