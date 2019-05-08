pragma solidity ^0.5.0;

import "./SnowflakeResolver.sol";

contract Plan {
    function due(Subscription subscription) constant returns (uint256 date, uint256 amount);
}

contract PlanAddon {
    function due(Subscription subscription) constant returns (uint256 date, uint256 amount);
}

library SubscriptionLib {

    enum Cycle{ MONTHLY, QUATERLY, YEARLY};
    uint256[] constant public CycleTimes = [year / 12, year / 4, year];

    struct Subscription {
        Plan[] plans;

        uint tax; // tax per thousand parts; amount * tax / 1000

        bool _active;

        Cycle _cycle;
        uint256 constant public _start;
        uint256 constant public _delay;
        uint256 constant public _cycleStart; //what month /  quarter / year
    
        int256 private _qty;
        uint256 constant public _rate;
        uint256 constant bool _flatRate;
        

        uint256 lastDate = 0;
        uint256 lastAmount = 0;
    };

    PlanResolver[] plansAvailable = [];
    PlanResolver[][] planStack = [][];
    function plan_push(uint idx, PlanResolver plan) public senderIsSnowflake() {
        PlanAuthority planAuthority = getPlanAuthory();
        require(!planAuthority || planAuthority.eligible_push(this, plan));
        planStack.push(plan);
    }
    function plan_pop(uint idx, uint depth) public senderIsSnowflake() {
        PlanAuthority planAuthority = getPlanAuthory();
        require(!planAuthority || planAuthority.eligible_push(this, depth));
        for (uint i = 0; i < depth; i++) {
            this.planStack.pop();
        }
    }
    function plan_pop(uint idx) public {
        plan_pop(idx, 1);
    }

    function plan_reset(uint idx, PlanResolver[] planResolvers) public senderIsSnowflake() {
        uint256 ts = now;
        PlanAuthority planAuthority = getPlanAuthory();
        require(!planAuthority || planAuthority.eligible_reset(this, planResolvers));
        return this.planStack[idx] = planResolvers;
    }

    event Payment(uint256 amount, uint256 nextDate);
    event PlanChange();
    

    function due() {
        uint256 totalAmount, nextDate = 0, ~uint256(0);
        for (uint i = 0; i < l.length; i++) {
            uint256 amount, uint256 date = 0, 0;
            for (uint i = 0; i < l.length; i++) {
                PlanResolver planResolver = PlanStack[i];
                amount, date = planResolver.due(this, i, amount, date);
            }
            totalAmount += amount;
            if(date < nextDate) {
                date = nextDate;
            }
        }
        //pay and set last time stamp
    }

    // optionally, override the setSnowflakeAddress function of SnowflakeResolver to...
    // function setSnowflakeAddress(address snowflakeAddress) public onlyOwner() {
    //     super.setSnowflakeAddress(snowflakeAddress);
    //     // ...initialize varaiables based on addresses derived from snowflake
    // }

    function onAddition(uint /* ein */, uint /* allowance */, bytes memory /* extraData */) public senderIsSnowflake() returns (bool) {
        // implement function here, or set the _callOnAddition flag to false in the SnowflakeResolver constructor
        return true;
    }

    function onRemoval(uint /* ein */, bytes memory /* extraData */) public senderIsSnowflake() returns (bool) {
        // implement function here, or set the _callOnRemoval flag to false in the SnowflakeResolver constructor
        return true;
    }

}
