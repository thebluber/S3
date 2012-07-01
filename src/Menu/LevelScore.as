package Menu
{
  import com.gskinner.motion.easing.Exponential;
  import com.gskinner.motion.GTween;
  import engine.AssetRegistry;
  import engine.ManagedStage;
  import engine.SaveGame;
  import engine.StageManager;
  import starling.events.Event;
  
  import flash.events.Event;
  import starling.display.Button;
  import starling.display.Image;
  import starling.events.EnterFrameEvent;
  import starling.text.TextField;
  import starling.utils.Color;
  import starling.utils.HAlign;
  import flash.net.*;
  import JSON;
  
  
  /**
   * ...
   * @author
   */
  public class LevelScore extends ManagedStage
  {
    
    private var _bg:Image;
    private var _scoreboard:Image;
    private var _leaderboard:Image;
    private var _replayButton:Button;
    private var _nextLevelButton:Button;
    private var _backToMenuButton:Button;

    private var _scorePic:Image;
    private var _scoreText:TextField;
    public var _scoreCounter:int = 0;

    private var _timeBonusPic:Image;
    private var _timeBonusText:TextField;
    public var _timeBonusCounter:int = 0;

    private var _lifeBonusPic:Image;
    private var _lifeBonusText:TextField;
    public var _lifeBonusCounter:int = 0;
   
    private var _EXPText:TextField;
    public var _EXPCounter:int;

    private var _totalText:TextField;
    public var _totalCounter:int;

    private var _scores:Object = null;
    
    public function LevelScore(scores:Object = null)
    {
      _scores = scores;
      if (_scores == null)
      {
        _scores = {score: 1000, lives: 3, time: 200, level: 1, total: 0, EXP: 0}
      }
      else
      {
        SaveGame.saveScore(_scores.level, _scores.score);
      }
      
      AssetRegistry.loadScoringGraphics();
      buildMenu();
      startScoring();
      updateLeaderboard();
    }
    
    private function updateLeaderboard():void
    {
      var url:String = "https://www.scoreoid.com/api/getBestScores";
      var request:URLRequest = new URLRequest(url);
      var requestVars:URLVariables = new URLVariables();
      request.data = requestVars;      
      requestVars.api_key = "7bb1d7f5ac027ae81b6c42649fddc490b3eef755";
      requestVars.game_id = "5UIVQJJ3X";      
      requestVars.response = "JSON"
      requestVars.order_by = "score";
      requestVars.order = "desc";
      requestVars.limit = 10;
      requestVars.difficulty = _scores.level;
      
      request.method = URLRequestMethod.POST;
      
      var loading:TextField = new TextField(300, 50, "Loading...", "kroeger 06_65", 30, 0xffffff);
      loading.hAlign = HAlign.LEFT;
      loading.x = _leaderboard.x + 20;
      loading.y = _leaderboard.y + 50;
      addChild(loading);
      
      var loaderCompleteHandler:Function = function(event:flash.events.Event):void {
        trace(event.target.data);
        removeChild(loading);
        var result:Object = JSON.parse(event.target.data);
        if (result.error) {
          return;
        }
        var data:Array = result as Array;
        
        var pos:int = 0;
        for (var i:int = 0; i < data.length; i++) {
          var score:Object = data[i];
          var text:TextField = new TextField(300, 50, "", "kroeger 06_65", 30, 0xffffff);
          text.hAlign = HAlign.LEFT;
          text.text = String(1 + i) + ". " + score.Player.username + ": " + String(score.Score.score);
          text.x = _leaderboard.x + 20;
          text.y = _leaderboard.y + 50 + i * 30;
          addChild(text);
        }
      }
      
      
      
      
      var urlLoader:URLLoader = new URLLoader();
      urlLoader = new URLLoader();
      urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
      urlLoader.addEventListener(flash.events.Event.COMPLETE, loaderCompleteHandler);
      
      urlLoader.load(request);
    }
    
    private function buildMenu():void
    {
      addBackground();
      addBoards();
      addTexts();
      addButtons();
    }
    
    private function startScoring():void
    {
      addEventListener(EnterFrameEvent.ENTER_FRAME, updateTexts);
      var triggerLife:Function = function(tween:GTween):void{
        new GTween(this, 2, {_lifeBonusCounter: _scores.lives}, {ease: Exponential.easeOut, onComplete:triggerTime});
      }
      var triggerTime:Function = function(tween:GTween):void{
        new GTween(this, 2, {_timeBonusCounter: _scores.time}, {ease: Exponential.easeOut, onComplete:triggerTotal});
      }
      var triggerTotal:Function = function(tween:GTween):void{
        new GTween(this, 2, {_totalCounter: _scores.total}, {ease: Exponential.easeOut, onComplete:triggerEXP});
      }
      var triggerEXP:Function = function(tween:GTween):void{
        new GTween(this, 2, {_EXPCounter: _scores.EXP}, {ease: Exponential.easeOut});
      }
      
      new GTween(this, 2, {_scoreCounter: _scores.score}, {ease: Exponential.easeOut, onComplete:triggerLife});
    /*
       var tweenScore:GTween = new GTween(_scoreCounter, 2, {i: _score}, {ease: Exponential.easeOut});
       var tweenLive:GTween = new GTween(_lifeBonusCounter, 2, {i: _liveBonus}, {ease: Exponential.easeOut});
       var tweenTime:GTween = new GTween(_BCounter, 2, {i: _timeBonus}, {ease: Exponential.easeOut});
     var tweenEXP:GTween = new GTween(_EXPCounter, 2, {i: _EXP}, {ease: Exponential.easeOut});  */
    }
    
    private function updateTexts(event:EnterFrameEvent):void
    {
      _lifeBonusText.text = String(_lifeBonusCounter);
      _timeBonusText.text = String(_timeBonusCounter);
      _scoreText.text = String(_scoreCounter);
    }
    
    private function addTexts():void
    {
      _lifeBonusText = new TextField(100, 35, "1", "kroeger 06_65", 35, Color.WHITE);
      _lifeBonusText.hAlign = HAlign.RIGHT;
      _lifeBonusText.x = _lifeBonusPic.x + _lifeBonusPic.width + 10;
      _lifeBonusText.y = _lifeBonusPic.y - 10;
      
      _scoreText = new TextField(100, 35, "1", "kroeger 06_65", 35, Color.WHITE);
      _scoreText.hAlign = HAlign.RIGHT;
      _scoreText.x = _lifeBonusText.x;
      _scoreText.y = _scorePic.y - 10;
      
      _timeBonusText = new TextField(100, 35, "1", "kroeger 06_65", 35, Color.WHITE);
      _timeBonusText.hAlign = HAlign.RIGHT;
      _timeBonusText.x = _lifeBonusText.x;
      _timeBonusText.y = _timeBonusPic.y - 10;
      
      _totalText = new TextField(100, 35, "1", "kroeger 06_65", 35, Color.WHITE);
      _totalText.hAlign = HAlign.RIGHT;
      _totalText.x = _lifeBonusPic.x + 120;
      _totalText.y = _lifeBonusText.y + 77;

      addChild(_lifeBonusText);
      addChild(_scoreText);
      addChild(_timeBonusText);
      addChild(_totalText);
      addChild(_EXPText);
    }
    
    private function replay():void
    {
      StageManager.switchStage(AssetRegistry.LEVELS[_scores.level - 1]);
    }
    
    private function nextLevel():void
    {
      StageManager.switchStage(AssetRegistry.LEVELS[_scores.level]);
    }
    
    private function backToMenu():void
    {
      StageManager.switchStage(MainMenu);
    }
    
    private function addButtons():void
    {
      _replayButton = new Button(AssetRegistry.ScoringAtlas.getTexture("menu-egg-redo"));
      _replayButton.downState = AssetRegistry.ScoringAtlas.getTexture("menu-egg-redo-broken");
      _replayButton.x = 960 / 2 - 145 / 2;
      _replayButton.y = 460;
      
      _replayButton.addEventListener(starling.events.Event.TRIGGERED, replay);
      
      _nextLevelButton = new Button(AssetRegistry.ScoringAtlas.getTexture("menu-egg-next"));
      _nextLevelButton.downState = AssetRegistry.ScoringAtlas.getTexture("menu-egg-next-broken");
      _nextLevelButton.x = 960 / 2 + 145 / 2 + 30;
      _nextLevelButton.y = _replayButton.y + 30;
      
      _nextLevelButton.addEventListener(starling.events.Event.TRIGGERED, nextLevel);
      
      _backToMenuButton = new Button(AssetRegistry.ScoringAtlas.getTexture("menu-egg-back"));
      _backToMenuButton.downState = AssetRegistry.ScoringAtlas.getTexture("menu-egg-back-broken");
      _backToMenuButton.x = 960 / 2 - 145 / 2 - 30 - 135;
      _backToMenuButton.y = _nextLevelButton.y;
      
      _backToMenuButton.addEventListener(starling.events.Event.TRIGGERED, backToMenu);
      
      addChild(_replayButton);
      if(_scores.level != 9) {
        addChild(_nextLevelButton);
      }
      addChild(_backToMenuButton);
    }
    
    private function addBackground():void
    {
      _bg = new Image(AssetRegistry.ScoringAtlas.getTexture("menu_iphone_background"));
      addChild(_bg);
    }
    
    private function addBoards():void
    {
      _scoreboard = new Image(AssetRegistry.ScoringAtlas.getTexture("score board"));
      _scoreboard.x = 70;
      _scoreboard.y = 30;
      
      _leaderboard = new Image(AssetRegistry.ScoringAtlas.getTexture("leaderboard"));
      _leaderboard.x = _scoreboard.width + 140;
      _leaderboard.y = _scoreboard.y;
      
      _scorePic = new Image(AssetRegistry.ScoringAtlas.getTexture("score"));
      _scorePic.x = _scoreboard.x + 20;
      _scorePic.y = _scoreboard.y + 80;
      
      _timeBonusPic = new Image(AssetRegistry.ScoringAtlas.getTexture("time bonus"));
      _timeBonusPic.x = _scorePic.x;
      _timeBonusPic.y = _scorePic.y + _scorePic.height + 20;
      
      _lifeBonusPic = new Image(AssetRegistry.ScoringAtlas.getTexture("life bonus"));
      _lifeBonusPic.x = _timeBonusPic.x;
      _lifeBonusPic.y = _timeBonusPic.y + _timeBonusPic.height + 20;
      
      addChild(_scoreboard);
      addChild(_leaderboard);
      
      addChild(_scorePic);
      addChild(_timeBonusPic);
      addChild(_lifeBonusPic);
    }
    
    override public function dispose():void
    {
      AssetRegistry.disposeScoringGraphics();
    }
  }

}
