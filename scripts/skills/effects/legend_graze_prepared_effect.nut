this.legend_graze_prepared_effect<- this.inherit("scripts/skills/skill", {
	m = {
		AttacksLeft = 1
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendGrazePrepared);
		this.m.Icon = "skills/graze_circle.png";
		this.m.IconMini = "mini_graze_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is preparing an attack to inflict slow bleeding by grazing the flesh. The next hit will infict [color=%negative%]2[/color] bleed damage for the next five turns.";
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
			this.spawnIcon("graze", this.getContainer().getActor().getTile());
		}

		this.m.AttacksLeft = 1;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0)
			this.removeSelf();

		if (!::Legends.S.isEntityNullOrDead(_targetEntity)) {
			return;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || _damageInflictedHitpoints <= ::Const.Combat.MinDamageToApplyBleeding || _targetEntity.getHitpoints() <= 0)
			return;

		if (!_targetEntity.isHiddenToPlayer()) {
			if (this.m.SoundOnUse.len() != 0)
			{
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			::Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding from grazes");
		}

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendGrazedEffect, function (_effect) {
			_effect.setActor(this.getContainer().getActor());
		}.bindenv(this));
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

