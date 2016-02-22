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
class AppAsset extends AssetBundle
{
    public $sourcePath = '@app/efa';
    public $css = [
        'css/style.css',
    ];
    public $js = [
        'js/router.js',
         'js/mount.js'
    ];
    public $depends = [
        'app\assets\RiotTagAsset',
        'app\assets\ThirdAsset'
    ];
    
}
