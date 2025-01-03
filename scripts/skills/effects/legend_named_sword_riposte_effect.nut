this.legend_named_sword_riposte_effect <- this.inherit("scripts/skills/skill", {
	m = {
        Bonus = 0
	},
	function create()
	{
		this.m.ID = "effects.legend_named_sword_riposte";
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

    function onTurnStart()
    {
        if ( ::Math.rand(0, 100) > this.m.Bonus ) { return; }
        if ( this.getContainer().hasSkill("effects.riposte") ) { return; }

        this.getContainer().add(this.new("scripts/skills/effects/riposte_effect"));
        
        if (!this.getContainer().getActor().isHiddenToPlayer())
        {
            this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " automatically used Riposte");
        }
    }

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if ( _skill == null || _skill.m.IsWeaponSkill == false ) { return; } 
		
		local actor = this.getContainer().getActor();

		if (!actor.isAlive() || actor.isDying())
		{
			return;
		}

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return;
		}

        if ( ::Math.rand(0, 100) > this.m.Bonus ) { return; }

        _targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_parried_effect"));
	}

});
