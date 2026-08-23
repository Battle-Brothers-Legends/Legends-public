this.legend_full_draw_skill <- this.inherit("scripts/skills/actives/aimed_shot", {
	m = {}
	function create() {
		this.aimed_shot.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFullDraw);
		this.m.Description = "Take full advantage of the draw weight of your bow to deliver a devastating and accurate shot. Can not be used while engaged in melee.";
		this.m.FatigueCost = 25;
		this.m.ActionPointCost = 9;
		this.m.DirectDamageMult = 0.5;
	}

	function onAfterUpdate ( _properties ) {
		this.aimed_shot.onAfterUpdate(_properties);
		if (_properties.IsSpecializedInBows) {
			this.m.ActionPointCost -= 1;
		}
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInBows ? 2 : 1);
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
			_properties.DamageRegularMult *= 1.2;

			if (_properties.IsSharpshooter) {
				_properties.DamageDirectMult += 0.05;
			}
		}
	}
});
