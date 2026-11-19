package mods.api.dungeon;
class Hero {
 public var local:Bool;
 public var player:Dynamic;
 public function new(local:Bool,friend:Bool=false) {this.local=local;player={isFriend:friend};}
}
