::mods_hookExactClass("items/helmets/helmet", function(o) {
	o.m.Variants <- [];

	o.getVision <- function () {
		return this.m.Vision;
	}

	o.onRepair <- function (_a) {
		this.setArmor(_a);
		return 0;
	}

	o.getValue = function () {
		return this.Math.floor(this.m.Value * ((1.0 * this.m.Condition) / (1.0 * this.m.ConditionMax)));
	}

	o.getTooltip = function () {
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/armor_head.png",
			value = this.Math.floor(this.m.Condition),
			valueMax = this.Math.floor(this.m.ConditionMax),
			text = "" + this.Math.floor(this.getArmor()) + " / " + this.Math.floor(this.getArmorMax()) + "",
			style = "armor-head-slim"
		});

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		if (this.m.Vision < 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Vision [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Vision + "[/color]"
			});
		}
		else if (this.m.Vision > 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Vision [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Vision + "[/color]"
			});
		}

		if (this.isRuned())
		{
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
		}

		return result;
	}

	o.isDroppedAsLoot = function ()
	{
		if (!this.item.isDroppedAsLoot())
			return false;

		if (this.isNamed())
			return true;

		local isPlayer = this.m.LastEquippedByFaction == this.Const.Faction.Player || this.getContainer() != null && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.isKindOf(this.getContainer().getActor().get(), "player");
		local isLucky = !this.Tactical.State.isScenarioMode() && !isPlayer && this.World.Assets.getOrigin().isDroppedAsLoot(this);
		local isBlacksmithed = isPlayer && !this.Tactical.State.isScenarioMode() && this.World.Assets.m.IsBlacksmithed;

		if (this.m.Condition > 15 && isPlayer || this.m.Condition > 30 && this.m.Condition / this.m.ConditionMax >= 0.25 && (isLucky || this.Math.rand(1, 100) <= 70) || isBlacksmithed)
			return true;

		return false;
	}

	o.onUpdateProperties = function ( _properties ) {
		local staminaMult = 1.0;

		if (this.getContainer() == null || this.getContainer().getActor() == null || this.getContainer().getActor().isNull())
		{
			return;
		}

		if (this.getContainer().getActor().getSkills().hasSkill("perk.brawny"))
		{
			staminaMult = 0.7;
		}

		_properties.Armor[this.Const.BodyPart.Head] += this.m.Condition;
		_properties.ArmorMax[this.Const.BodyPart.Head] += this.m.ConditionMax;
		_properties.Stamina += this.Math.ceil(this.m.StaminaModifier * staminaMult);
		_properties.Vision += this.getVision();
	}

	o.upgradeIsBlocked <- function (_slot) {
		return true;
	}

	o.getUpgrade <- function ( _slot = -1 ) {
		return null
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in ) {
		onDeserialize(_in);
		if (this.isRuned())
			this.updateRuneSigil();
	}
});
