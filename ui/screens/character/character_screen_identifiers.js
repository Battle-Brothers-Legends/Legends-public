/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			29.03.2017 / Reworked: 26.11.2017
 *  @Description:	Character Screen Identifiers
 */

var CharacterScreenIdentifier =
{
	KeyEvent:
	{
		CharacterScreenNamespace: '.character-screen',
		CharacterPanelNamespace: '.character-panel',
		PaperdollNamespace: '.paperdoll',
		BrothersListNamespace: '.brothers-list',
		InventoryListNamespace: '.inventory-list',
		PerksModuleNamespace: '.perks-module'
	},

	Skill:
	{
		Id: 'id',
		ImagePath: 'imagePath',
		ImageOverlayPath: 'imageOverlayPath'
	},

	SkillTypes:
	{
		ActiveSkills: 'activeSkills',
		PassiveSkills: 'passiveSkills',
		StatusEffects: 'statusEffects'
	},
	
	Item:
	{
		Id: 'id',
		Slot: 'slot',
		ImagePath: 'imagePath',
		Amount: 'amount',
		AmountMax: 'amountMax',
		AmountColor: 'amountColor'
	},

	ItemSlot:
	{
		None: 'none',
		Mainhand: 'mainhand',
		Offhand: 'offhand',
		Head: 'head',
		Body: 'body',
		Accessory: 'accessory',
		Ammo: 'ammo',
		Free: 'free'
	},

	ItemFlag:
	 {
		IsLarge: 'isLarge',
		IsBlockingOffhand: 'isBlockingOffhand',
		IsChangeableInBattle: 'isChangeableInBattle',
		IsBagSlot: 'isBagSlot'
	},

	ItemOwner:
	{
		Stash: 'character-screen-inventory-list-module.stash',
		Ground: 'character-screen-inventory-list-module.ground',
		Paperdoll: 'character-screen-inventory-list-module.paperdoll',
		Backpack: 'character-screen-inventory-list-module.backpack'
	},

	QueryResult:
	{
		Perks: 'perks',
		Brother: 'brother',
		Brothers: 'brothers',
		Stash: 'stash'
	},

	Paperdoll:
	{
		Equipment: 'equipment',
		Bag: 'bag'
	},

	Entity: {
		Id: 'id',
		Flags: 'flags',
		Character: {
			Key: 'character',
			Name: 'name',
			Title: 'title',
			ImagePath: 'imagePath',
			ImageOffsetX: 'imageOffsetX',
			ImageOffsetY: 'imageOffsetY',
			PerkPoints: 'perkPoints',
			PerkPointsSpent: 'perkPointsSpent',
			IsPlayerCharacter: 'isPlayerCharacter',
			Level: 'level',
			LevelUp: {
				Key: 'levelUp',
				HitpointsIncrease: 'hitpointsIncrease',
				BraveryIncrease: 'braveryIncrease',
				FatigueIncrease: 'fatigueIncrease',
				InitiativeIncrease: 'initiativeIncrease',
				MeleeSkillIncrease: 'meleeSkillIncrease',
				RangeSkillIncrease: 'rangeSkillIncrease',
				MeleeDefenseIncrease: 'meleeDefenseIncrease',
				RangeDefenseIncrease: 'rangeDefenseIncrease'
			},
			XPValue: 'xpValue',
			XPValueMax: 'xpValueMax',
			DailyMoneyCost: 'dailyMoneyCost',
			DaysWounded: 'daysWounded',
			LeveledUp: 'leveledUp'
			
		},
		Stats: 'stats',
		Ground: 'ground'
	},

	EntityFlags:
	{
		IsSelected: 'isSelected'
	},

	Perk: {
		Key: 'perks',
		Tree: 'perkTree',
		Type: {
			Offensive: 'offensive',
			Defensive: 'defensive',
			Utility: 'utility'
		},
		Tier: {
			Tier1: 'tier1',
			Tier2: 'tier2',
			Tier3: 'tier3'
		},
		Id: 'ID',
		Name: 'Name',
		Description: 'Description',
		ImagePath: 'Icon',
		ImagePathDisabled: 'IconDisabled',
		Unlocks: 'Unlocks'
	}
};
