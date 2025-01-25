this.legend_vala_threads_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Threads = 1
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaThreadsEffect);
		this.m.Icon = "skills/status_effect_78.png";
		this.m.IconMini = "status_effect_78_mini";
		this.m.Overlay = "status_effect_78";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function isHidden()
	{
		return false;
	}


	function getName()
	{
		return this.m.Name + " (x" + this.m.Threads + ")";
	}


	function getTooltip()
	{
		if (!this.isHidden())
		{
			return [
				{
					id = 1,
					type = "title",
					text = this.getName()
				}
			];
		}
		else
		{
			return;
		}
	}


	function onUpdate( _properties )
	{
		if (this.m.Threads > 5)
		{
			this.m.Threads = 5;
		}

		_properties.HitpointsMult *= 1.0 - (this.m.Threads / 10.0);
		_properties.DamageReceivedTotalMult *= 1.0 + (this.m.Threads / 10.0);
	}


	function onRefresh()
	{
		if (this.m.Threads < 5)
		{
			++this.m.Threads;
			this.spawnIcon("status_effect_78", this.getContainer().getActor().getTile());
		}
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});
