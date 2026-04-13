//Author: WNTR Jimmy
this.perk_legend_night_raider <- this.inherit("scripts/skills/skill", {
    m = {},

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendNightRaider);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
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
	// 	if (this.getContainer().hasEffect(::Legends.Effect.Night) && _properties.IsAffectedByNight == true)
	// }

	function onUpdate( _properties )
	{
	    _properties.IsAffectedByNight = false;
	    if (!this.World.getTime().IsDaytime)
	    {
	        _properties.Threat += 10;
	        _properties.Vision += 1;
	        _properties.MeleeSkill *= 1.10;
	        _properties.RangedSkill *= 1.10;
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
	// 	if (actor.getSkills().hasEffect(::Legends.Effect.Night))
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
