pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }


    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    function sendATransactionWithoutCommission(address dest, uint128 value) public pure checkOwnerAndAccept {
        bool bounce = false;
        uint16 flag = 0;
        dest.transfer(value, bounce, flag);
    }

    function sendTransactioWithCommission(address dest, uint128 value) public pure checkOwnerAndAccept {
        bool bounce = false;
        uint16 flag = 1;
        dest.transfer(value, bounce, flag);
    }

    function sendAllMoneyAndDestroyTheWallet(address dest) public pure checkOwnerAndAccept {
        uint128 value = address(this).balance;
        bool bounce = false;
        uint16 flag = 160;
        dest.transfer(value, bounce, flag);
    }
}