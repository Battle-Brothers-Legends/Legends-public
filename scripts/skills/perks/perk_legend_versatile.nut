this.perk_legend_versatile <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeStacks = 0,
		RangedStacks = 0,
		SkillCount = 0,
		Bonus = 10
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendVersatile);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk | this.Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		local ret = [
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

		if (this.m.RangedStacks > 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]+25%[/color] Damage"
			});
		}
		else if (this.m.MeleeStacks > 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]+25%[/color] Damage"
			});
		}
	}

	function onCombatStarted()
	{
		this.m.MeleeStacks = 0;
		this.m.RangedStacks = 0;
		this.m.SkillCount = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.MeleeStacks = 0;
		this.m.RangedStacks = 0;
		this.m.IsHidden = true;
	}

	function onUpdate(_properties)
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		local fraction = this.m.Bonus * 0.01;

		_properties.MeleeSkill += this.Math.floor(baseProperties.getRangedSkill() * fraction);
		_properties.RangedSkill += this.Math.floor(baseProperties.getMeleeSkill() * fraction);

		this.m.IsHidden = this.m.MeleeStacks == 0 || this.m.RangedStacks == 0;
		if (this.m.MeleeStacks)
			_properties.MeleeDamageMult *= 1.25;

		if (this.m.RangedStacks)
			_properties.RangedDamageMult *= 1.25;
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (this.m.MeleeStacks != 0 && this.m.RangedStacks != 0 && this.m.SkillCount != this.Const.SkillCounter)
		{
			this.m.SkillCount = this.Const.SkillCounter;
			this.m.MeleeStacks = 0;
			this.m.RangedStacks = 0;
			if (this.m.MeleeStacks == 1 || this.m.RangedStacks == 1)
			{
				this.getContainer().getActor().setDirty(true);
			}
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == null)
			return;

		if (!_skill.isAttack())
			return;

		if (_skill.isRanged() && this.m.MeleeStacks == 0 && this.m.SkillCount != this.Const.SkillCounter)
		{
			this.m.MeleeStacks = 1;
			this.m.RangedStacks = 0;
			this.m.SkillCount = this.Const.SkillCounter;
		}
		else if (!_skill.isRanged() && this.m.RangedStacks == 0 && this.m.SkillCount != this.Const.SkillCounter)
		{
			this.m.MeleeStacks = 0;
			this.m.RangedStacks = 1;
			this.m.SkillCount = this.Const.SkillCounter;
		}

		this.getContainer().getActor().setDirty(true);
	}
});
