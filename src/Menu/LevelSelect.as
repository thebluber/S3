package Menu
{
  import engine.AssetRegistry;
  import engine.ManagedStage;
  import flash.geom.Point;
  import starling.text.TextField;
  import starling.utils.Color;
  import starling.utils.HAlign;
  import starling.display.Button;
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.Quad;
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;
  import starling.core.Starling;
  import engine.StageManager;
  import Level.*;
  import engine.SaveGame;
  
  /**
   * ...
   * @author
   */
  public class LevelSelect extends ManagedStage
  {
    private var _bg:Quad;
    private var _levelInfo:Sprite;
    private var _scoreInfo:TextField;
    private var _medalInfo:Image;

    private var _showingInfo:Boolean;
    private var _levelName:Image;
    private var _scrollable:Sprite;
    private var _slideY:Number = 0;
    private static const _lockedPositions:Array = [
      [15, 262],
      [261, 382],
      [514, 512],
      [261, 638],
      [11, 764],
      [261, 893],
      [514, 1018],
      [54, 1190]
    ];
    
    private static const _unlockedPositions:Array = [
      [15, 262],
      [261, 377],
      [514, 509],
      [261, 626],
      [11, 743],
      [261, 890],
      [515, 1009],
      [54, 1190]      
    ];
    
    public function LevelSelect()
    {
      
      AssetRegistry.loadLevelSelectGraphics();
      AssetRegistry.loadScoringGraphics();
      _scrollable = new Sprite();
      _scrollable.addEventListener(TouchEvent.TOUCH, onTouch);
      _levelInfo = new Sprite();
      _levelInfo.addChild(new Image(AssetRegistry.LevelSelectAtlas.getTexture("info-level")));
      
      _showingInfo = false;
      _levelName = new Image(AssetRegistry.LevelSelectAtlas.getTexture("text-info-level1"));
      
      _bg = new Quad(960, 2240, 0xCDB594);
      //_scrollable.addChild(_bg);
      
      var bgLeft1:Image = new Image(AssetRegistry.LevelSelectAtlas.getTexture("background_small"));
      _scrollable.addChild(bgLeft1);
      
      var bgLeft2:Image = new Image(AssetRegistry.LevelSelectAtlas.getTexture("background_small"));
      bgLeft2.y = (bgLeft1.height * 2) - 1;
      bgLeft2.scaleY = -1;
      
      _scrollable.addChild(bgLeft2);
      
      var bgLeft3:Image = new Image(AssetRegistry.LevelSelectAtlas.getTexture("background_small"));
      bgLeft3.y = (bgLeft1.height * 2) - 1;
      _scrollable.addChild(bgLeft3);
      
      var bgLeft4:Image = new Image(AssetRegistry.LevelSelectAtlas.getTexture("background_small"));
      bgLeft4.y = (bgLeft4.height * 4) - 1;
      bgLeft4.scaleY = -1;
      _scrollable.addChild(bgLeft4);
      
      var bgRight1:Image = new Image(AssetRegistry.LevelSelectAtlas.getTexture("background_small"));
      bgRight1.x = (bgRight1.width * 2) - 1;
      bgRight1.scaleX = -1;
      _scrollable.addChild(bgRight1);
      
      var bgRight2:Image = new Image(AssetRegistry.LevelSelectAtlas.getTexture("background_small"));
      bgRight2.x = bgRight1.x;
      bgRight2.y = bgLeft2.y;
      bgRight2.scaleY = bgLeft2.scaleY;
      bgRight2.scaleX = bgRight1.scaleX;
      _scrollable.addChild(bgRight2);
          
      var bgRight3:Image = new Image(AssetRegistry.LevelSelectAtlas.getTexture("background_small"));
      bgRight3.x = bgRight1.x;
      bgRight3.y = bgLeft3.y;
      bgRight3.scaleX = bgRight1.scaleX;
      bgRight3.scaleY = bgLeft3.scaleY;
      _scrollable.addChild(bgRight3);
      
      var bgRight4:Image = new Image(AssetRegistry.LevelSelectAtlas.getTexture("background_small"));
      bgRight4.x = bgRight1.x;
      bgRight4.y = bgLeft4.y;
      bgRight4.scaleX = bgRight1.scaleX;
      bgRight4.scaleY = bgLeft4.scaleY;
      _scrollable.addChild(bgRight4);
         
      var header:Image = new Image(AssetRegistry.LevelSelectAtlas.getTexture("header_15-20"));
      header.x = 15;
      header.y = 20;
      _scrollable.addChild(header);
      
      for (var i:int = 0; i < 8; i++) {
        var textureStr:String;
        var level:Image;
        if(SaveGame.levelUnlocked(i + 1)) {
          textureStr = "tile-level" + String(i + 1) + "_" + String(_unlockedPositions[i][0]) + "-" + String(_unlockedPositions[i][1]);
          level = new Image(AssetRegistry.LevelSelectAtlas.getTexture(textureStr));
          level.x = _unlockedPositions[i][0];
          level.y = _unlockedPositions[i][1];
          level.addEventListener(TouchEvent.TOUCH, showLevelInfo(i + 1));
        } else {
          if (i == 7) {
            level = new Image(AssetRegistry.LevelSelectAtlas.getTexture("tile-boss-locked"));
          } else {
            level = new Image(AssetRegistry.LevelSelectAtlas.getTexture("tile-level-locked"));
          }
          level.x = _lockedPositions[i][0];
          level.y = _lockedPositions[i][1];
        }
        _scrollable.addChild(level);
      }
      
      var backButton:Button = new Button(AssetRegistry.LevelSelectAtlas.getTexture("back-button_705-205"));
      backButton.x = 705;
      backButton.y = 205;
      backButton.addEventListener(Event.TRIGGERED, function(event:Event):void {
        StageManager.switchStage(MainMenu);
      });
      
      _scrollable.addChild(backButton);
            
      addChild(_scrollable);
      
      _scrollable.flatten();
    
    }
    
    private function showLevelInfo(level:int):Function
    {
      var that:Sprite = this;
      return function(event:TouchEvent):void
      {
        if (!_showingInfo)
        {
          var touch:Touch = event.getTouch(that, TouchPhase.ENDED)
          if (touch)
          {
            if (_slideY < 50)
            {
              _levelInfo.removeChild(_levelName);
              _levelName.dispose();
              if (_scoreInfo) {
                _levelInfo.removeChild(_scoreInfo);
                _scoreInfo.dispose()
              } 
              if (_medalInfo){
                _levelInfo.removeChild(_medalInfo);
                _medalInfo.dispose();
              }
              _levelName = new Image(AssetRegistry.LevelSelectAtlas.getTexture("text-info-level" + String(level)));
              _levelName.x += 85;
              _levelName.y += 85;
              
              _levelInfo.addChild(_levelName);
              _levelInfo.x = (Starling.current.stage.stageWidth - _levelInfo.width) / 2;
              _levelInfo.y = (Starling.current.stage.stageHeight - _levelInfo.height) / 2;
              if (SaveGame.levels[level].score != 0) {
                _scoreInfo = new TextField(120, 40, String(SaveGame.levels[level].score),"kroeger 06_65", 35, Color.WHITE);
                _scoreInfo.hAlign = HAlign.LEFT;
                _scoreInfo.x = _levelInfo.x + 410;
                _scoreInfo.y = _levelInfo.y + 220;
                _levelInfo.addChild(_scoreInfo);
                trace("medal:" + SaveGame.levels[level].medal);	
                if (SaveGame.levels[level].medal) {
                  _medalInfo = new Image(AssetRegistry.ScoringAtlas.getTexture(String(SaveGame.levels[level].medal)));
                  _medalInfo.x = _levelInfo.x + 100;
                  _medalInfo.y = _levelInfo.y + 100;
                  _levelInfo.addChild(_medalInfo);
                }
              }         
              _levelInfo.addEventListener(TouchEvent.TOUCH, function(event:TouchEvent):void
                {
                  var touch:Touch = event.getTouch(that, TouchPhase.ENDED);
                  if (touch)
                  {
                    if(touch.getLocation(_levelInfo).y < _levelInfo.height * 2 / 3) {
                      _showingInfo = false;
                      that.removeChild(_levelInfo);
                    } else {
                      //if (level == 1) {
                       // StageManager.switchStage(AssetRegistry.LEVELS[level - 1], null, "test.flv");
                      //} else {
                       StageManager.switchStage(AssetRegistry.LEVELS[level - 1]);
                      //}
                    }
                  }
                });
              
              that.addChild(_levelInfo);
              
              _showingInfo = true;
            }
          }
          else
          {
            touch = event.getTouch(that, TouchPhase.BEGAN);
            if (touch)
            {
              _slideY = 0;
            }
          }
        }
      }
    }
    
    private function onTouch(event:TouchEvent):void
    {
      if (!_showingInfo)
      {
        var touch:Touch = event.getTouch(_scrollable, TouchPhase.MOVED);
        if (touch)
        {
          _slideY += Math.abs(touch.getMovement(_scrollable).y);
          _scrollable.y += touch.getMovement(_scrollable).y;
          _scrollable.y = Math.min(0, _scrollable.y);
          _scrollable.y = Math.max(-(_bg.height - Starling.current.stage.stageHeight), _scrollable.y);
        }
      }
    }
    

    
    override public function dispose():void {
      AssetRegistry.disposeLevelSelectGraphics();
	  AssetRegistry.disposeScoringGraphics();
      super.dispose();
    }
  
  }

}
