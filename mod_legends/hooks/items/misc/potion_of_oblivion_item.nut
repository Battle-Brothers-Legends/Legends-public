::mods_hookExactClass("items/misc/potion_of_oblivion_item", function(o) {
	o.onUse = function ( _actor, _item = null )
	{
		::Sound.play("sounds/combat/drink_03.wav", ::Const.Sound.Volume.Inventory);

		_actor.resetPerks();

		::Const.Tactical.Common.checkDrugEffect(_actor);
		this.updateAchievement("MemoryLoss", 1, 1);
		return true;
	}
});
