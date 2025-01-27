this.legend_marked_target <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.legend_marked_target";
		this.m.Name = "Marked target";
		this.m.Description = "This character has been marked by a skilled opponent, melee and ranged attacks are more likely to hit";
		this.m.Icon = "skills/MarkTargetSkill.png";
		this.m.IconMini = "mini_mark_target";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has is a marked target and has [color=" + this.Const.UI.Color.NegativeValue + "] -10 [/color] ranged defense and [color=" + this.Const.UI.Color.NegativeValue + "] -10 [/color] melee defense each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function onUpdate( _properties )
	{
		_properties.RangedDefense -= 10;
		_properties.MeleeDefense -= 10;
		local bonus = 1.0 + this.Math.min(0.2 , _properties.Hitpoints * 0.01);
		_properties.DamageReceivedTotalMult *= bonus;
	}


	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});
