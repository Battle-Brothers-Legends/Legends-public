this.legend_bleed_prepared_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AttacksLeft = 1
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBleedPrepared);
		this.m.Icon = "skills/bleed_circle.png";
		this.m.IconMini = "mini_bleed_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is preparing an attack to inflict heavy bleeding. The next hit doing at least [color=" + this.Const.UI.Color.NegativeValue + "]" + this.Const.Combat.MinDamageToApplyBleeding + "[/color] damage to hitpoints will cause the target to bleed for the next two turns.";
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

	function resetTime()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			this.spawnIcon("bleed", this.getContainer().getActor().getTile());
		}

		this.m.AttacksLeft = 1;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{


		if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints <= this.Const.Combat.MinDamageToApplyBleeding || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isAlive())
		{
			return;
		}


		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding");
		}
		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Bleeding, function(_effect) {
			if (this.getContainer().getActor().getFaction() == this.Const.Faction.Player )
				_effect.setActor(this.getContainer().getActor());
			_effect.setDamage(5);
		}.bindenv(this));
		--this.m.AttacksLeft;
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

