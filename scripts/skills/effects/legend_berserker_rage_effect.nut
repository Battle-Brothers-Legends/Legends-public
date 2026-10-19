this.legend_berserker_rage_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		LastRageSoundTime = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBerserkerRage);
		this.m.Description = "The smell of blood and death sends this character into an uncontrollable rage. Once in a rage, they must continuously feed it to keep it going.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/orc_rage", 6);
		this.m.IsSerialized = false;
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
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]" + this.m.Stacks + "%[/color] Damage increase"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]-" + ::Math.minf(70, 2 * this.m.Stacks) + "%[/color] Damage received"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Resolve"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Initiative"
			}
		];
	}

	function addRage(_r) {
		this.m.Stacks += _r;
		local actor = this.getContainer().getActor();

		if (!actor.isHiddenToPlayer()) {
			if (this.m.SoundOnUse.len() != 0 && ::Time.getVirtualTimeF() - this.m.LastRageSoundTime > 5.0) {
				this.m.LastRageSoundTime = ::Time.getVirtualTimeF();
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * (::Math.rand(75, 100) * 0.01), actor.getPos(), ::Math.rand(75, 100) * 0.01);
			}

			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " gains rage!");
		}
	}

	function onUpdate(_properties) {
		if (this.m.Stacks >= 40) {
			this.m.Stacks = 40;
		}
		this.m.IsHidden = this.m.Stacks == 0;
		_properties.Bravery += 1 * this.m.Stacks;
		_properties.DamageTotalMult *= 1.0 + this.m.Stacks * 0.01;
		_properties.Initiative += 1 * this.m.Stacks;
	}

	function onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties) {
		if (::MSU.isNull(_attacker) || _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack()) {
			return;
		}

		_properties.DamageReceivedTotalMult *= ::Math.maxf(0.3, 1.0 - 0.02 * this.m.Stacks);
	}

	function onTurnStart() {
		this.m.Stacks = ::Math.max(0, this.m.Stacks - 2);
	}

	function onDamageReceived(_attacker, _damageHitpoints, _damageArmor) {
		this.addRage(1);
	}

	function onTargetKilled(_targetEntity, _skill) {
		this.addRage(3);
	}

	function onCombatStarted() {
		this.m.Stacks = 0;
		this.m.LastRageSoundTime = 0;
		this.skill.onCombatStarted();
	}

	function onCombatFinished() {
		this.m.Stacks = 0;
		this.m.LastRageSoundTime = 0;
		this.skill.onCombatFinished();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.Stacks + "[/color] " + ::Legends.S.inlineIcon(["bravery", "initiative"]) + ", [color=%positive%]+" + this.m.Stacks + "[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ", [color=%negative%]-" + ::Math.minf(70, 2 * this.m.Stacks) + "[/color] " + ::Legends.S.inlineIcon("damage_received");
	}
});
