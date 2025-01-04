if (!("LegendMod" in ::Const))
{
	::Const.LegendMod <- {};
}

if (!("ArmorObjs" in ::Const.LegendMod))
{
	::Const.LegendMod.ArmorObjs <- [];
}

::Const.LegendMod.ArmorObjs.extend([
{
	ID = "legendary/armor_of_davkul", // this.m.ConditionMax
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_sackcloth_patched"],
			[1, "cloth/legend_sackcloth_tattered"],
			[1, "cloth/legend_sackcloth"],
		],
		Chain = [
			[1, "chain/legend_armor_reinforced_worn_mail"],
			[1, "chain/legend_armor_reinforced_worn_mail_shirt"],
			[1, "chain/legend_armor_rusty_mail_shirt"],
		],
		Plate = [
			[1, "plate/davkul"], 
		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},
{
	ID = "legendary/legend_emperors_armor", // 400
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_ancient_cloth_restored"], // 35
		],
		Chain = [
			[1, "chain/legend_armor_ancient_mail"], // 35
		],
		Plate = [
			[1, "legendary/legend_emperors_armor"],
		],
		Cloak = [
			[1, "named/legend_armor_cloak_emperors"]
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},
{
	ID = "legendary/emperors_armor_fake", // 380
	Script = "scripts/items/legend_armor/legendary/legend_emperors_armor_fake",
	Sets = [{
		Cloth = [

		],
		Chain = [

		],
		Plate = [

		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},
{
	ID = "legendary/legend_ijirok_armor", //310.0
	Script = "scripts/items/legend_armor/legendary/legend_ijirok_armor",
	Sets = []
},
{
	ID = "legendary/legend_mountain_armor", // this.m.ConditionMax
	Script = "scripts/items/legend_armor/legendary/legend_armor_mountain_named",
	Sets = [{
		Cloth = [

		],
		Chain = [

		],
		Plate = [

		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},
{
	ID = "legendary/legend_skin_armor", // 160
	Script = "scripts/items/legend_armor/legendary/legend_skin_armor",
	Sets = [{
		Cloth = [

		],
		Chain = [

		],
		Plate = [

		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},
{
	ID = "named/legend_named_warlock_cloak", // 180
	Script = "scripts/items/legend_armor/legendary/legend_armor_named_warlock_cloak",
	Sets = [{
		Cloth = [

		],
		Chain = [

		],
		Plate = [

		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
},
{
	ID = "named/lindwurm_armor", // 300
	Script = "scripts/items/legend_armor/legendary/legend_lindwurm_armor",
	Sets = [{
		Cloth = [

		],
		Chain = [

		],
		Plate = [

		],
		Cloak = [
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
}]);