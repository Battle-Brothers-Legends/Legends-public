this.legend_zombie_item <- this.inherit("scripts/items/spawns/legend_spawn_item", {
	m = {
		UnleashSounds = [
			"sounds/enemies/geist_idle_10.wav",
			"sounds/enemies/geist_idle_11.wav",
			"sounds/enemies/geist_idle_12.wav"
		]
	},

	function create()
	{
		this.legend_spawn_item.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "spawns.zombie";
		this.m.Name = "Human Carrion";
		this.m.Description = "A heap of human offal; limbs, skin, and gore, all salvaged from your fellow man, the perfect medium for your grim work. Requires constant preservation as the encroaching rot threatens to stall your efforts.";
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Icon = "supplies/human_carrion.png";
		this.m.Value = 100;
		this.m.MedicinePerDay = 2;
	}

	function playInventorySound( _eventType )
	{
		local index = this.Math.rand(1, 16);
		local variant = "" + index;
		if (index < 10){
			variant = "0" + index;
		}
		this.Sound.play("sounds/enemies/zombie_idle_" +  variant + ".wav", this.Const.Sound.Volume.Inventory);
	}

});
