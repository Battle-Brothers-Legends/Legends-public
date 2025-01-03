this.legend_coordinating_volleys <- this.inherit("scripts/skills/effects/legend_commander_abstract_effect", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_coordinating_volleys";
		this.m.Name = "Coordinating volleys";
		this.m.Description = "Fire on my mark! An inspirational leader is guiding this characters shots.";
		this.m.Icon = "ui/perks/coordinated_volleys_circle.png";
		this.m.IconMini = "mini_coordinated_volleys_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		_properties.RangedSkill += 10;
		_properties.RangedDamageMult *= 1.05;
	}
});
