//Author: WNTR Jimmy
this.perk_legend_night_raider <- this.inherit("scripts/skills/skill", {
	m = {
		ThreatModifier = 10,
		MeleeSkillMult = 1.10,
		RangedSkillMult = 1.10
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendNightRaider);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.IsHidden = true;
	}

	function onAdded() // make this perk work when added to non-player
	{
		if (!this.getContainer().getActor().isPlayerControlled()) {
			this.onCombatStarted();
		}
	}

	function getTooltip() {
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

		local inverseThreat = -1 * this.m.ThreatModifier;
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=%negative%]%penalty%[/color] Resolve to adjacent enemies",
			param = [
				["penalty", inverseThreat]
			]
		});

		local meleePercent = ::Math.round(this.m.MeleeSkillMult * 100 - 100);
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "Gain [color=%positive%]%modifier%%[/color] Melee Skill",
			param = [
				["modifier", meleePercent]
			]
		});

		local rangedPercent = ::Math.round(this.m.RangedSkillMult * 100 - 100);
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "Gain [color=%positive%]%modifier%%[/color] Ranged Skill",
			param = [
				["modifier", rangedPercent]
			]
		});

		return ret;
	}

	function getDescription() {
		return "Gain tactical advantages at night.";
	}

	function onUpdate(_properties) {
		this.m.IsHidden = ::World.getTime().IsDaytime;
		_properties.IsAffectedByNight = false;
		if (!::World.getTime().IsDaytime) {
			_properties.Threat += this.m.ThreatModifier;
			_properties.MeleeSkill *= this.m.MeleeSkillMult;
			_properties.RangedSkill *= this.m.RangedSkillMult;
		}
	}

	function onAdded() {
		if (this.m.Container.hasTrait(::Legends.Trait.LegendNyctophobia)) {
			::Legends.Traits.remove(this, ::Legends.Trait.LegendNyctophobia);
		}
		if (this.m.Container.hasTrait(::Legends.Trait.NightBlind)) {
			::Legends.Traits.remove(this, ::Legends.Trait.NightBlind);
		}
	}
});
