this.legend_transformed_rat_effect <- this.inherit("scripts/skills/effects/legend_transformed_effect", {
	m = {
	},
	function create()
	{
		this.legend_transformed_effect.create()
		this.m.ID = "effect.legend_transformed_rat";
		this.m.Name = "Rat Form";
		this.m.Description = "This character is currently a rat.";
		this.m.Icon = "ui/perks/rat_circle.png";
		this.m.IconMini = "status_effect_08_mini";
		local r = this.Math.rand(1, 5);
		this.m.Head = "bust_rat_head_0" + r;
		this.m.Body = "bust_rat_body_0" + r;
	}

	function getTooltip()
	{
		local ret = this.legend_transformed_effect.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Action Points"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Poison bite"
			}
		]);
		return ret;
	}

	function setSkills()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getSkills().hasSkill("actives.legend_rat_claws"))
		{
			actor.getSkills().add(this.new("scripts/skills/actives/legend_rat_claws_skill"));
		}
		if (!actor.getSkills().hasSkill("actives.legend_rat_bite"))
		{
			actor.getSkills().add(this.new("scripts/skills/actives/legend_rat_bite_skill"));
		}
		if (!actor.getSkills().hasSkill("racial.spider"))
		{
			actor.getSkills().add(this.new("scripts/skills/racial/spider_racial"));
		}
		if (!actor.getSkills().hasSkill("actives.footwork"))
		{
			actor.getSkills().add(this.new("scripts/skills/actives/footwork"));
		}
	}

	function removeSkills()
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().removeByID("actives.legend_rat_claws");
		actor.getSkills().removeByID("actives.legend_rat_bite");
		actor.getSkills().removeByID("racial.spider");
		if (!actor.getSkills().hasPerk(::Legends.Perk.Footwork))
		{
			actor.getSkills().removeByID("actives.footwork");
		}
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += 3;
		_properties.BraveryMult *= 0.5;
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (("State" in this.Tactical) && this.Tactical.State != null && this.Tactical.State.isScenarioMode())
		{
			return;
		}

		if (this.getContainer().getActor().isPlacedOnMap() && this.Tactical.State.isAutoRetreat() && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID())
		{
			_properties.MeleeDefense += 25;
		}
	}

});

