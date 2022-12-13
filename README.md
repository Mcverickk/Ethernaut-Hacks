# Ethernaut Lvl 27 Good Samaritan Walkthrough: Custom Errors in Solidity

This repo contains the solidity smart contract used to hack Ethernaut Lvl 27 - Good Samaritan. Find the step by step walkthrough below.

## The Hack

1. Let's create a function inside GoodSamaritanAttack.sol called `attack()`. This function `callsrequestDonation()` in the GoodSamaritan contract.

2. Notice `thatrequestDonation()` is trying to transfer only 10 tokens inside the try block, and only if it gives an error it executes the code inside `catch`. The code inside `catch` transfers all the balance available in the wallet if the encoded error is `abi.encodeWithSignature("NotEnoughBalance()")`. Now, as we know about custom errors, our motive is to revert an error defined as `error NotEnoughBalance();`.

3. When the `requestDonation()` is called by `attack()`, it will transfer 10 tokens, and the Coin contract will execute function `notify(uint256 amount)` defined in `interface INotifyable`. This will only be executed if `msg.sender` is a contract address. So, let's create a function inside GoodSamaritanAttack.sol whose function signature looks exactly like function `notify(uint256 amount) external;`.

4. Remember, our goal was to `revert NotEnoughBalance();`. So, let's define an `error NotEnoughBalance();` and call `revert NotEnoughBalance();` inside function `notify(uint amount)` in GoodSamaritanAttack.sol.

5. Now, the `try` block will revert with an error and trigger the code inside `catch`. Will this transfer the entire wallet balance and drain the contract? Nope! When the `catch` code will execute, the Coin contract will again call function `notify(uint256 amount)` and hence will `revert` again. So, we can simply write an `if` condition to check if the transfer amount is 10 and only `revert NotEnoughBalance()` in that case.

6. Deploy GoodSamaritanAttack.sol and call the function `attack()`.


WOAH!! The contract has now been successfully hacked!!!

Find the complete walkthrough at https://blog.blockmagnates.com/ethernaut-lvl-27-good-samaritan-walkthrough-custom-errors-in-solidity-17c7e20fb58a
