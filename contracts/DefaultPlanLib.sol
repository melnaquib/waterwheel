pragma solidity ^0.5.0;

import "./SubscriptionLib.sol";

library DefaultPlanLib {

    int256[] tiers = [];//sorted asc, like 
    uint256 rates = [1000];
    bool isFlat = true;

    function getSubscriptionTier(uint256 qty) public view returns (uint256 i) {
        i = 0;
        uint256 res = rates[0];
        for(; i < tiers.length; ++i)
            if(qty) > tiers[i])
                break;
    }

    function collect(SubscriberLib.Subscriber subscriber, uint256 subscriptionIdx, uint256 planIdx, uint256 prevAmount) view returns (uint256 amount) {
        require(sinceDue >= 0, sinceDue);

        uint tier = getSubscriptionTier(subscription.qty());
        uint rate = rates[tier];

        amount = rate;
        if(!isFlat)
            amount *= subscription.qty();

    }

    function collect(SubscriptionLib.Subscription subscription) view returns (uint256 amount) {
        require(sinceDue >= 0, sinceDue);

        uint tier = getSubscriptionTier(subscription.qty());
        uint rate = rates[tier];

        amount = rate;
        if(!isFlat)
            amount *= subscription.qty();

    }

}
