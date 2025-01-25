this.legend_named_axe_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendNamedAxe);
		this.m.Description = "";
		this.m.Icon = "skills/placeholder_circle.png";
		this.m.IconMini = "mini_placeholder_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Item;
		this.m.IsActive = false;
		this.m.IsStacking = false;
        this.m.IsWeaponSkill = true;
        this.m.IsHidden = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

    function setBonus( _bonus )
    {
        this.m.Bonus = _bonus;
    }

    function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
        if ( _skill.m.IsWeaponSkill == false ) { return; }
		if ( _targetEntity != null && _hitInfo.BodyPart == ::Const.BodyPart.Head)
		{
			_hitInfo.DamageRegular *= 1 + (this.m.Bonus * 0.01);
		}
	}

});
