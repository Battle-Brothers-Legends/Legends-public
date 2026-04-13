this.legend_transformed_wolf_effect <- this.inherit("scripts/skills/effects/legend_transformed_effect", {
	m = {
	},
	function create()
	{
		this.legend_transformed_effect.create();
		this.m.ID = "effect.legend_transformed_wolf";
		this.m.Name = "Wolf Form";
		this.m.Description = "This character is currently a wolf.";
		this.m.Icon = "ui/perks/wolf_circle.png";
		this.m.IconMini = "status_effect_08_mini";
		this.m.Body = "were_wolf_body";
		this.m.Head = "were_wolf_head_0" + this.Math.rand(1, 3);
	}

	function getTooltip()
	{
		local ret = this.legend_transformed_effect.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]-1[/color] Action Point per tile moved"
			}
		]);

		return ret;

	}

	function setSkills()
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().add(this.new("scripts/skills/actives/legend_werewolf_bite_skill"));
		::Legends.Actives.grant(this, ::Legends.Active.LegendWerewolfClaws);
		::Legends.Actives.grant(this, ::Legends.Active.Footwork);
	}

	function removeSkills()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendWerewolfClaws);
		::Legends.Actives.remove(this, ::Legends.Active.WerewolfBite);
		if (!this.getContainer().hasPerk(::Legends.Perk.Footwork))
		{
			::Legends.Actives.remove(this, ::Legends.Active.Footwork);
		}
	}

	function onUpdate( _properties )
	{
		_properties.MovementAPCostAdditional += -1;
		_properties.MovementFatigueCostMult *= 0.5;
		_properties.HitpointsMult *= 2.0;
		_properties.MeleeDefenseMult *= 2.0;
	}


});

