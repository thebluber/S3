package Combo
{
  import Level.LevelState;
  import engine.AssetRegistry;
  
  public class ExtraTimeCombo extends Combo {
    public function ExtraTimeCombo() {
      super();
      repeat = true;
      trigger = [AssetRegistry.EGGB, AssetRegistry.EGGB, AssetRegistry.EGGB];
    }
    
    override public function effect(state:LevelState):void {
      state.timeLeft += 3;
      state.showMessage("Bonus Time!");
    }
  }
}