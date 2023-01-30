// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Compaign {

    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
    }

    address public manager;
    uint public miniummContribution;
    address[] public approvers;
    Request[] public requests;

    constructor(uint _minimumContribution) {
        manager = msg.sender;
        miniummContribution = _minimumContribution;
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    function contribute() public payable {
        require(msg.value > miniummContribution, "Amount is less than the minimum contribution!");
        approvers.push(msg.sender);
    }

    function createRequest(
        string memory _description, 
        uint _value, 
        address _recipient
    ) public restricted {
        Request memory request = Request({
            description: _description,
            value: _value,
            recipient: _recipient,
            complete: false
        });
        requests.push(request);
    }
}