
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// This is class that describes you smart contract.
contract taskList {
    // Contract can have an instance variables.
    // In this example instance variable `timestamp` is used to store the time of `constructor` or `touch`
    // function call
    uint32 public timestamp;

    struct task {
    string name;
    uint32 timestamp;
    bool done;
    }
    
    mapping (int8=>task) allTasks;

    uint8 counter;
    // Contract can have a `constructor` – function that will be called when contract will be deployed to the blockchain.
    // In this example constructor adds current time to the instance variable.
    // All contracts need call tvm.accept(); for succeeded deploy
    constructor() public {
        // Check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and
        // message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        // The current smart contract agrees to buy some gas to finish the
        // current transaction. This actions required to process external
        // messages, which bring no value (henceno gas) with themselves.
        tvm.accept();

        timestamp = now;
    }
    function addTask(int8 key, task newTask) public returns (mapping (int8=>task)) {
        allTasks[key] = newTask;
        counter++;
        return allTasks;
    }

    function numberOfTasks() public returns (uint8) {       
        return counter;
    }

    function getAlTask() public returns (mapping (int8 => task)) {
        require(counter !=0, 100, "No task found.");
        return allTasks;
    }

    function taskInfo (int8 key) public returns (task) { 
        return allTasks[key];
    }

    function deleteTask (int8 key) public returns (mapping (int8 => task)) { 
        delete allTasks[key];
        counter--;
        return allTasks;
    }
    
    function doneTask (int8 key) public returns (mapping (int8 => task)) {
        allTasks[key].done = true;
        return allTasks;
    }
}