::Const.Sound.getParrySoundByWeaponType <- function(_skill)
{
	local item = _skill.getItem();

	if (item == null)
		return "sounds/combat/legend_parried_01.wav"; // Fallback sound if item is null

	if (item.isWeaponType(this.Const.Items.WeaponType.Sword))
		return "sounds/combat/legend_parried_01.wav";
	else if (item.isWeaponType(this.Const.Items.WeaponType.Spear) || item.isWeaponType(this.Const.Items.WeaponType.Polearm))
		return "sounds/combat/legend_parried_02.wav";
	else if (item.isWeaponType(this.Const.Items.WeaponType.Cleaver))
		return "sounds/combat/legend_parried_03.wav";
	else if (item.isWeaponType(this.Const.Items.WeaponType.Flail) || item.isWeaponType(this.Const.Items.WeaponType.Staff))
		return "sounds/combat/legend_parried_04.wav";
	else if (item.isWeaponType(this.Const.Items.WeaponType.Mace) || item.isWeaponType(this.Const.Items.WeaponType.Axe))
		return "sounds/combat/legend_parried_05.wav";
	else if (item.isWeaponType(this.Const.Items.WeaponType.Hammer))
		return "sounds/combat/legend_parried_06.wav";
	else if (item.isWeaponType(this.Const.Items.WeaponType.Dagger))
		return "sounds/combat/legend_parried_07.wav";
	else if (item.isWeaponType(this.Const.Items.ItemType.FencingSword))
		return "sounds/combat/legend_parried_08.wav";
	else
		return "sounds/combat/legend_parried_01.wav"; // Fallback sound for other cases

};
