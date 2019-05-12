pragma solidity ^0.5.0;

import "./SnowflakeResolver.sol";
import "./SubscriptionLib.sol";

using SubscriptionLib for Subscription;

contract DefaultPlanAuth {    
    function eligible(Subscriber subscriber, Subscription subscription, address Plan) constant public returns (bool) {
        return _allowedPlans[plan];
    }
}

contract Plan {
    function due(SubscriberResolver resolver) constant returns (uint256 amount, uint256 next);
}

contract PlanAuth {
    function eligible(Subscriber subscriber, Subscription subscription) constant public returns (bool);
}

library SubscriberLib {

    struct Subscriber {
        uint256 ein;
        SubscriptionLib.Subscription[] subscriptions;
        uint256 _cycleLimit;
    }
    
    function subscribe(Subscriber subscriber, planAuth, address[] plans) public returns (bool) {
        return subscribers[ein].subscribe(planAuth, plans);
    }

    function unsubscribe(Subscriber subscriber, int subscriptionIdx, uint depth) public returns (bool) {
        return subscriber.subscriptions[subscriptionIdx].unsubscribe(depth);
    }
    function getSubscriptions() returns(Subscriber subscriber, Subscription[]) {
        return subscriber.subscriptions;
    }
    function getSubscription(Subscriber subscriber, uint256 subscriptionIdx) returns(Subscription) {
        return subscriber.subscriptions[subscriptionIdx];
    }

}
