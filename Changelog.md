# 19.5.0 - Name Pending

## Noble House Changes
- introduced 40 new traits into the noble house trait system
- expanded the number of mottos available to noble houses
- added noble house traits to units and towns belonging to noble houses
- modified the faction window to include traits
- added short description to noble house traits available upon mouseover in faction window

## Profession system
- introduced a new system connecting camping system to brothers - profession tree
- the tree is accessible via character screen, next to the perk tree
- uses separate points, independent to regular perks

## Scenarios

### Anatomists
- new conqueror potion
- new demon alp potion
- new demon hound potion
- new fallen betrayer potion
- new greenwood schrat potion
- new hexe leader potion
- new necrosavant lord potion
- new orc behemoth potion
- new orc elite potion
- new redback potion
- new rock unhold potion
- new stollwurm potion
- new skinghoul potion
- new white direwolf potion

## Perks

### New Perks
- `Near Death Experience` - Martyr Trait Tree
> Confers an experience point bonus based on Hitpoints lost and Injuries gained during combat. Gain 1 XP per Hitpoint and 10 per Injuries. Experience gain is reduced by 90% at level 12 and above.
> Hitpoint damage taken is reduced by 5% and Resolve is increased by 3 for each Injury you have up to a maximum of 30% and [color=%positive%]15 achieved at 6 Injuries. Counts both regular and permanent Injuries.
- `Wide Swings` - Large Trait Tree
> 50% of the skill's fatigue cost is translated to Chance to hit. This accounts for any fatigue reduction or increase.
- `Hammer the Gap` - Grants a stacking +5% to hit as long as you attack the same tile. The bonus is capped at 10%.

### Perk Changes
- `Bloody Harvest` - 50% of the skill's fatigue cost is translated to Damage. This accounts for any fatigue reduction or increase.
> used to be damage and chance to hit
> moved to t5
> the bonus is now additive multiplier
- `Heightened Reflexes` - the damage bonus is an additive multiplier
- `Muscularity` - bonus from fatigue dropped to 10% and the bonus is now an additive multiplier
- `Strength in Numbers`
> The bonus to hitchance in melee is doubled to +10% for each ally surrounding and distracting your target.
> Grants 2 Melee and Ranged Defense for each ally surrounding you.
- `Backswing` - new gfx to differentiate from feint
- `Anticipation` - removed for now
- `Ballistics` - no longer reduces hitchance penalty with tile traveled, instead deals an additional 2 damage per tile travelled
- `Wind Reader` - reduces hitchance penalty with tile traveled by 2%, gains the vanilla `Anticipation` effect, moved to tier 3
- `Night Raider` - will now also appear in the Devious trait tree
- `Prepared` - crossbows and firearms in your bags will be loaded at combat start
- `Anticipation` - reduce damage taken by 1% for each point of Ranged Defense you have for the first few hits you take in combat

## Items

### Armors
- added Segmented Breastplate
- added Nomad Mail
- separated Horn Plate Upgrade (L5) into Kraken Shoulderplates (L5) and Horn Plate (L1)
- fixes and recolors of existing armor
- plate_full_greaves_named and plate_full_greaves_painted merged into a single item
- Vala Cloak changed into L4, Vala now always starts with Vala Dress and Vala Cloak equipped

### Weapons

**New Weapons**
- Heavy Rusty Battleaxe - new barbarian bardiche
- Named Heavy Rusty Battleaxe - named version

**Daze Bomb**
- will now stun if the target is already dazed

**Throwing**
- `Piercing Javelin` - if the attack is successful also attack the target behind them for 75% damage
> 5 ap, 20 fat

**Puncture Daggers**
- `Backstab` - replaces `Stab` on puncture daggers
> additional 5% damage and 3% armor penetration based on surround count
- `Puncture` - unchanged
- `Throw Dagger` - unchanged

**Qatal Daggers**
- `Stab` - will attack an additional time if under the effect of smoke
- `Deathblow` - unchanged
- `Gut`
> attacks repeatedly the body of the enemy depending on how many injuries they have

**Obsidian Dagger**
- `Backstab`
> additional 5% damage and 3% armor penetration based on surround count
> will attack an additional time if under the effect of smoke
- `Deathblow` - unchanged
- `Gut`
> attacks repeatedly the body of the enemy depending on how many injuries they have

