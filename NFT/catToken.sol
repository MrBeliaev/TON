
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract catToken {
    struct Token {
        string name;
        uint age;
        string color;    
    }

    Token[] tokensArr;

    mapping (uint=>uint) tokenToOwner;

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    function createToken(string name, uint age, string color) public {
        Token(name, age, color);
        for (uint256 index = 0; index < tokensArr.length; index++) {
            require(name != tokensArr[index].name, 100);
        }
        uint keyAsLastNum = tokensArr.length - 1;
        tokenToOwner[keyAsLastNum] = msg.pubkey();
    }

    function sellToken(uint tokenID, uint price, uint pubkeyOfNewOwner, uint moneyOfNewOwner) public checkOwnerAndAccept {
        require(price == moneyOfNewOwner, 100);
        tokenToOwner[tokenID] = pubkeyOfNewOwner;
    }
}
