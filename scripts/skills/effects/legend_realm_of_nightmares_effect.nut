this.legend_realm_of_nightmares_effect <- this.inherit("scripts/skills/skill", {
	m = {
		LastRoundApplied = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRealmOfNightmares);
		this.m.Description = "The boundary to the world of dreams is erased where this character stands, and nightmares may manifest here to eat away at their sanity. Nightmares always hit with a mental attack that ignores armor but inflicts less damage against targets with more Resolve.";
		this.m.Icon = "skills/status_effect_102.png";
		this.m.IconMini = "status_effect_102_mini";
		this.m.Overlay = "status_effect_102";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}


	function isHidden()
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap())
			return true;

		local myTile = this.getContainer().getActor().getTile();

		if (myTile == null || !("Properties" in myTile))
			return true;

		if (myTile.Properties == null || !("Effect" in myTile.Properties))
			return true;

		if (myTile.Properties.Effect == null || !("Timeout" in myTile.Properties.Effect) || !("Type" in myTile.Properties.Effect))
			return true;

		if (myTile.Properties.Effect.Timeout == this.Time.getRound() || myTile.Properties.Effect.Type != "shadows")
			return true;

		return false;
	}

});

