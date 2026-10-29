this.perk_legend_true_believer <- this.inherit("scripts/skills/skill", {
	m = {
		RemovedTraits = [
			::Legends.Trait.Craven,
			::Legends.Trait.Dastard,
			::Legends.Trait.Insecure,
			::Legends.Trait.Superstitious
		]
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTrueBeliever);
		this.m.Description = "Dangerous is the man who puts an absolute trust in something he can't see.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function isHidden() {
		return this.getBonus() == 0;
	}

	function onUpdate(_properties) {
		_properties.IsAffectedByFleeingAllies = false;
		_properties.IsAffectedByDyingAllies = false;
		_properties.BraveryMult += this.getBonus();
	}

	function getBonus() {
		if (!::Tactical.isActive()) {
			return 0;
		}
		return ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _actor)(_actor.getMoraleState() == ::Const.MoraleState.Fleeing)).len() * 0.05;
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		foreach (trait in this.m.RemovedTraits) {
			if (::Legends.Traits.has(actor, trait)) {
				::Legends.Traits.remove(actor, trait);
			}
		}
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();
		if (bonus > 0) {
			tooltip.extend([
				{
					id = 3,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=%positive%]+" + (bonus * 100) + "%[/color] Resolve"
				}
			]);
		}
		return tooltip;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local bonus = this.getBonus();
		return (bonus > 0 ? "[color=%positive%]+" + (this.getBonus() * 100) + "%[/color] " + ::Legends.S.inlineIcon("bravery") : null);
	}
});
