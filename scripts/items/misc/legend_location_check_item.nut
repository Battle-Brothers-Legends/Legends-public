this.legend_location_check_item <- this.inherit("scripts/items/item", {
    m = {},
    function create() {
        this.item.create();
        this.m.ID = "misc.legend_location_check";
        this.m.Name = "Legendary location check";
        this.m.Icon = "misc/map_location_check.png";
        this.m.Description = "Generates an event, that checks if all legendary locations spawned. Right click to start.";
        this.m.SlotType = this.Const.ItemSlot.None;
        this.m.ItemType = this.Const.Items.ItemType.Usable;
        this.m.IsUsable = true;
        this.m.IsDroppedAsLoot = true;
        this.m.Value = 0;
    }

    function getBuyPrice() {
        return 0;
    }

    function getSellPrice() {
        return 0;
    }

    function onUse( _actor, _item = null ) {
        this.World.State.getMenuStack().popAll(true);
        this.World.Events.fire("event.legendary_locations_check_event");
        return false;
    }

    function onSerialize( _out ) {
        this.item.onSerialize(_out);
    }

    function onDeserialize( _in ) {
        this.item.onDeserialize(_in);
    }
});
