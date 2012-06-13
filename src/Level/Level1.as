package Level 
{
	/**
     * ...
     * @author 
     */
  import engine.AssetRegistry
  import starling.display.Image;
  import starling.display.BlendMode;
  
  public class Level1 extends LevelState 
  {
    public function Level1() 
    {
      AssetRegistry.loadLevel1Graphics();
      _levelNr = 1;
      super();
    }
    
    override protected function addBackground():void {
      _bgTexture = AssetRegistry.Level1Background;
      _bg = new Image(_bgTexture);
      _bg.blendMode = BlendMode.NONE;
      _levelStage.addChild(_bg);
      _tileHeight = _bg.height / AssetRegistry.TILESIZE;
      _tileWidth = _bg.width / AssetRegistry.TILESIZE;
    }
    
    override public function dispose():void {
      AssetRegistry.disposeLevel1Graphics();
      super.dispose();
    }
     
    override protected function checkWin():void {
      if (_snake.eatenEggs == 50) {
        win();
      }
    }
    
    override protected function addObstacles():void {
      var positions:Array = [
        []
      ];
      
    }
  }

}