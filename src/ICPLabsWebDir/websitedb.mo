import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import types "./types";
import Array "mo:base/Array";
import Error "mo:base/Error";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Blob "mo:base/Blob"; 
import Prim "mo:prim";
import Hash "mo:base/Hash";

module{
    type Website = types.Website;
    public class WebsiteDB(){
//hashmap
        //labels -> ID
        private var labels_to_id = HashMap.HashMap<Text, List.List<Nat>>(1, Text.equal, Text.hash);
        //title -> ID
        private var title_to_id = HashMap.HashMap<Text, List.List<Nat>>(1, Text.equal, Text.hash);
        //ID -> title
        private var id_to_title = HashMap.HashMap<Nat, Text>(1,Nat.equal, Hash.hash);
        //ID -> url
        private var id_to_url = HashMap.HashMap<Nat, Text>(1,Nat.equal, Hash.hash);
        //ID -> labels
        private var id_to_labels = HashMap.HashMap<Nat, Text>(1,Nat.equal, Hash.hash);

//global variable
        //present Website ID
        private var _ID : Nat = 1;

//website function
        //upload new website
        public func uploadWebsite(website : Website) : Bool{
            var websiteId_ = _ID;
            _ID +=1 ;

            //put this website's ID & title into the id_to_title map
            id_to_title.put(websiteId_, website.title);
            //put this website's ID & url into the id_to_url map
            id_to_url.put(websiteId_, website.url);
            //put this website's ID & labels into the id_to_labels map
            id_to_labels.put(websiteId_, website.labels);
            //put this website's title & ID into the title_to_id map
            switch(title_to_id.get(website.title)){
                case(?list){
                    var tempList = List.append(list, List.make<Nat>(websiteId_));
                    title_to_id.put(website.title, tempList);
                };
                case(_){
                    title_to_id.put(website.title, List.make<Nat>(websiteId_));
                };
            };
            //put this website's labels & ID into the labels_to_id map
            switch(labels_to_id.get(website.labels)){
                case(?list){
                    var tempList = List.append(list, List.make<Nat>(websiteId_));
                    labels_to_id.put(website.labels, tempList);
                };
                case(_){
                    labels_to_id.put(website.labels, List.make<Nat>(websiteId_));
                };
            };
            true
        };
        //get website
        private func makeWebsite(websiteId_ : Nat) : ?Website{
            ?{
                //get title
                title = switch(id_to_title.get(websiteId_)){
                    case(?title_){
                        title_
                    };
                    case(_){
                         ""
                    };
                };
                //get url
                url = switch(id_to_url.get(websiteId_)){
                    case(?url_){
                        url_
                    };
                    case(_){
                        ""
                    };
                };
                //get labels
                labels = switch(id_to_labels.get(websiteId_)){
                    case(?labels_){
                        labels_
                    };
                    case(_){
                        ""
                    };
                };
            }
        };
        //get website from title
        public func getWebsite(title : Text) : ?List.List<Website>{
            var websites : List.List<Website> = List.nil<Website>();
            let append_ = func _append(id : Nat){
                var temp = List.make<Website>(
                    switch(makeWebsite(id)){
                        case null {return};
                        case (?website){website};
                    }
                );
                //put the website to the list
                websites := List.append<Website>(websites, temp);
            };

            // return List -> websites           
            switch(title_to_id.get(title)){
                //get website id list
                case(?idList){
                    //find the website's id,title,url,labels
                    List.iterate<Nat>(idList, append_);
                    //return websites list
                    ?websites
                };
                //no such title : webiste
                case(_){
                    ?List.nil<Website>()
                };

            };
        };
        
    }
};
