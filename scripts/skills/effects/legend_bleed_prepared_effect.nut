this.legend_bleed_prepared_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBleedPrepared);
		this.m.Icon = "skills/bleed_circle.png";
		this.m.IconMini = "mini_bleed_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription() {
		local hits = this.m.Stacks == 1 ? "hit" : this.m.Stacks + " hits";
		return "This character is preparing to inflict heavy bleeding. The next " + hits + " doing at least [color=%negative%]" + this.Const.Combat.MinDamageToApplyBleeding + "[/color] damage to hitpoints will cause the target to bleed for the next two turns.";
	}

	function getTooltip() {
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

	function resetTime() {
		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap()) {
			this.spawnIcon("bleed", actor.getTile());
		}

		this.m.Stacks = ::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Cleaver | ::Const.Items.WeaponType.Whip)
			? 2
			: 1;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {

		if (this.m.Stacks <= 0) {
			this.removeSelf();
		}

		if (!::Legends.S.isEntityNullOrDead(_targetEntity)) {
			return;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison
			|| _damageInflictedHitpoints <= this.Const.Combat.MinDamageToApplyBleeding
			|| _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer()) {
			if (this.m.SoundOnUse.len() != 0) {
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding");
		}
		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Bleeding, function (_effect) {
			if (this.getContainer().getActor().getFaction() == this.Const.Faction.Player) {
				_effect.setActor(this.getContainer().getActor());
			}
			_effect.setDamage(5);
		}.bindenv(this));
		this.m.Stacks -= 1;
	}

	function onTargetMissed(_skill, _targetEntity) {
		this.m.Stacks -= 1;

		if (this.m.Stacks <= 0) {
			this.removeSelf();
		}
	}

});
