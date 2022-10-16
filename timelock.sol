// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract timeLock_SmartContract{
    //amount of ether you deposited will saved in the balances
    mapping (address => uint) public Balances;

    //When you can withdraw is saved in lockTime
    mapping (address => uint) public lockTime;

    address payable  spender = payable(msg.sender);

    function deposit() public payable {
        Balances[msg.sender] += msg.value;


        // is mn block.timestamp time btata hai seconds mn or + 3 minutes us mn time ko add kr dega
        // or us time takk lock ho jayega
        lockTime[msg.sender] = block.timestamp + 3 minutes;
    }

    function withdraw() public {
        // check kr rhay k balance kch hai bhi ya nahi
        require(Balances[msg.sender] >0,"Insufficient Balance in the contract");

        //check kr rahay k time poora huwa ya nahi
        require(block.timestamp > lockTime[msg.sender] ," Lock Time has not yest expired");

        spender.transfer(Balances[msg.sender]);
    }


}