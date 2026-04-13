this.perk_legend_shields_up <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendShieldsUp);
	}

	function onCombatStarted()
	{
		this.skill.onCombatStarted();
		local allies = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());

		foreach( ally in allies )
		{
			local offhand_ally = ally.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (offhand_ally != null && offhand_ally.isItemType(this.Const.Items.ItemType.Shield))
			{
				if (!ally.getSkills().hasEffect(::Legends.Effect.Shieldwall))
				{
					::Legends.Effects.grant(ally, ::Legends.Effect.Shieldwall);
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(ally) + " uses Shieldwall due to the Shields Up perk");
				}

			}
		}
	}

});

