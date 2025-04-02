this.legend_RSS_radiance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRssRadiance);
		this.m.Description = "Rune Sigil: Radiance";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}


	function onMovementFinished()
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		if (actor == null)
		{
			return;
		}
		if (this.getItem() == null)
		{
			return;
		}
		local targets = this.Tactical.Entities.getAllInstances();

		foreach (tar in targets)
		{
			foreach (t in tar)
			{
				if (!t.isAlliedWith(actor) && t.getSkills().hasEffect(::Legends.Effect.LegendRssRadianceEffect) && t.getTile().getDistanceTo(actor.getTile()) == 1 &&  this.Math.abs(t.getTile().Level - myTile.Level))
				{
					local NewMalus = ::Legends.Effects.get(t, ::Legends.Effect.LegendRssRadianceEffect);
					NewMalus.setMalus(this.getItem().getRuneBonus1(), this.getItem().getRuneBonus2());
					t.getSkills().update();
					this.spawnIcon("status_effect_52", t.getTile());
				}
			}
		}
	}


	function applyRadianceFoundation()
	{
		if (this.getItem() == null)
		{
			return;
		}
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return;
		}
		local targets = this.Tactical.Entities.getAllInstances();

		foreach (tar in targets)
		{
			foreach (t in tar)
			{
				if (!t.isAlliedWith(actor) && !t.getSkills().hasEffect(::Legends.Effect.LegendRssRadianceEffect))
				{
					::Legends.Effects.grant(t, ::Legends.Effect.LegendRssRadianceEffect, function(_effect) {
						_effect.setMalus(this.getItem().getRuneBonus1(), this.getItem().getRuneBonus2());
					}.bindenv(this));
				}
			}
		}
	}


	function onTurnStart()
	{
		this.applyRadianceFoundation();
	}


	function onCombatStarted()
	{
		this.applyRadianceFoundation();
	}


	function onUpdate (_properties)
	{
	}
});
