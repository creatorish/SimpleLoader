AS3で外部ファイルを読み込むライブラリ
======================
シンプルかつ簡単に外部swf・画像・XMLなどを読み込むクラスです。  
as3で外部ファイルを読み込むときにはバイナリとテキストを意識して読み込む必要がありますが、  
このクラスを使えばそれをあまり気にすることなく読み込むことができます。

使い方
------

    import net.lifebird.net.SimpleLoader;
    var sLoader:SimpleLoader = new SimpleLoader();
    sLoader.addEventListener(Event.COMPLETE, onComplete);
    sLoader.load("読み込むファイルのパス");
    function onComplete(e:Event):void {
        e.target.removeEventListner(Event.COMPLETE, onComplete);
        //Imageのとき
        var data:Bitmap = e.target.data;
        //SWFのとき
        var data:MovieClip = e.target.data;
        //XMLのとき
        var data:XML = new XML(e.target.data);
    }

### 付加できるイベント ###

+    Event.OPEN
+    Event.INIT
+    Event.COMPLETE
+    ProgressEvent.PROGRESS
+    IOErrorEvent.IO_ERROR
+    SecurityErrorEvent.SECURITY_ERROR
+    HTTPStatusEvent.HTTP_STATUS

ライセンス
--------
[MIT]: http://www.opensource.org/licenses/mit-license.php
Copyright &copy; 2012 creatorish.com
Distributed under the [MIT License][mit].

作者
--------
creatorish yuu  
Weblog: <http://creatorish.com>  
Facebook: <http://facebook.com/creatorish>  
Twitter: <http://twitter.jp/creatorish>