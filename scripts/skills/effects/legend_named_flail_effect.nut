this.legend_named_flail_effect <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "effects.legend_named_flail";
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
    }

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if ( _skill == null || _skill.m.IsWeaponSkill == false ) 
			return;

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
			return;

		local user = this.getContainer().getActor();

		if (_bodyPart == ::Const.BodyPart.Head && !_targetEntity.getCurrentProperties().IsImmuneToDaze)
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

			if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer && !_targetEntity.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
			}
		}
	}

});
