::mods_hookExactClass("ai/tactical/behaviors/ai_switchto_melee", function(o) {
	local onExecute = o.onExecute;
	o.onExecute = function( _entity )
	{
		local itemsBefore = array(::Const.ItemSlot.COUNT);
		// We need to cache this as it is set to false in onExecute
		local wasNegatingDisarm = this.m.IsNegatingDisarm;
		for (local i = 0; i < ::Const.ItemSlot.COUNT; i++)
		{
			itemsBefore[i] = clone _entity.getItems().m.Items[i];
		}

		_entity.getItems().m.FU_IsIgnoringItemAction = true;
		local ret = onExecute(_entity);
		_entity.getItems().m.FU_IsIgnoringItemAction = false;

		if (ret)
		{
			if (wasNegatingDisarm)
			{
				// Once to use up quickhands, once to actually pay for the cost
				_entity.getItems().payForAction([_entity.getMainhandItem()]);
				_entity.getItems().payForAction([_entity.getMainhandItem()]);
			}
			else
			{
				local items = [];
				for (local i = 0; i < ::Const.ItemSlot.COUNT; i++)
				{
					foreach (j, item in _entity.getItems().m.Items[i])
					{
						if (item != itemsBefore[i][j] && items.find(item) == null)
						{
							if (item != null && item != -1) items.push(item);
							if (itemsBefore[i][j] != null && itemsBefore[i][j] != -1) items.push(itemsBefore[i][j]);
						}
					}
				}
				_entity.getItems().payForAction(items);
			}
		}

		return ret;
	}
});
