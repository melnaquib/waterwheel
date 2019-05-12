pragma solidity ^0.5.0;
import './SubscirberLib.sol';

contract PlanCollector {
    function collect(SubscirberLib.Subscriber subscriber) constant public returns (uint256, uint256);
}
