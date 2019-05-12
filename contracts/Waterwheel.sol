pragma solidity ^0.5.0;

import "./SnowflakeResolver.sol";
import "./SubscriberLib.sol";
import './DefaultPlanCollector.sol';

using SubscriberLib for SubscriberLib.subscriber;

contract PlanAuth {
    function eligible(Subscriber subscriber, uint subscriptionIdx, address[] plans) constant public returns (bool);
}

contract Waterwheel is SnowflakeResolver {

    PlanCollector private _planCollector = DefaultPlanCollector();
    function getPlanCollector() public view returns(PlanCollector) { return _planCollector;}
    function setPlanCollector(PlanCollector planCollector) protected { _planCollector  = planCollector;}

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
    function getSubscription(int subscriptionIdx, uint depth) public view returns (SubscriptionLib.Subscription) {
        return subscribers[ein].getSubscription(subscriptionIdx);
    }

    function dueAmount(uint256 ein, uint256 subscriptionIdx) returns(uint256) {
        return planCollector.dueAmount(subscribers[i]);
    }

    function collect(uint256 ein, uint256 subscriptionIdx) returns(bool) {
        uint256 amount = planCollector.collect(subscribers[i]);
        Collected(ein, subscriptionIdx, amount);

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
