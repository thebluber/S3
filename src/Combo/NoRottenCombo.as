package Combo
{
  public class NoRottenCombo extends Combo {
    public function NoRottenCombo() {
      super();
      repeat = true;
      trigger = [EggTypes.EGGC, EggTypes.EGGC, EggTypes.EGGC];
    }
    
    override public function effect(state:LevelState):void {
      state.rottenEggs.clear();
      state.showMessage("No Rotten Eggs!");
    }
  }
}