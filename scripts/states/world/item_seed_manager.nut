this.item_seed_manager <- {
	m = {
		Seeds = {}
	},

	function create() {
		this.m.Seeds = clone ::Legends.Items.SeededIDs;
	}

	function onInit() {
		foreach(key, value in this.m.Seeds) {
			this.m.Seeds[key] = ::Legends.LCG.get(::Math.abs(::Math.rand(0, 65535) * ::Math.rand(0, 65535) + ::Math.rand(0, 65535)));
		}
	}

	function clear() {
		this.m.Seeds = clone ::Legends.Items.SeededIDs;
	}

	function getRandomGenerator(_item) {
		if (_item.m.ID in this.m.Seeds) {
			return this.m.Seeds[_item.m.ID];
		}
		return ::Math;
	}

	function onSerialize(_out) {
		foreach(key, value in this.m.Seeds) {
			_out.writeBool(true);
			_out.writeString(key);
			_out.writeU32(value.State);
		}
		_out.writeBool(false);
	}

	function onDeserialize(_in) {
		while(_in.readBool()) {
			local key = _in.readString();
			if (!(key in this.m.Seeds))
				this.m.Seeds[key] <- null;
			this.m.Seeds[key] = ::Legends.LCG.get(_in.readU32());
		}
	}
}
