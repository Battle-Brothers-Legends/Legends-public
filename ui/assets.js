/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			03.03.2017
 *  @Description:	UI Paths & Assets
 */
"use strict";


/*
	Pathes
 */
var Path =
{
	GFX:		Constants.BROWSER_MODE ? '../../gfx/' : 'coui://gfx/',
	ITEMS: 		Constants.BROWSER_MODE ? '../../gfx/ui/items/' : 'coui://gfx/ui/items/',
	PROCEDURAL:	Constants.BROWSER_MODE ? '../../gfx/' : 'coui://procedural/'
};


/*
	Assets
 */
var Asset =
{

	// Buttons
    BUTTON_END_TURN:                        'ui/skin/icon_end_turn.png',
    BUTTON_DELAY_TURN:                      'ui/skin/icon_wait.png',
    BUTTON_END_ALL_TURNS:                   'ui/skin/icon_end_all_turns.png',
    BUTTON_OPEN_EVENTLOG:                   'ui/skin/icon_expand.png',
    BUTTON_CLOSE_EVENTLOG:                  'ui/skin/icon_retract.png',
	BUTTON_SWITCH_MAP_LEVEL_UP:             'ui/skin/icon_height_up.png',
	BUTTON_SWITCH_MAP_LEVEL_DOWN:           'ui/skin/icon_height_down.png',
	BUTTON_TOGGLE_STATS_OVERLAYS_ENABLED:   'ui/skin/icon_tabs.png',
	BUTTON_TOGGLE_STATS_OVERLAYS_DISABLED:	'ui/skin/icon_tabs_deactivated.png',
	BUTTON_TOGGLE_TREES_ENABLED:			'ui/skin/icon_trees.png',
	BUTTON_TOGGLE_TREES_DISABLED:			'ui/skin/icon_trees_sw.png',

    BUTTON_TOGGLE_HIGHLIGHT_BLOCKED_TILES_ENABLED:   'ui/skin/icon_highlight.png',
    BUTTON_TOGGLE_HIGHLIGHT_BLOCKED_TILES_DISABLED:  'ui/skin/icon_highlight_sw.png',

	BUTTON_OPEN_INVENTORY:					'ui/buttons/open-inventory-button.png',
	BUTTON_QUIT:                            'ui/skin/icon_cross.png',
	BUTTON_ARROW_LEFT:				        'ui/skin/arrow_left.png',
	BUTTON_ARROW_RIGHT:				        'ui/skin/arrow_right.png',

	BUTTON_SORT:							'ui/buttons/sort-button.png',
	BUTTON_ALL_FILTER:						'ui/buttons/filter_all.png',
	BUTTON_WEAPONS_FILTER:					'ui/buttons/filter_weapons.png',
	BUTTON_ARMOR_FILTER:					'ui/buttons/filter_armor.png',
    BUTTON_MISC_FILTER:                     'ui/buttons/filter_misc.png',
    BUTTON_USABLE_FILTER:                   'ui/buttons/filter_usable.png',
	BUTTON_MOOD_FILTER:						'ui/buttons/filter_mood.png',
	BUTTON_MOOD_FILTER_OFF:					'ui/buttons/filter_mood_sw.png',
	BUTTON_FLEE:                            'ui/skin/icon_retreat.png',

    BUTTON_MONEY_ASSET:                     'ui/buttons/money-asset-button.png',
    BUTTON_FOOD_ASSET:                      'ui/buttons/food-asset-button.png',
    BUTTON_BROTHERS_ASSET:                  'ui/buttons/brothers-asset-button.png',

	BUTTON_DISMISS_CHARACTER:               'ui/skin/icon_delete.png',

	BUTTON_NEXT_BANNER:                     'ui/skin/arrow_right.png',
	BUTTON_PREVIOUS_BANNER:					'ui/skin/arrow_left.png',

	BUTTON_PAUSE:							'ui/buttons/time_stop.png',
	BUTTON_PAUSE_DISABLED:					'ui/buttons/time_stop_sw.png',
	BUTTON_PLAY:							'ui/buttons/time_normal.png',
	BUTTON_PLAY_DISABLED:					'ui/buttons/time_normal_sw.png',
	BUTTON_FAST_FORWARD:					'ui/buttons/time_fast.png',
	BUTTON_FAST_FORWARD_DISABLED:			'ui/buttons/time_fast_sw.png',
	BUTTON_VERY_FAST_FORWARD:				'ui/buttons/time_very_fast.png',
	BUTTON_VERY_FAST_FORWARD_DISABLED:		'ui/buttons/time_very_fast_sw.png',
	BUTTON_SUPER_FAST_FORWARD:				'ui/buttons/time_super_fast.png',
	BUTTON_SUPER_FAST_FORWARD_DISABLED:		'ui/buttons/time_super_fast_sw.png',

    // UI Icons
	ICON_ACTION_POINTS:						'ui/icons/action_points.png',
	ICON_MORALE:							'ui/icons/morale.png',
	ICON_FATIGUE:							'ui/icons/fatigue.png',
	ICON_HEALTH:							'ui/icons/health.png',
	ICON_ARMOR_HEAD:						'ui/icons/armor_head.png',
	ICON_ARMOR_BODY:						'ui/icons/armor_body.png',

	ICON_MELEE_SKILL:						'ui/icons/melee_skill.png',
	ICON_RANGE_SKILL:						'ui/icons/ranged_skill.png',
	ICON_MELEE_DEFENCE:						'ui/icons/melee_defense.png',
	ICON_RANGE_DEFENCE:						'ui/icons/ranged_defense.png',
	ICON_SIGHT_DISTANCE:					'ui/icons/vision.png',
	ICON_REGULAR_DAMAGE:					'ui/icons/regular_damage.png',
	ICON_CRUSHING_DAMAGE:					'ui/icons/armor_damage.png',
	ICON_CHANCE_TO_HIT_HEAD:				'ui/icons/chance_to_hit_head.png',
	ICON_INITIATIVE:						'ui/icons/initiative.png',
    ICON_BRAVERY:   						'ui/icons/bravery.png',
	ICON_LOCKED:							'ui/icons/icon_locked.png',
    ICON_LEVELED_UP:                        'ui/icons/leveled_up.png',
    ICON_DAYS_WOUNDED:                      'ui/icons/days_wounded.png',
    ICON_KILLS:                             'ui/icons/kills.png',
    ICON_XP_RECEIVED:                       'ui/icons/xp_received.png',
    ICON_DAMAGE_DEALT:                      'ui/icons/damage_dealt.png',
    ICON_DAMAGE_RECEIVED:                   'ui/icons/damage_received.png',
    ICON_LEVEL:						        'ui/icons/level.png',

	ICON_BROTHERS:							'ui/icons/round_information/brothers_icon.png',
	ICON_ENEMIES:							'ui/icons/round_information/enemies_icon.png',
	ICON_ROUND_NUMBER:						'ui/icons/round_information/round_number_icon.png',

    ICON_ASSET_MONEY:                       'ui/icons/asset_money.png',
    ICON_ASSET_DAILY_MONEY:                 'ui/icons/asset_daily_money.png',
    ICON_ASSET_FOOD:                        'ui/icons/asset_food.png',
    ICON_ASSET_DAILY_FOOD:                  'ui/icons/asset_daily_food.png',
    ICON_ASSET_AMMO:                        'ui/icons/asset_ammo.png',
    ICON_ASSET_SUPPLIES:                    'ui/icons/asset_supplies.png',
    ICON_ASSET_MEDICINE:                    'ui/icons/asset_medicine.png',
	ICON_ASSET_BROTHERS:                    'ui/icons/asset_brothers.png',
	ICON_ASSET_BUSINESS_REPUTATION:         'ui/icons/asset_business_reputation.png',
	ICON_ASSET_MORAL_REPUTATION:			'ui/icons/asset_moral_reputation.png',

    ICON_UNKNOWN_TRAITS:                    'ui/icons/unknown_traits.png',

	ICON_AMBITION:							'ui/icons/ambition.png',
	ICON_AMBITION_DISABLED:					'ui/icons/ambition_sw.png',
    ICON_MONEY:                             'ui/icons/money.png',
    ICON_MONEY_SMALL:                       'ui/tooltips/money.png',
    ICON_BAG:                               'ui/icons/bag.png',

    ICON_CONTRACT_SCROLL:                   'ui/icons/cancel.png',
    ICON_CONTRACT_SCROLL_DISABLED:			'ui/icons/contract_scroll_disabled.png',
    ICON_CONTRACT_LOCKED:					'ui/icons/no_contracts.png',
	ICON_EDIT_NAME_AND_TITLE:               'ui/icons/papers.png',
	ICON_RELATIONS:							'ui/icons/relations.png',
	ICON_CENTER:							'ui/icons/center.png',
	ICON_CAMERALOCK:						'ui/icons/cameralock.png',
	ICON_CAMERALOCK_DISABLED:				'ui/icons/cameralock_disabled.png',
	ICON_TRACKING:							'ui/icons/tracking.png',
	ICON_TRACKING_DISABLED:					'ui/icons/tracking_disabled.png',
	ICON_CAMP:								'ui/icons/camp.png',
	ICON_CAMP_DISABLED:						'ui/icons/camp_sw.png',
	ICON_OBITUARY:							'ui/icons/obituary.png',
    ICON_PERKS:							    'ui/icons/campfire.png',

	ICON_REPAIR_ITEM:                       'ui/icons/repair_item.png',
	ICON_SALVAGE_ITEM:                      'ui/icons/salvage_item.png',

	ICON_AUTOMATION_SELL_ITEM:              'ui/icons/automation_sell_item.png',
	ICON_AUTOMATION_REPAIR_SELL_ITEM:       'ui/icons/automation_repair_sell_item.png',
	ICON_AUTOMATION_REPAIR_ITEM:            'ui/icons/automation_repair_item.png',
	ICON_AUTOMATION_SALVAGE_ITEM:           'ui/icons/automation_salvage_item.png',

    // UI Perk Images
    PERK_SELECTION_FRAME:                   'ui/perks/selection_frame.png',

	// Slot Backgrounds
	SLOT_BACKGROUND_EMPTY:					'ui/items/slots/inventory_slot_empty.png',
	SLOT_BACKGROUND_BAG:					'ui/items/slots/inventory_slot_bag.png',
	SLOT_BACKGROUND_BODY:					'ui/items/slots/inventory_slot_body.png',
	SLOT_BACKGROUND_HELMET:					'ui/items/slots/inventory_slot_helmet.png',
	SLOT_BACKGROUND_MAINHAND:				'ui/items/slots/inventory_slot_mainhand.png',
	SLOT_BACKGROUND_OFFHAND:				'ui/items/slots/inventory_slot_offhand.png',
	SLOT_BACKGROUND_AMMO:					'ui/items/slots/inventory_slot_ammo.png',
	SLOT_BACKGROUND_ACCESSORY:				'ui/items/slots/inventory_slot_accessory.png',

    // Console
	CONSOLE_NONE:						    'ui/console/console-none.png',
	CONSOLE_INFO:						    'ui/console/console-info.png',
	CONSOLE_DEBUG:					        'ui/console/console-debug.png',
	CONSOLE_WARNING:				    	'ui/console/console-warning.png',
	CONSOLE_ERROR:					        'ui/console/console-error.png',
	CONSOLE_CRITICAL:					    'ui/console/console-critical.png',
	CONSOLE_GROUP:					        'ui/console/console-group.png',

    // Images
    IMAGE_ENTITY_SELECTION_ARROW:			            'ui/images/entity_selection_arrow.png',
    IMAGE_SKILL_NOT_USABLE:				                'ui/images/skill_not_usable_overlay.png',
    IMAGE_DAY_TIME:                                     'ui/images/day_time.png',
    IMAGE_WORLD_HIRE_SCREEN_CLICK_REGION_INDICATOR:     'ui/images/world_town_screen/world_hire_screen_main_dialog_click_region_indicator.png',
	IMAGE_TAVERN_RUMORS:                                'ui/events/event_23.png',
	IMAGE_TAVERN_DRINK:                                 'ui/events/event_24.png',

    // backgrounds
	BACKGROUND_MAIN_MENU:					'ui/screens/loading_screen_',
    BACKGROUND_INVENTORY:				    'ui/screens/inventory_background.png',

    // header
	HEADER_TACTICAL_COMBAT_DIALOG:          'ui/header/tactical_combat_engage.png',
	HEADER_COMBAT_RESULT_DIALOG:			'ui/header/world_town_screen_main_dialog.png',
    HEADER_WORLD_TOWN_SCREEN_MAIN_DIALOG:   'ui/header/world_town_screen_main_dialog.png',
	HEADER_EVENT_POPUP:						'ui/header/brothers_marching.png',
	HEADER_EVENT_POPUP_LARGE:				'ui/header/brothers_marching_large.png',

	// Tactical speed buttons
	BUTTON_SPEED_NORMAL_TACTICAL:				'ui/buttons/speed_normal_tactical.png',
	BUTTON_SPEED_NORMAL_TACTICAL_DISABLED:		'ui/buttons/speed_normal_tactical_bw.png',
	BUTTON_SPEED_FAST_TACTICAL:					'ui/buttons/speed_fast_tactical.png',
	BUTTON_SPEED_FAST_TACTICAL_DISABLED:		'ui/buttons/speed_fast_tactical_bw.png',
	BUTTON_SPEED_VERY_FAST_TACTICAL:			'ui/buttons/speed_very_fast_tactical.png',
	BUTTON_SPEED_VERY_FAST_TACTICAL_DISABLED:	'ui/buttons/speed_very_fast_tactical_bw.png',
	BUTTON_SPEED_SUPER_FAST_TACTICAL:			'ui/buttons/speed_super_fast_tactical.png',
	BUTTON_SPEED_SUPER_FAST_TACTICAL_DISABLED:	'ui/buttons/speed_super_fast_tactical_bw.png'
};