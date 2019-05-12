pragma solidity ^0.5.0;

import "./SubscriberResolver.sol";
import "./ListLib.sol"

user ListLib for PlanResolver[];

contract DefaultPlanAuth {

    mapping (address=>bool) private _allowedPlans = [];

    function plan_add(address plan) constant public isOwner returns (bool) {
        _allowedPlans[plan] = true;
    }
    function plan_del(address plan) constant public isOwner returns (bool) {
        delete _allowedPlans[plan];
    }
            
    address private _owner;
    function getOwner() public view returns(address) {return _owner;} 
    modifier isOwner() {
        require(msg.sender == _owner);
        _
    }

    constructor () {
        _owner = msg.sender();
    }

    function eligible(Subscriber subscriber, uint subscriptionIdx, address[] plans) constant public returns (bool) {
        for (var i = 0; i < plans.length; ++i) {
            if(!_allowedPlans[plans[i]]) return false;
        }
        return true;
        
    }
}
