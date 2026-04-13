this.legend_vala_chant_disharmony_effect <- this.inherit("scripts/skills/effects/legend_vala_chant", {
	m = {},
	function create()
	{
		this.legend_vala_chant.create();
		this.m.Range = 3;
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaChantDisharmonyEffect);
	}

	function getTooltip()
	{
		local distance = this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile());
		local bonus = ((this.m.Vala.getFatigueMax() - this.m.Vala.getFatigue()) / 15.0) + this.m.Vala.getBravery() / 15.0;

		if (this.isMastered())
		{
			bonus *= 1.1;
		}

		if (distance == 2)
		{
			bonus *= 0.75;
		}
		else if (distance == 3)
		{
			bonus *= 0.5;
		}

		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Unable to enforce Zones of Control"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%negative%]-" + this.Math.round(bonus) + "%[/color] Initiative"
			}
		];
	}

	function onUpdate(_properties)
	{
		local distance = this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile());
		if (!this.checkEntities())
		{
			this.updateEffect(false, distance);
			return;
		}

		if (!this.isInRange())
		{
			this.updateEffect(false, distance);
			return;
		}

		local bonus = ((this.m.Vala.getFatigueMax() - this.m.Vala.getFatigue()) / 15.0) + this.m.Vala.getBravery() / 15.0;

		if (this.isMastered())
		{
			bonus *= 1.1;
		}

		if (distance == 2)
		{
			bonus *= 0.75;
		}
		else if (distance == 3)
		{
			bonus *= 0.5;
		}

		_properties.Initiative *= 1.0 - 0.01 * this.Math.round(bonus);

		this.updateEffect(true, distance);
	}

	function updateEffect(_v, _distance)
	{
		if (_v)
		{
			if (_distance == 2)
			{
				this.getContainer().getActor().m.IsUsingZoneOfControl = false;
			}
			else
			{
				this.getContainer().getActor().m.IsUsingZoneOfControl = true;
			}
			this.m.Name = "Disharmony";
			this.m.Icon = "skills/status_effect_65.png";
			this.m.IconMini = "status_effect_65_mini";
			this.m.Overlay = "status_effect_65";
		}
		else
		{
			this.getContainer().getActor().m.IsUsingZoneOfControl = true;
			this.m.Name = "";
			this.m.Icon = "";
			this.m.IconMini = "";
			this.m.Overlay = "";
		}
	}

	function onMovementFinished()
	{
		if (this.getContainer().getActor() == null)
			return;

		local distance = this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile());
		if (!this.checkEntities())
		{
			this.updateEffect(false, distance);
			return;
		}

		if (!this.isInRange())
		{
			this.updateEffect(false, distance);
			return;
		}

		this.spawnIcon("status_effect_65", this.getContainer().getActor().getTile());
		this.updateEffect(true, distance);
	}

	function onRemoved()
	{
		this.getContainer().getActor().m.IsUsingZoneOfControl = true;
		this.getContainer().getActor().onSkillsUpdated();
	}

	function onDeath( _fatalityType )
	{
		this.getContainer().getActor().m.IsUsingZoneOfControl = true;
	}

	function onCombatFinished()
	{
		this.getContainer().getActor().m.IsUsingZoneOfControl = true;
		this.removeSelf();
	}
});
