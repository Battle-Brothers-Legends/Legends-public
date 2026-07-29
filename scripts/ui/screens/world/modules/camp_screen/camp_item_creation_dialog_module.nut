this.camp_item_creation_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		CurrentPage = 0,
	},

	function onShow() {
		this.m.CurrentPage = 0;
		this.getTent().onInit();
		return this.queryLoad();
	}

	function queryQueue() {
		return {
			Assets = this.assetsInformation(),
			Queue = this.getTent().getQueue()
		};
	}

	function queryLoad() {
		local result = {
			Title = this.m.Title,
			SubTitle = this.m.Description,
			Assets = this.assetsInformation(),
			Blueprints = ::World.Crafting.getQualifiedBlueprintsForUI(::Const.Items.ItemFilter.All, this.m.Title),
			Queue = this.getTent().getQueue()
		};
		return result;
	}

	function assetsInformation() {
		return {
			Time = this.getTent().getRequiredTime(),
			Brothers = this.getTent().getAssignedBros()
		};
	}

	function loadCraftList() {
		this.m.JSHandle.asyncCall("loadFromData", this.queryQueue());
	}

	function destroy() {
		this.ui_module.destroy();
	}

	function onSwap(_data) {
		this.getTent().onSwap(_data[0], _data[1]);
		this.loadCraftList();
	}

	function onRemove(_idx) {
		this.getTent().onRemove(_idx);
		this.loadCraftList();
	}

	function onAdd(_result) {
		this.getTent().onAdd(_result.ID);
		this.loadCraftList();
	}

	function onCraftForever(_result) {
		if (this.getTent().onCraftForever(_result.ID)) {
			this.loadCraftList();
		}
	}

	function onLeaveButtonPressed() {
		this.m.Parent.onModuleClosed();
	}

	function onBrothersButtonPressed() {
		this.m.Parent.onCommanderButtonPressed();
	}
});
