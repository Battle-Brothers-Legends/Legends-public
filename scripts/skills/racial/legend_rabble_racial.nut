this.legend_rabble_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.legend_rabble";
		this.m.Name = "Coerced";
		this.m.Description = "";
		this.m.Icon = "skills/status_effect_86.png";
		this.m.IconMini = "status_effect_86_mini";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Racial | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getBandits()
	{
		local user = this.getContainer().getActor();
		local bandits = 0;
		local actors = ::Tactical.Entities.getInstancesOfFaction(user.getFaction());
		foreach( i in actors )
		{

			if (i.getType() == ::Const.EntityType.BanditThug || i.getType() == ::Const.EntityType.BanditPoacher || i.getType() == ::Const.EntityType.BanditMarksman || i.getType() == ::Const.EntityType.BanditRaider || i.getType() == ::Const.EntityType.BanditMarauder || i.getType() == ::Const.EntityType.LegendRobberBaron)
			{
				bandits += 1;

			}

		}
		return bandits;
	}

	function onUpdate( _properties ) {	
		local bandits = this.getBandits();
		local bonus = 2 * bandits;

		if (bandits >= 1)
		{
			_properties.IsAffectedByDyingAllies = false;
			_properties.IsAffectedByFleeingAllies = false;
			_properties.Bravery += bonus;
		}

		if (bandits < 1 )
		{
			_properties.IsAffectedByDyingAllies = true;
			_properties.IsAffectedByFleeingAllies = true;
		}
	}

});

