::mods_hookExactClass("entity/tactical/enemies/skeleton_lich", function(o) 
{
	o.onFactionChanged <- function ()
	{
		this.skeleton.onFactionChanged();
	}

	// local onDeath = o.onDeath;
	// o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	// {
	// 	onDeath( _killer, _skill, _tile, _fatalityType );
	// 	if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
	// 	{
	// 		local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

	// 		for( local i = 0; i < n; i = ++i )
	// 		{
	// 			for (local v = 0; v < 5; ++v)
	// 			{
	// 				local loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
	// 				loot.drop(_tile);
	// 			}
	// 		}
	// 	}
	// }

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.addSprite("armor_layer_chain");
		this.addSprite("armor_layer_plate");
		this.addSprite("armor_layer_tabbard");
		this.addSprite("armor_layer_cloak");
		this.addSprite("armor_upgrade_back");
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
		}
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
	}

	o.assignRandomEquipment = function ()
	{
		local armor = [
			[1, "ancient/ancient_lich_attire"]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);
		local helmet = [
			[1, "ancient/ancient_lich_headpiece"]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});