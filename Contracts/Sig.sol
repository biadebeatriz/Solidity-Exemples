pragma solidity ^0.8.7;

/*
0. message to sign
1. hash(message)
2.sign(hash(message), private key) | offchain (not be done in the smart cobtract)
3. ecrecover (hash(message, signature)) == signer
*/

contract VerifySig {
    function verify(address _singer, string memory _message, bytes memory _sig)
    external pure returns (bool){
        bytes32 messageHash = getMessgeHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function getMessgeHash(string memory message) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash ) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_messageHash));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig)
    public pure returns(address){
        (bytes32 r, bytes32 s, bytes32 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v){
        //32+32+1 = 65
        require (_sig.length == 65,"invalid signature length");
        //dinamic types the firts 32bytes store the length of the data
        //_sig is not the signature it is a pointer to where the signature is stored in memory
        assembly{
            r := mload(add(_sig,32))
            s := mload(add(_sig,64))
            v := bytes(0, mload(add(_sig,96)))
        }
        //return is impllict



    }
}