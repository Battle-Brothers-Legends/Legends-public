this.legend_bog_unhold_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.legend_bog_unhold";
		this.m.Name = "Unhold Passive";
		this.m.Description = "TODO";
		this.m.Icon = "skills/status_effect_79.png";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/unhold_regenerate", 3);
		this.m.Type = ::Const.SkillType.Racial;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = ::Math.min(healthMissing, ::Math.floor(actor.getHitpointsMax() * 0.15));

		if (healthAdded <= 0)
		{
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.spawnIcon("status_effect_79", actor.getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			}

			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

});
