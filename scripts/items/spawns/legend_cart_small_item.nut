this.legend_cart_small_item <- this.inherit("scripts/items/spawns/legend_spawn_item", {
	m = {
		UnleashSounds = [
			"sounds/misc/donkey_idle_01.wav",
			"sounds/misc/donkey_idle_02.wav",
			"sounds/misc/donkey_idle_03.wav"
		]
	},

	function create()
	{
		this.legend_spawn_item.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "spawns.cart_01";
		this.m.Name = "Small cart";
		this.m.Description = "A small cart and donkey, excellent for carrying more things, but must be protected in battle.";
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Icon = "tools/cart_01_70x70n.png";
		this.m.Value = 15000;
		this.m.MedicinePerDay = 0;
	}

	function playInventorySound( _eventType )
	{
		local index = this.Math.rand(1, 16);
		local variant = "" + index;
		if (index < 8){
			variant = "0" + index;
		}
		this.Sound.play("sounds/misc/donkey_idle_" +  variant + ".wav", this.Const.Sound.Volume.Inventory);
	}

});
