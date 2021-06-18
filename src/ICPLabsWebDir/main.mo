import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import List "mo:base/List";
import types "./types";
import websitedb "./websitedb"
actor Main{
    type Website = types.Website;
    private var websiteDB = websitedb.WebsiteDB();

    public func uploadWebsite(website : Website) : async Bool {
        switch (websiteDB.uploadWebsite(website)){
            case true { true };
            case (_){ false };
        }
    };
    public query func getWebsite(title : Text) : async ?List.List<Website>{
        websiteDB.getWebsite(title)
    }; 
    /*public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };*/
}