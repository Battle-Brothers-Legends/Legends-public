this.legend_ram_hammer_effect <- this.inherit("scripts/skills/skill", {
	m = {
	Stacks = 0
	},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRamHammer);
		this.m.Icon = "ui/perks/perk_53.png"; //change later
		this.m.IconMini = "mini_smackdown_circle"; //change later
		this.m.Overlay = "active_89"; //change later
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is being bolstered by the Ram Hammer upon successful hits. If an attack misses, the benefits are lost.";
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Grants[color=%positive%]+50%[/color] damage for each successful attack made this turn."
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants[color=%positive%]Hammer Specialisation[/color] when equipped."
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants[color=%positive%]Disarm immunity[/color] when equipped."
			}
		];
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.DamageTotalMult *= 1.5;
	}

	// function onAnySkillUsed( _skill, _targetEntity, _properties )
    // {
    //     if (_skill.getItem() != null && _skill.getItem().getID() == "your hammer" && this.m.Stacks > 0)
    //     {
    //         _properties.DamageTotalMult *= (1 + this.m.Stacks * 0.1);
    //     }
    // }

	function onTargetMissed( _skill, _targetEntity )
    {
        if (_targetEntity == null)
            return;

        if (!_targetEntity.isAttackable())
            return;

        if (!_skill.isAttack())
        	return;

        this.m.Stacks = 0;
    }

	function onTargetHit ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
    {
        if (_skill.isAttack())
        {
            this.m.Stacks += 1;
        }
    }

	function onCombatStarted()
    {
        this.m.Stacks = 0;
    }

    function onCombatFinished()
    {
        this.m.Stacks = 0;
    }

    function onUpdate( _properties )
    {
        _properties.IsSpecializedInHammers = true;
        _properties.IsImmuneToDisarm = true
    }
});

