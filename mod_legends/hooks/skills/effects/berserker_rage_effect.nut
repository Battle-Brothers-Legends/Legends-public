::mods_hookExactClass("skills/effects/berserker_rage_effect", function (o) {
	o.m.IsBerserker <- false;
	o.m.Stacks <- 0;

	o.getDescription = function () {
		return "The scent of blood and carnage drives this character into a primal frenzy. The rage demands constant slaughter to maintain. Every blow sustained, strike delivered, and life claimed fuels the growing bloodlust, drastically enhancing combat prowess.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Resolve"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]-" + ((::Math.minf(0.7, 0.01 * this.m.Stacks)) * 100) + "%[/color] Damage received"
			}
		]);
		return tooltip;
	}

	o.isHidden <- function () {
		return this.m.Stacks == 0;
		;
	}

	o.addRage <- function (_r) {
		this.m.Stacks += _r;
		local actor = this.getContainer().getActor();

		if (!actor.isHiddenToPlayer()) {
			if (this.m.SoundOnUse.len() != 0 && ::Time.getVirtualTimeF() - this.m.LastRageSoundTime > 5.0) {
				this.m.LastRageSoundTime = ::Time.getVirtualTimeF();
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * (::Math.rand(75, 100) * 0.01), actor.getPos(), ::Math.rand(75, 100) * 0.01);
			}

			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " gains rage!");
		}

		actor.updateRageVisuals(this.m.Stacks);
	}

	o.onUpdate = function (_properties) {
		if (this.m.Stacks >= 50) {
			this.m.Stacks = 50;
		}
		_properties.Bravery += this.m.Stacks;
		_properties.DamageRegularMin += this.m.Stacks;
		_properties.DamageRegularMax += this.m.Stacks;
		_properties.Initiative += this.m.Stacks;
	}

	o.onBeforeDamageReceived <- function (_attacker, _skill, _hitInfo, _properties) {
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) {
			return;
		}

		_properties.DamageReceivedRegularMult *= ::Math.maxf(0.3, 1.0 - 0.01 * this.m.Stacks);
	}

	o.onTurnStart = function () {
		this.m.Stacks = ::Math.max(0, this.m.Stacks - 2);
		this.getContainer().getActor().updateRageVisuals(this.m.Stacks);
	}

	o.onDamageReceived <- function (_attacker, _damageHitpoints, _damageArmor) {
		this.addRage(1);
		if (this.m.IsBerserker) {
			this.addRage(2);
		}
	}

	o.onTargetHit = function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		this.addRage(1);
		if (this.m.IsBerserker) {
			this.addRage(2);
		}
	}

	o.onTargetKilled = function (_targetEntity, _skill) {
		this.addRage(2);
		if (this.m.IsBerserker) {
			this.addRage(3);
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]" + this.m.Stacks + "[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ::Legends.S.inlineIcon("bravery") + ::Legends.S.inlineIcon("initiative") + ", [color=%negative%]-" + ((::Math.minf(0.7, 0.01 * this.m.Stacks)) * 100) + "%[/color]" + ::Legends.S.inlineIcon("damage_received");
	}
});
