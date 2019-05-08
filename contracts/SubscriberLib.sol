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
    
    function subscribe(planAuth, Subscriber subscriber, address[] plans) public returns (bool) {
        return subscribers[ein].subscribe(planAuth, plans);
    }

    function unsubscribe(int subscriptionIdx, uint depth) public returns (bool) {
        return Subscriber.subscriptions[subscriptionIdx].unsubscribe(depth);
    }

    event Payment(uint256 amount, uint256 nextDate);
    
    function collect(Subscriber subscriber) {
        SubscriptionLib.Subscription[] subscriptions = subscriber.subscriptions;
        uint256 total, closest = 0, ~uint256(0);
        for (uint i = 0; i < subscriptions.length; i++) {
            uint256 amount, uint256 nextDate = subscriptions[i].due();
            //TODO
            //pay
            Paid(ein, i, amount, nextDate)

            total += amount;
            if(closest > nextDate) closest = nextDate;
        }
        PaidAll(ein, total, closest)
    }
}
