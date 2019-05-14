pragma solidity ^0.5.0;

import "./SubscriberLib.sol";

import "./zeppelin/ownership/Ownable.sol";

contract DiscountPlan {

    bool _transferable;
    uint256 _times;
    uint256 _expire;

    // current users ein => usage; 0 means not used before, 1 means fully consumer, 11 means you have 10 available;
    // that is till you get to 1 which means fully consumed
    mapping (uint256=>uint256) usage;

    uint256 _discountAmount;
    uint256 _discountRatio;


    constructor (bool transferable, uint256 times, uint256 expire, uint256 discountAmount, uint256 discountRatio) public {
        _transferable = transferable;
        _times = times;
        _expire = expire;
        _discountAmount = discountAmount;
        _discountRatio = discountRatio;
    }

    function collect(SubscriberLib.Subscriber subscriber, uint256 subscriptionIdx, uint256 planIdx, uint256 prevAmount) view returns (uint256 amount) {
        amount = prevAmount;
        if(now > _expire) return;

        uint256 currentUsed = usage[subscriber.ein];
        if(0 == currentUsed)
            currentUsed = usage[subscriber.ein] = _times;

        if(currentUsed < 2) return;
        
        amount = prevAmount - _discountAmount;
        amount -= (amount * _discountRatio) / 1000;

        --usage[subscriber.ein];
    }
}
