::mods_hookExactClass("entity/tactical/enemies/unhold_frost_armored", function(o)
{
	o.assignRandomEquipment = function ()
	{
		this.m.Items.equip(this.new("scripts/items/armor/barbarians/unhold_armor_heavy"));
		local item = ::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.unhold_helmet_heavy]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

	o.onTurnStart = function()
	{
		this.unhold_frost.onTurnStart();

		if (::Time.getRound() >= 2 && !this.m.HasTurned && !this.m.HasBeenWhipped && !::Tactical.State.isAutoRetreat())
		{
			this.m.Skills.getSkillByID("racial.unhold").spawnIcon("status_effect_107", this.getTile());

			if (::Math.rand(1, 100) <= 50)
			{
				this.playSound(::Const.Sound.ActorEvent.Other1, 0.75, ::Math.rand(90, 100) * 0.01);
			}

			if (::Math.rand(1, 100) <= 33)
			{
				this.updateAchievement("FriendOrFoe", 1, 1);
				this.m.HasTurned = true;
				this.setFaction(::Tactical.State.isScenarioMode() ? ::Const.Faction.Beasts : ::World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).getID());
				this.getSprite("socket").setBrush("bust_base_beasts");
			}
		}

		this.m.HasBeenWhipped = false;
	}
});
