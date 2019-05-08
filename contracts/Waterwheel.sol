pragma solidity ^0.5.0;

import "./SnowflakeResolver.sol";
import "./SubscriberLib.sol";


using SubscriberLib for SubscriberLib.subscriber;

contract PlanAuth {
    function eligible(Subscriber subscriber, uint subscriptionIdx, address[] plans) constant public returns (bool);
}

contract Waterwheel is SnowflakeResolver {

    PlanAuth private _planAuth;
    function getPlanAuth() public view returns(PlanAuth) {return _planAuth;};
    function getPlanAuth(PlanAuth planAuth) public senderIsSnowflake() { _planAuth = planAuth;};

    mapping private (uint256=>SubscriberLib.Subscriber) _subscribers; // ein = > subscriber
    function isSubscribed(uint256 ein) public view returns (bool) {
        return subscribers[ein].ein;
    }

    function subscribe(int subscriptionIdx, address[] plans) public returns (bool) {
        //todo get ein
        require(planAyth.eligible(subscribers[ein], subscriptionIdx, plans));
        return subscribers[ein].subscribe(plans);
    }
    function unsubscribe(int subscriptionIdx, uint depth) public returns (bool) {
        return subscribers[ein].unsubscribe(depth);
    }

    function collect(uint256 ein) returns(bool) {
        return subscribers[i].collect();
    }

    constructor (address snowflakeAddress)
        SnowflakeResolver("Business", "Manage Business Clients Subscriptions.",
            snowflakeAddress, true, true) public
    {
    }
    
    function onAddition(uint ein, uint /* allowance */, bytes memory /* extraData */) public senderIsSnowflake() returns (bool) {
        Subscriber subscriber = subscribers[ein];
        require(!subscriber.ein);
        subscriber.ein = ein;
        return true;
    }

    function onRemoval(uint ein, bytes memory /* extraData */) public senderIsSnowflake() returns (bool) {
        delete subscribers[ein];
        return true;
    }

}
