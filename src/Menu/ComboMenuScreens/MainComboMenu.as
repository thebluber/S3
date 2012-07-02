package Menu.ComboMenuScreens
{
  import flash.security.SignatureStatus;
  import mx.core.ButtonAsset;
  import org.josht.starling.display.Image;
  import org.josht.starling.foxhole.controls.Screen;
  import org.osflash.signals.Signal;
  import starling.display.Button;
  import engine.AssetRegistry;
  import org.osflash.signals.ISignal;
  import starling.display.Quad;
  import starling.events.Event;
  import starling.utils.Color;
  import starling.core.Starling;
  import engine.StageManager;
  import Level.ArcadeState;
  import engine.SaveGame;
  
  /**
   * ...
   * @author
   */
  public class MainComboMenu extends Screen
  {
    
    protected var _onComboSelect:Signal = new Signal(MainComboMenu);
    protected var _sharedData:Object = {};
    
    public function MainComboMenu()
    {
      super();
    }
    
    override protected function initialize():void
    {
      
      //var greybox:Image = new Image(AssetRegistry.MenuAtlas.getTexture("arcade-box-710"));
      var greybox:Quad = new Quad(710, 450, Color.BLACK);
      greybox.alpha = 0.3;
      greybox.x = 65 + 60;
      greybox.y = 40 + 30;
      
      addChild(greybox);
      
      addSwitchers();
      addButtons();
      addNormalCombos();
    }
    
    private function addSwitchers():void
    {
      var play:Button = new Button(AssetRegistry.MenuAtlas.getTexture("text_play"));
      play.x = 65 + 60;
      play.y = 540;
      addChild(play);
      play.addEventListener(Event.TRIGGERED, function(event:Event):void
        {
          StageManager.switchStage(ArcadeState);
        });
    }
    
    private function addNormalCombos():void
    {
      /*
         var _comboSpeedSprite:AxSprite = new MenuButton(96 + 60, 352 + 30, 0, _comboSpeed, showScreen("InfoBoxSpeed"));
         var _comboTimeSprite:AxSprite = new MenuButton(96 + 60 + 112, 352 + 30,0, _comboTime, showScreen("InfoBoxTime"));
         var _comboFouleggsSprite:AxSprite = new MenuButton(96 + 60 + (2 * 112), 352 + 30,0, _comboFouleggs, showScreen("InfoBoxRotten"));
         var _comboShuffleSprite:AxSprite = new MenuButton(96 + 60 + (3 * 112), 352 + 30, 0,_comboShuffle,showScreen("InfoBoxShuffle"));
         var _comboGoldSprite:AxSprite = new  MenuButton(96 + 60 + (4 * 112), 352 + 30,0, _comboGold,showScreen("InfoBoxGold"));
         var _comboXtralifeSprite:AxSprite = new MenuButton(96 + 60 + (5 * 112), 352 + 30,0, _comboXtralife, showScreen("InfoBoxXtralife"));
       */
      
      var buttons:Array = [[AssetRegistry.MenuAtlas.getTexture("combo-speed"), AssetRegistry.MenuAtlas.getTexture("info-speed")], [AssetRegistry.MenuAtlas.getTexture("combo-time"), AssetRegistry.MenuAtlas.getTexture("info-time")], [AssetRegistry.MenuAtlas.getTexture("combo-rotteneggs"), AssetRegistry.MenuAtlas.getTexture("info-rotteneggs")], [AssetRegistry.MenuAtlas.getTexture("combo-shuffle"), AssetRegistry.MenuAtlas.getTexture("info-shuffle")], [AssetRegistry.MenuAtlas.getTexture("combo-gold"), AssetRegistry.MenuAtlas.getTexture("info-gold")], [AssetRegistry.MenuAtlas.getTexture("combo-xtralife"), AssetRegistry.MenuAtlas.getTexture("info-xtralife")]];
      
      for (var i:int = 0; i < buttons.length; i++)
      {
        var button:Button = new Button(buttons[i][0]);
        button.x = 96 + 60 + 112 * i;
        button.y = 382;
        addChild(button);
        
        var desc:Button = new Button(buttons[i][1]);
        desc.x = (Starling.current.stage.stageWidth - desc.width) / 2;
        desc.y = (Starling.current.stage.stageHeight - desc.height) / 2;
        desc.scaleWhenDown = 1;
        
        var that = this;
        var f:Function = function(desc:Button):void
        {
          button.addEventListener(Event.TRIGGERED, function(event:Event):void
            {
              that.addChild(desc);
            });
          
          desc.addEventListener(Event.TRIGGERED, function(event:Event):void
            {
              that.removeChild(desc);
            });
        };
        f(desc);
      }
    /*
       var comboSpeed:Button = new Button(AssetRegistry.MenuAtlas.getTexture("combo-speed"));
       buttons.push(comboSpeed);
    
       var comboTime:Button = new Button(AssetRegistry.MenuAtlas.getTexture("combo-time"));
       buttons.push(comboTime);
    
       var comboRotteneggs:Button = new Button(AssetRegistry.MenuAtlas.getTexture("combo-rotteneggs"));
     buttons.push(comboRotteneggs);*/
    
    }
    
    private function addButtons():void
    {
      for (var i:int = 0; i < 3; i++)
      {
        var slot:Button;
        
        if (SaveGame.specials[i])
        {
          slot = new Button(AssetRegistry.MenuAtlas.getTexture(SaveGame.specials[i].effect));
          if (SaveGame.specials[i].combo)
          {
            trace(SaveGame.specials[i].combo);
            
            var combo:Image = new Image(AssetRegistry.MenuAtlas.getTexture(SaveGame.specials[i].combo));
            combo.x = 0;
            combo.y = 0;
            slot.addChild(combo);
          }
        }
        else
        {
          slot = new Button(AssetRegistry.MenuAtlas.getTexture("combo-special"));         
        }
        addChild(slot);
       
        slot.x = 165 + 60 + i * 202;
        slot.y = 112 + 30;
        slot.addEventListener(Event.TRIGGERED, buttonSelector(i));
      }
    }
    
    protected function buttonSelector(slot:int):Function
    {
      var that = this;
      
      return function(event:Event):void
      {
        sharedData.selected = slot;
        onComboSelect.dispatch(that);
      }
    }
    
    public function get onComboSelect():ISignal
    {
      return _onComboSelect;
    }
    
    public function get sharedData():Object
    {
      return _sharedData;
    }
    
    public function set sharedData(value:Object):void
    {
      _sharedData = value;
    }
  }

}