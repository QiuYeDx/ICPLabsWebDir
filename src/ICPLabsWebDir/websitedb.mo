import types "./types";
import Debug "mo:base/Debug";
import Hash "mo:base/Hash";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import List "mo:base/List";

module{
//hashmap
    //label -> ID
    private var label_to_id = HashMap.HashMap<Text, List.List<Nat>>(1, Text.equal, Text.hash);
    //ID -> title
    private var id_to_title = HashMap.HashMap<Nat, Text>(1,Hash.equal, Hash.hash);
    //ID -> url
    private var id_to_url = HashMap.HashMap<Nat, Text>(1,Hash.equal, Hash.hash);
    //ID -> label
    private var id_to_label = HashMap.HashMap<Nat, Text>(1,Hash.equal, Hash.hash);
    
//global variable
    //present Website ID
    private var _ID : Nat = 1;

//website function
    public func uploadWebsite(website : Website) : bool{
        var websiteID_ = _ID;
        _ID +=1 ;
    }

    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };
};
