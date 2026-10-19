this.perk_legend_point_blank <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPointBlank);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getDescription() {
		return "Don't fire until you see the whites of their eyes!";
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local bonus = this.getBonus(actor.getCurrentProperties());

		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Allows you to use throwing weapons in melee"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Increases your damage done by [color=%positive%]" + bonus + "%[/color] for ranged weapon attacks at a range of 4 tiles or less"
			}
		]);

		return tooltip;
	}

	function getBonus(_properties) {
		local actor = this.getContainer().getActor();
		local mskillBonus = 0;
		local rdefBonus = 0;

		if (actor.getMainhandItem() != null && actor.getMainhandItem().isWeaponType(::Const.Items.WeaponType.Throwing)) {
			mskillBonus = ::Math.floor(0.3 * _properties.getMeleeSkill());
			rdefBonus = ::Math.floor(0.5 * _properties.getRangedDefense());
		} else {
			mskillBonus = 0;
			rdefBonus = ::Math.floor(0.3 * _properties.getRangedDefense());
		}

		return mskillBonus + rdefBonus;
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_targetEntity == null) {
			return;
		}

		if (!_skill.isRanged()) {
			return;
		}

		local bonus = this.getBonus(_properties) * 0.01;

		if (this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) > 4) {
			return;
		}

		_properties.DamageTotalMult *= 1.0 + bonus;
	}

	function onGetHitFactors(_skill, _targetTile, _tooltip) {
		// get the bro's ranged def
		local rdef = this.getContainer().getActor().getCurrentProperties().getRangedDefense();

		// check if the skill they are using to attack is ranged
		if (_skill.isRanged()) {
			// find how far away the target is from your brother
			local CharDistFromTarget = _targetTile.getDistanceTo(this.getContainer().getActor().getTile());
			// positive bonus because they are within two tiles away
			if (CharDistFromTarget <= 2) {
				_tooltip.push({
					id = 1,
					type = "text",
					icon = "ui/tooltips/positive.png",
					text = rdef + "% more damage \n" + "  " + this.getName()
				});
			}
			//negative bonus because they are further that 3 tiles away
			else if (CharDistFromTarget >= 4) {
				_tooltip.push({
					id = 1,
					type = "text",
					icon = "ui/tooltips/negative.png",
					text = rdef + "% less damage \n" + "  " + this.getName()
				});
			}
		}
	}
});
