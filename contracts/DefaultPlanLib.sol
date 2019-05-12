pragma solidity ^0.5.0;

import "./SubscriptionLib.sol";

library DefaultPlanLib {

    int256[] tiers = [];//sorted asc, like 
    uint256 rates = [1000];

    function getSubscriptionTier(uint256 qty) public view returns (uint256 i) {
        i = 0;
        uint256 res = rates[0];
        for(; i < tiers.length; ++i)
            if(qty) > tiers[i])
                break;
    }

    function collect(SubscriptionLib.Subscription subscription) view returns (uint256 amount) {
        require(sinceDue >= 0, sinceDue);

        uint tier = getSubscriptionTier(subscription.qty());
        uint rate = rates[tier];

        amount = rate;

        if(!subscription.isFlat) {
            amount *= subscription.qty();
        }

        // subscription.lastPaidDate = now;
        // subscription.lastPaidDueDate = now;
        // subscription.lastPaidAmount = amount;
        uint tier = getSub

    bool isDue() {

    }

    function getSubscriptionTier(uint256 qty) public view returns (uint256 i) 
        uint tier = getSub

    bool isDue() {

    }

    function getSubscriptionTier(uint256 qty) public view returns (uint256 i) 

    }

    enum Cycle { MONTHLY, QUATERLY, YEARLY};
    uint256[] constant public CycleTimes = [year / 12, year / 4, rear];
    
    struct DefaultPlan {
    Cycle _cycle;

    uint256 constant public _start;
    uint256 constant public _delay;
    uint256 constant public _cycleStart; //what monht /  quarter / year
    }
    
    int256 private _qty;
    uint256 constant public _rate;

    float discount_percentage = 1.0;
    uint256 discount_amount = 0;


    uint256 times = 1;


    function due(SubscriberResolver prevAmount, int idx, uint256 prevDate, uint256 prevAmount) constant returns (uint dueDate, uint256 dueAmount, PlanResolver[] nextPlans) {
        dueDate = prevDate;
        dueAmount = int(dueAmount * discount_percentage);
        dueAmount -= discount);
        uint256 dueAmount = prevDate;
        PlanResolver[] nextPlans = SubscriberResolver.planStack_list();
    }

}
