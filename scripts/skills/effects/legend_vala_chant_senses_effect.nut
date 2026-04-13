this.legend_vala_chant_senses_effect <- this.inherit("scripts/skills/effects/legend_vala_chant", {
	m = {},
	function create()
	{
		this.legend_vala_chant.create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaChantSensesEffect);
		this.m.Range = 3;
	}

	function getTooltip()
	{
		local distance = this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile());
		local bonus = (this.m.Vala.getBravery() / 15.0) + ((this.getContainer().getActor().getFatigueMax() - this.getContainer().getActor().getFatigue()) / 15.0);

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
				text = "[color=%positive%]+" + this.Math.round(bonus) + "[/color] Melee and Ranged Defense"
			}
		];
	}

	function updateEffect( _v)
	{
		if (_v)
		{
			this.m.Name = "Heightened Senses";
			this.m.Icon = "skills/status_effect_73.png";
			this.m.IconMini = "status_effect_73_mini";
			this.m.Overlay = "status_effect_73";
		}
		else
		{
			this.m.Name = "";
			this.m.Icon = "";
			this.m.IconMini = "";
			this.m.Overlay = "";
		}
	}

	function onMovementFinished()
	{
		if (!this.checkEntities())
		{
			this.updateEffect(false);
			return;
		}

		if (!this.isInRange())
		{
			this.updateEffect(false);
			return;
		}

		if (this.getContainer().getActor().getID() != this.m.Vala.getID())
		{
			this.spawnIcon("status_effect_73", this.getContainer().getActor().getTile());
		}

		this.updateEffect(true);
	}


	function onUpdate(_properties)
	{
		if (!this.checkEntities())
		{
			this.updateEffect(false);
			return;
		}

		if (!this.isInRange())
		{
			this.updateEffect(false);
			return;
		}

		local distance = this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile());
		local bonus = (this.m.Vala.getBravery() / 15.0) + ((this.getContainer().getActor().getFatigueMax() - this.getContainer().getActor().getFatigue()) / 15.0);

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

		_properties.MeleeDefense += this.Math.round(bonus);
		_properties.RangedDefense += this.Math.round(bonus);

		this.updateEffect(true);
	}

});
