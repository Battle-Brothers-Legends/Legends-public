::mods_hookExactClass("entity/tactical/enemies/ghoul", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendMuscularity);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.KillingFrenzy);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.onAfterDeath = function ( _tile )
	{
		if (this.m.Size < 3)
		{
			return;
		}

		local skill = this.getSkills().getSkillByID("actives.swallow_whole");

		if (skill.getSwallowedEntity() == null)
		{
			return;
		}

		local e = skill.getSwallowedEntity();
		this.Tactical.addEntityToMap(e, _tile.Coords.X, _tile.Coords.Y);
		e.getFlags().set("Devoured", false);
		if (e.getFlags().has("IsSummoned"))
		{
			return
		}
		local slime = e.getSprite("dirt");
		slime.setBrush("bust_slime");
		slime.Visible = true;
	}
});
