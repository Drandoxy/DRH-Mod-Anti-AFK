package mods.api;

class Context {
	public var core:Dynamic;
	public var state:Dynamic;

	public function new() {
		core = {facade: {mainStateMachine: {currentStateName: "RunState", mLoadingScreenState:{mFriendOnly:true,mFriendID:0,mMapID:0,mMapNodeID:1}}, menuNavigationController: {getTopUILayer: function() return ""}},
			overlay: new openfl.display.Sprite()};
		state = {floor: {}, inTown: false, heroes:[new mods.api.dungeon.Hero(true)]};
	}
}
