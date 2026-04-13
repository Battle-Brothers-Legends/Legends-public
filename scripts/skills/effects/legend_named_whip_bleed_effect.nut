this.legend_named_whip_bleed_effect <- this.inherit("scripts/skills/skill", {
	m = {
        Bonus = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendNamedWhipBleed);
		this.m.Name = "";
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

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if ( _skill == null || _skill.m.IsWeaponSkill == false )
			return;

		if (!_skill.isAttack())
			return;

		if (_skill.getItem() == null)
			return;

		if (_skill.getItem().getID() != this.getItem().getID())
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			return;

        if (::Math.rand(0, 100) > this.m.Bonus)
			return;

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Bleeding, function(_effect) {
			if (_skill.getContainer().getActor().getFaction() == this.Const.Faction.Player )
				_effect.setActor(this.getContainer().getActor());
			_effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
		}.bindenv(this));

	}

});
