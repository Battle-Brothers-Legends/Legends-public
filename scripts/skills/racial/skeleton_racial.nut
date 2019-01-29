this.skeleton_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.skeleton";
		this.m.Name = "Resistant to Ranged Attacks";
		this.m.Description = "";
		this.m.Icon = "ui/perks/perk_32.png";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill.getID() == "actives.aimed_shot" || _skill.getID() == "actives.quick_shot" || _skill.getID() == "actives.shoot_bolt" || _skill.getID() == "actives.shoot_stake")
		{
			_properties.DamageReceivedRegularMult *= 0.100000001;
		}
		else if (_skill.getID() == "actives.throw_javelin")
		{
			_properties.DamageReceivedRegularMult *= 0.25;
		}
		else if (_skill.getID() == "actives.puncture" || _skill.getID() == "actives.thrust" || _skill.getID() == "actives.stab" || _skill.getID() == "actives.impale" || _skill.getID() == "actives.rupture" || _skill.getID() == "actives.lunge")
		{
			_properties.DamageReceivedRegularMult *= 0.5;
		}
	}

});
