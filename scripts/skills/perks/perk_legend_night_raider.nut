//Author: WNTR Jimmy
this.perk_legend_night_raider <- this.inherit("scripts/skills/skill", {
    m = {}, 

	function create()
	{
		this.m.ID = "perk.legend_night_raider"; 
		this.m.Name = this.Const.Strings.PerkName.LegendNightRaider;
		this.m.Description = this.Const.Strings.PerkDescription.LegendNightRaider;
		this.m.Icon = "ui/perks/night_raider.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded() // make this perk work when added to non-player
	{
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			this.onCombatStarted();
		}
	}

	// function isHidden()
	// {
	// 	//return !this.m.IsBattleStart || this.World.getTime().IsDaytime;
	// 	if (this.getContainer().hasSkill("special.night") && _properties.IsAffectedByNight == true)
	// }

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (this.getContainer().hasSkill("special.night") && _properties.IsAffectedByNight == true)
		{
			_properties.Threat += 10;
			_properties.Vision += 1;
			_properties.MeleeSkill *= 1.10;
			_properties.RangedSkill *= 1.10;
			!_properties.IsAffectedByNight;
		}
	}

	// function onCombatStarted()
	// {
	// 	this.m.IsBattleStart = true;
	// }

	// function onCombatFinished()
	// {
	// 	this.m.IsBattleStart = false;
	// }

	// function onUpdate(_properties)
	// {
	// 	local actor = this.getContainer().getActor();
	// 	if (actor.getSkills().hasSkill("special.night"))
	// 	{
	// 		_properties.Threat += 10;
	// 		_properties.Vision += 1;
	// 		_properties.MeleeSkill *= 1.10;
	// 		_properties.RangedSkill *= 1.10;
	// 		!_properties.IsAffectedByNight;
	// 	}
	// }

    // function onUpdate(_properties)
    // {
	//     local effect = new("scripts/skills/effects/night_effect");
	//     if(this.getContainer().getActor().hasSkill(effect)){
	// 	this.getSkills().hasSkill(effect).IsAffectedByNight == false;
	// 	_properties.Threat += 10;
	// 	_properties.Vision += 1;
	// 	_properties.MeleeSkill *= 1.10;
	// 	_properties.RangedSkill *= 1.10;
	// 	// !_properties.IsAffectedByNight;
	// }

}); 
