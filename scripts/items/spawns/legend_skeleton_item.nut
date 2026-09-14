this.legend_skeleton_item <- this.inherit("scripts/items/spawns/legend_spawn_item", {
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
		this.m.ID = "spawns.skeleton";
		this.m.Name = "Human Bones";
		this.m.Description = "A pile of human bones picked perfectly clean. They creak and shudder at your presence, somehow conscious that you hold the power to rouse them once again. Requires diligent maintenance as brittle bones make poor means for your ends.";
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Icon = "supplies/human_bones.png";
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
