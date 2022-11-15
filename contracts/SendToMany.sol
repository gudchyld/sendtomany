// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SendToMany{

    address owner;
    mapping (address => bool) whitelistToWithdraw;
    mapping (address => uint) public senderBalance;

    event SendAll (address to, uint amt);
    error SendFailed (address addr, uint amount);

    constructor () payable {
        owner = msg.sender;
    }

    /**
    * @dev returns the balance of the smart contract
    */
    function getContractBal() public view returns (uint bal){
        bal = address(this).balance;
    }

    function checkSendersBalance () public view returns (uint bal){
        bal = msg.sender.balance;
    }

    function checkSendersBalanceOfContract () public view returns (uint bal){
        bal = senderBalance[msg.sender];
    }


    function sendAll (address[] calldata recievers, uint amt) external payable{
        senderBalance[msg.sender] += msg.value;
        uint arrLength = recievers.length;
        uint totalToSend = amt * arrLength;
        uint tempAmt = amt;
        uint bal = checkSendersBalanceOfContract();
        require(bal >= totalToSend, "Insufficient balance");
        //require(msg.value >= totalToSend, "Pass enough value to multisend");

        for (uint i = 0; i < arrLength; i++) {
            if(recievers[i] != address(0)) {
                address _to = payable(recievers[i]);
                senderBalance[msg.sender] -= tempAmt;
                (bool sent, ) = _to.call{value: amt}("");

                require(sent, "Failed to send Ether");
                emit SendAll(recievers[i], amt);

            }else{
                revert SendFailed(recievers[0], amt);
            }
        }
        whitelistToWithdraw[msg.sender] = true;

    }

    function withdraw() external {
        require(msg.sender == owner || whitelistToWithdraw[msg.sender], "only allowed persons can withdraw");
        require(msg.sender != address(0), "can't withdraw to zero address");

        if(msg.sender == owner){
        (bool sent,) = payable(owner).call{value: address(this).balance}("");
        require(sent, "withdrawal failed");
        }
        else{
        (bool sent,) = payable(msg.sender).call{value: senderBalance[msg.sender]}("");
        require(sent, "withdrawal failed");
        }
    }
    
}