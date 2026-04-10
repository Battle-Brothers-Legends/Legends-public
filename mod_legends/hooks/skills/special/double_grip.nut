::mods_hookExactClass("skills/special/double_grip", function(o)
{
	// commented stuff is moved from old duelist
	// o.m.AllowedWeapons <-
	// [
	// 	"_parrying_dagger",
	// 	"_hand_crossbow",
	// 	"buckler",
	// 	"legend_mummy_shield"
	// ];

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "With the second hand free, this character can get a firm double grip on his weapon and inflicts additional damage and penetration. Armor penetration will scale by [color=%positive%]25%[/color] of Melee Skill and Hand Crossbows allow double gripping";
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local tooltip = getTooltip();
		local bonus = this.Math.floor(this.getContainer().getActor().getCurrentProperties().MeleeSkill * 0.25);
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = "[color=%positive%]"+ bonus + "%[/color] of any damage ignores armor"
		});

		return tooltip;
	}

	// o.isValid <- function ( _mainhand, _offhand )
	// {
	// 	if (_mainhand == null && _offhand == null)
	// 		return false;

	// 	return true;
	// }

	// o.isFullEffect <- function ( _mainhand, _offhand )
	// {
	// 	if (::Legends.Perks.has(this, ::Legends.Perk.LegendAmbidextrous) && this.isPartialEffect())
	// 		return true;
	// 	return getContainer().hasSkill("injury.missing_hand") || _offhand == null && !_mainhand.isItemType(::Const.Items.ItemType.TwoHanded) && !_mainhand.isItemType(::Const.Items.ItemType.RangedWeapon) || _offhand != null && _offhand.isItemType(::Const.Items.ItemType.Tool);
	// }

	// o.isPartialEffect <- function ( _mainhand, _offhand )
	// {
	// 	if (_offhand == null)
	// 		return false;

	// 	foreach( valid in m.AllowedWeapons )
	// 	{
	// 		if (::MSU.String.endsWith(_offhand.getID(), valid))
	// 			return true;
	// 	}

	// 	return false;
	// }

	// // you can just hook this or isValid/isFullEffect/isPartialEffect and the tooltip will auto calculate without needing to replace anything
	// o.getBonus <- function()
	// {
	// 	local main = getContainer().getActor().getMainhandItem();
	// 	local off = getContainer().getActor().getOffhandItem();
	// 	if (!isValid(main, off))
	// 		return 0;

	// 	local bonus = 0.0;
	// 	if (isFullEffect(main, off))
	// 		bonus += 0.25;
	// 	else if (isPartialEffect(main, off))
	// 		bonus += 0.13;
	// 	return bonus;
	// }

	o.canDoubleGrip = function ()
	{
		local actor = this.getContainer().getActor();
		local missinghand = this.m.Container.getSkillByID("injury.missing_hand");
		local newhand = ::Legends.Traits.get(this, ::Legends.Trait.LegendProstheticHand);
		local main = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local hasXbow = off != null && ::MSU.String.endsWith(off.getID(), "_hand_crossbow");
		local hasNet = off != null && ::MSU.String.endsWith(off.getID(), "_net") && actor.getCurrentProperties().IsSpecializedInNets;
		return (missinghand == null || newhand != null) && main != null && (off == null || hasXbow || hasNet) && main.isDoubleGrippable();
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate(_properties);
		if (this.canDoubleGrip())
		{
			_properties.DamageDirectAdd += this.Math.floor(_properties.MeleeSkill * 0.25) * 0.01;
		}
	}
});
