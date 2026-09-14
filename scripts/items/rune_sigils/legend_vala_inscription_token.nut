this.legend_vala_inscription_token <- this.inherit("scripts/items/item", {
	m = {},
	function create() {
		this.item.create();
		this.m.ID = "token.legend_vala_inscription";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.IconLarge = "";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 100;
	}

	function getTooltip() {
		local result = [
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
		result.push({
			id = 3,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null) {
			result.push({
				id = 4,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		} else {
			result.push({
				id = 4,
				type = "image",
				image = this.getIcon()
			});
		}
		result.push({
			id = 65,
			type = "text",
			icon = "ui/icons/special.png",
			text = this.getRuneSigilTooltip()
		});

		local def = ::Legends.Runes.get(this.getRuneVariant());
		local slot = "";
		if (def.ItemType == ::Legends.Runes.Target.Weapon) {
    		slot = "Weapon";
		} else if (def.ItemType == ::Legends.Runes.Target.Shield) {
    		slot = "Shield";
		}
		result.push({
			id = 66,
			type = "hint",
			icon = "ui/icons/mouse_right_button.png",
			text = "Right-click to attach this inscribed rune to the selected character\'s " + slot + ". It cannot be detached."
		});

		local offhand = null;
		local broID = this.World.State.m.CharacterScreen.m.SelectedBrotherID;
		if (broID != null) {
			offhand = this.Tactical.getEntityByID(broID).getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		}
		if (offhand != null && ((offhand.getItemType() & this.Const.Items.ItemType.Weapon) != 0)) {
			result.push({
				id = 67,
				type = "hint",
				icon = "ui/icons/mouse_right_button_shift.png",
				text = "Shift + Right-click to attach this inscribed rune to the selected character\'s offhand Weapon. It cannot be detached."
			});
		}

		return result;
	}


	function onUse(_actor, _item = null, _playSound = true) {
		local target = null;
		local def = ::Legends.Runes.get(this.getRuneVariant());
		if (def.ItemType == ::Legends.Runes.Target.Weapon) {
			if (_item == null) {
				target = _actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
			} else {
				target = _actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
        	}
			if (target == null)
				return false;
		} else if (def.ItemType == ::Legends.Runes.Target.Helmet) {
			target = _actor.getItems().getItemAtSlot(::Const.ItemSlot.Head);
			if (target == null)
				return false;
		} else if (def.ItemType == ::Legends.Runes.Target.Armor) {
			target = _actor.getItems().getItemAtSlot(::Const.ItemSlot.Body);
			if (target == null)
				return false;
		} else if (def.ItemType == ::Legends.Runes.Target.Shield) {
			target = _actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
			if (target == null)
				return false;
			if (target.getID().find("shield") == null)
				return false;
		} else {
			return false;
		}
		if (_playSound)
			this.Sound.play("sounds/combat/legend_vala_inscribe.wav");
		local alreadyRuned = target.isRuned();
		target.setRuneVariant(this.getRuneVariant());
		target.setRuneBonus1(this.getRuneBonus1());
		target.setRuneBonus2(this.getRuneBonus2());
		if (!alreadyRuned) {
			target.updateRuneSigil();
		}
		_actor.getItems().unequip(target);
		_actor.getItems().equip(target);
		return true;
	}

	function onDeserialize(_in) {
		this.item.onDeserialize(_in);
		this.updateRuneSigilToken();
	}

});
