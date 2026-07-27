::mods_hookExactClass("skills/actives/shieldwall", function (o) {
	o.getTooltip = function () {
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local mult = 1.0;
		local proficiencyBonus = 0;

		if (actor.getCurrentProperties().IsSpecializedInShields) {
			mult = mult * 1.25;
		}

		if (actor.getCurrentProperties().IsProficientWithShieldSkills) {
			proficiencyBonus = 5;
		}

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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/block.png",
				text = "Grants an additional [%positive]+" + this.Math.floor(item.getMeleeDefense() * mult + proficiencyBonus) + "[/color] [%status]Block[/color] against attacks"
			}
		];
	}

	o.isUsable = function () {
		return this.skill.isUsable();
	}

	o.onAfterUpdate = function (_properties) {
		this.m.FatigueCostMult = _properties.IsSpecializedInShields	|| _properties.IsProficientWithShieldWall || _properties.IsProficientWithShieldSkills ? ::Const.Combat.WeaponSpecFatigueMult	: 1.0;
	}

	o.onUse = function (_user, _targetTile) {
		::Legends.Effects.grant(_targetTile.getEntity(), ::Legends.Effect.LegendShieldwall);

		if (!_user.isHiddenToPlayer()) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Shieldwall");
		}
		return true;
	}

});