**2h Swordcleavers**
- `Hew` - 60% base for each attack, +20% if the target is bleeding or injured
- `Harvest` - 10% bonus damage down from 20% with mastery when target is bleeding
- `Decapitate` - additionally increases head hit chance depending on how wounded the target is

**1h Cleavers**
- `Cleave` - unchanged
- `Decapitate` - unchanged
- `Debilitate` - a successful strike will apply `Debilitated`
> 4 ap, 20 fat, 50% damage

**Whips**
- `Whip` - ap cost is reduced to 3
- `Disarm` - unchanged
- `Debilitate` - a successful strike will apply `Debilitated`
> 4 ap, 20 fat, 50% damage, 3 range

**Bardiche**
- no longer has `Swing`

**Estoc**
- `Perforate` - You have a chance to attack up to 1(3 with mastery) additional times based on the initiative difference between you and your target. The chance for each attack to be executed is rolled independently in increments of 100.

**1h Shamshir and 1h scimitar**
- `Slash` is now `Flowing Slash`
> will attack again for 50% damage on a miss with mastery
- `Gash` - unchanged
- `Debilitate`

**1h ancient swords**
- `Bash`
- `Knock Out`
- `Return Favor`

**1h maces**
- `Slash` is now `Flowing Slash`
> will attack again for 50% damage on a miss with mastery
- `Gash` - unchanged
- `Debilitate`

### Blueprints
- new `Sipar Shield` blueprint from 1 iron ingot
- `Tower Shield` blueprint now costs 2 quality wood and 1 iron ingot

### Misc
- `Balanced Rucksack` - usable item sold around marketplaces which adds bags and belts to a mercenary

## Enemies

### Bandits
- `Bandit Executioner` - new enemy that will appear in bandit comps, dressed to impress and armed with cleavers - including the new executioner sword
- `Peasant Blacksmith` - removed from comps
- `Peasant Butcher` - removed from comps
- `Peasant Woodsman` - removed from comps
- `Peasant Miner` - removed from comps
- `Peasant Farmhand` - removed from comps
- `Peasant Poacher` - removed from comps
- `Peasant Squire` - removed from comps
- `Peasant Witchhunter` - removed from comps

## Quality of life
- added speed settings to combat and world expanding on vanilla systems
> use 1-4 in the World, F1-F4 in combat to change the speed
> alternatively use the buttons on the top of the respective screens
> buttons are fully functional during caravan and camp activities
- added expanded settlement situation tooltips to support new situations natively
> settlement situations displayed similarly to a popular mod
> new modifiers are supported
- added pause options in Legends General mod settings tab
> pause on events, ambitions and encounters
> pause on new dawn while camping (when town buildings become usable after a night)
> pause on new day (when contracts etc. reset)
> pause on entity discovered
- added an option to show the average stat potential directly on statistic bars
> shows average values at a glance (min/max ranges are still visible on mouseovering the bros background)
- added inventory management toggle on items
> allows setting the item type to be marked for sale, autorepair and sale, autorepair, autosalvage
> the setting is completely optional
> marked items can be sold with a single click in shops and new items acquired will respect these flags
> newly acquired items with flags will automatically start be added to repair/salvage queue
> flags are now visible in shop and loot screens

## Events
- added a new town encounter during drought
- added a new event requiring a well read person

## Gender settings and changes
- added a mod setting allowing the player to choose the gender of the commander avatar
- added a mod setting allowing the player to choose % of female characters
- added a mod setting allowing the player to choose % of enemy female characters
- some backgrounds received female counterparts: Fisher, Shepherd, Vagabond, Inventor, Brawler, Widow, Caravan Hand, Miner, Servant (southern), Juggler

## Bug Fixes
- black market in town screens can now be highlighted on mouseover
- painter tent allows painting the shoulder layer
- text fixes
- bros can now use the basic training options until level 12 in town training halls instead of 11
- fixed settlement situations applying twice

### For modders:
- it is now possible to use [i][/i] and [size=18px][/size] to customize ui text size easily with xbbcode
- defs created for backgrounds
- changed background.legend_peddler_commander -> background.legend_commander_peddler
- legend_mage_background and legend_mage_commander_mage removed
- human gender now randomized using randomizeHumanGender (separately on bgs and humans), which respects the new mod setting
- enemy gender now randomized using randomizeEnemyGender, which respects the new mod setting
