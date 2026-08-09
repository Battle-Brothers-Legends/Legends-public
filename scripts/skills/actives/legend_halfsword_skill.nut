this.legend_halfsword_skill <- this.inherit("scripts/skills/actives/puncture", {
	m = {
		IsGreatHalfsword = false
	}
	function create() {
		this.puncture.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHalfsword);
		this.m.Description = "A calculated attack with one hand firmly on the blade aiming in gaps of the armor. Ignores all armor but is harder to hit with and can not land critical hits for additional damage.";
		this.m.Icon = "skills/active_halfsword.png";
		this.m.IconDisabled = "skills/active_halfsword_bw.png";
		this.m.Overlay = "active_halfsword";
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsHidden = true;
		this.m.HitChanceBonus = -80;
	}

	function setItem (_item) {
		if (this.m.IsGreatHalfsword) {
			this.m.ActionPointCost = 6;
			this.m.FatigueCost = 35;
		}
		this.skill.setItem(_item);
	}

	function getTooltip () {
		local ret = this.slash.getTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=%positive%]15%[/color] extra damage done against enemies armed with polearms or melee weapons that can strike over a distance"
		});
		return ret;
	}

	function onAfterUpdate( _properties ) {
		this.m.IsHidden = !this.canDoubleGrip() && !this.m.Item.isItemType(this.Const.Items.ItemType.TwoHanded);
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties ) {
		this.slash.onAnySkillUsed( _skill, _targetEntity, _properties );
		if (_skill == this) {
			_properties.DamageTotalMult *= 0.5;
	}
});
