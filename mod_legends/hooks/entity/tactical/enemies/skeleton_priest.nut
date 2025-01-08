::mods_hookExactClass("entity/tactical/enemies/skeleton_priest", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Anticipation);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Nimble);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.SteelBrow);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local armor = [
			[1, "ancient/ancient_priest_attire"]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[99, "ancient/ancient_priest_diadem"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath( _killer, _skill, _tile, _fatalityType );
		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

			for( local i = 0; i < n; i = ++i )
			{
				local r = this.Math.rand(1, 100);
				local loot;
				if (r <= 5)
				{
					loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
					loot.drop(_tile);
				}
			}
		}
	}
});
