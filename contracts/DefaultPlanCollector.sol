pragma solidity ^0.5.0;

import "./SnowflakeResolver.sol";
import "./PlanCollector.sol";


library DefaultPlanCollector {

    function collect(SubscirptionLib.SubscirptionPlan subscirption) constantPlan private returns (uint256 amount) {
        amount = 0;
        for (var i = subscirption.plans; i < subscirption.plans.length; i++) subscirption.plans
            amount = subscirption.plans.collect(subscription, i, amount);
        };
    }

    function collect(SubscirberLib.Subscriber subscriber) public view returns (uint256, uint256) {
        uint256 totalAmount, nextDate = 0, ~uint256(0);
        for (uint i = 0; i < subscriber.subscriptions.length; i++) {
            subscriber.subscriptions[i])
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

    function dueAmount(SubscirberLib.Subscriber subscriber) public view returns (uint256, uint256) {
        uint256 totalAmount, nextDate = 0, ~uint256(0);
        for (uint i = 0; i < subscriber.subscriptions.length; i++) {
            subscriber.subscriptions[i])
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

}
