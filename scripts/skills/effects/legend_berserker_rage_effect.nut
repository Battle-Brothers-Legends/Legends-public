this.legend_berserker_rage_effect <- this.inherit("scripts/skills/skill", {
	m = {
		RageStacks = 0,
		LastRageSoundTime = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBerserkerRage);
		this.m.Icon = "ui/perks/berserker_rage_circle.png";
		this.m.IconMini = "status_effect_34_mini";
		this.m.Overlay = "status_effect_34";
		this.m.SoundOnUse = [
			"sounds/enemies/orc_rage_01.wav",
			"sounds/enemies/orc_rage_02.wav",
			"sounds/enemies/orc_rage_03.wav",
			"sounds/enemies/orc_rage_04.wav",
			"sounds/enemies/orc_rage_05.wav",
			"sounds/enemies/orc_rage_06.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
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
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RageStacks + "[/color] Damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.minf(70, 2 * this.m.RageStacks) + "%[/color] Damage Reduction"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RageStacks + "[/color] Bravery"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RageStacks + "[/color] Initiative"
			}
		];
	}
	function getDescription()
	{
		return "The smell of blood and death sends this character into an uncontrollable rage. Once in a rage, they must continuously feed it to keep it going.";
	}

	function addRage( _r )
	{
		this.m.RageStacks += _r;
		local actor = this.getContainer().getActor();

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0 && this.Time.getVirtualTimeF() - this.m.LastRageSoundTime > 5.0)
			{
				this.m.LastRageSoundTime = this.Time.getVirtualTimeF();
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * (this.Math.rand(75, 100) * 0.01), actor.getPos(), this.Math.rand(75, 100) * 0.01);
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gains rage!");
		}

	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.m.RageStacks == 0;
		_properties.Bravery += 1 * this.m.RageStacks;
		_properties.DamageRegularMin += 1 * this.m.RageStacks;
		_properties.DamageRegularMax += 1 * this.m.RageStacks;
		_properties.Initiative += 1 * this.m.RageStacks;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (::MSU.isNull(_attacker) || _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack())
			return;

		_properties.DamageReceivedTotalMult *= this.Math.maxf(0.3, 1.0 - 0.02 * this.m.RageStacks);
	}

	function onTurnStart()
	{
		this.m.RageStacks = this.Math.max(0, this.m.RageStacks - 2);
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		this.addRage(1);
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		this.addRage(3);
	}

	function onCombatStarted()
	{
		this.m.RageStacks = 0;
		this.m.LastRageSoundTime = 0;
		this.skill.onCombatStarted();
	}

	function onCombatFinished()
	{
		this.m.RageStacks = 0;
		this.m.LastRageSoundTime = 0;
		this.skill.onCombatFinished();
	}

});
