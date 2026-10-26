this.legend_favoured_enemy_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Category = "",
		BraveryMult = 1.0
	},

	function create() {
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		local constName = ::Legends.DefsHelpers.tokenizeConst(::Const.Perks.LookupMap[this.m.ID].Const);
		this.m.Category = constName[constName.len() - 1];
	}

	function isHidden() {
		if (!::Tactical.isActive() || ::Tactical.Entities == null) {
			return false;
		}

		local self = this;
		return ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _actor)(self.isFavoriteEnemy(_actor))).len() == 0;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	function getDynamicTooltip(_actor = null) {
		local stats = this.getTotalKillStats(_actor);
		local tooltip = [
			{
				id = 7,
				type = "progressbar",
				icon = "ui/tooltips/positive.png",
				value = stats.HitChance,
				valueMax = 25,
				text = "" + stats.HitChance + "% / " + "25%",
				style = "fatigue-slim"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+" + stats.HitChance + "[/color] Melee Skill"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+" + stats.HitChance + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]+" + stats.HitChance + "%[/color] Maximum Damage"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/icons/special.png",
				text = format((stats.Kills > 0 ? format("This character has already made %s favored enemy kills for a total of %s XP", ::Legends.S.highlightForLightBackground(stats.Kills), ::Legends.S.highlightForLightBackground(stats.XP)) : "This character has not made any favored enemy kills yet"))
			}
		];
		if (this.m.BraveryMult > 1) {
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + ::Math.floor((this.m.BraveryMult - 1.0) * 100.0) + "%[/color] Resolve"
			});
		}
		return tooltip;
	}

	function isFavoriteEnemy(_actor) {
		return !::Legends.S.isEntityNullOrDead(_actor) && _actor.isPlacedOnMap() && !_actor.isAlliedWithPlayer() && this.m.Category == ::Legends.FavoriteEnemy.getCategory(_actor);
	}

	function getTotalKillStats(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		return ::Legends.FavoriteEnemy.getFavoriteEnemyStats(actor, this.m.Category);
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_targetEntity == null || !this.isFavoriteEnemy(_targetEntity)) {
			return;
		}
		
		local stats = this.getTotalKillStats();
		_properties.MeleeSkill += stats.HitChance;
		_properties.RangedSkill += stats.HitChance;
		_properties.DamageRegularMax *= stats.HitMult;

	}

	function onUpdate(_properties) {
		if (this.m.BraveryMult == 1.0 || !::Tactical.isActive()) {
			return;
		}

		local self = this;
		if (::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _actor)(self.isFavoriteEnemy(_actor))).len() > 0) {
			_properties.BraveryMult *= this.m.BraveryMult;
		};
	}

	// Requires MSU; this will add tooltips to display bonuses when targeting an enemy
	function onGetHitFactors(_skill, _targetTile, _tooltip) {
		if (this.isFavoriteEnemy(_targetTile.getEntity())) {

			local bonuses = this.getTotalKillStats();
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = format("[color=%positive%]%s%%[/color] Favoured Enemy (also grants [color=%positive%]+%s%%[/color] max damage)", bonuses.HitChance.tostring(), bonuses.HitChance.tostring())
			});
		}
	}
});
