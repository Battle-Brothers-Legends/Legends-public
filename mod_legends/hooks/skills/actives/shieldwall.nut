::mods_hookExactClass("skills/actives/shieldwall", function (o) {
	o.getTooltip = function () {
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		local mult = 1.0;
		local proficiencyBonus = 0;

		if (p.IsSpecializedInShields) {
			mult = mult * 1.25;
		}

		if (p.IsProficientWithShieldSkills) {
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
				text = "Grants an additional [color=%positive%]+" + ::Math.floor(item.getMeleeDefense() * mult + proficiencyBonus) + "[/color] [color=%status%]Block[/color] against attacks"
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
		::Legends.Effects.grant(_targetTile.getEntity(), ::Legends.Effect.Shieldwall);

		if (!_user.isHiddenToPlayer()) {
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Shieldwall");
		}
		return true;
	}

});
