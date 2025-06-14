::mods_hookExactClass("ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function( o )
{
	local _convertEntitySkillsToUIData = o.convertEntitySkillsToUIData;
	o.convertEntitySkillsToUIData = function ( _entity )
	{
		if (!_entity.isPlayerControlled())
		{
			return null;
		}

		local result = _convertEntitySkillsToUIData(_entity);

		foreach( item in _entity.querySwitchableItems() )
		{
			result.push({
				id = item.getInstanceID(),
				imagePath = "ui/items/" + item.getIcon(),
				isUsable = true,
				isAffordable = true
			});
		}

		return result;
	}
});