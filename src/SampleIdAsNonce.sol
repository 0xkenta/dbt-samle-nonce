// reference
// https://ethereum.stackexchange.com/questions/150082/does-casting-a-keccak256-hash-to-a-uint256-increase-likelihood-of-a-collision

pragma solidity ^0.8.13;

contract SampleIdAsNonce {
    uint256 public nonce;

    event NonceUpdated(uint256 nonce);

    function setNonce(uint256 _nonce) external {
        nonce = _nonce;

        emit NonceUpdated(_nonce);
    }

    function getId(address _contract, address _user, uint256 _timestamp) external pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(_contract, _user, _timestamp)));
    }

    function validateNonce(address _contract, address _user, uint256 _timestamp) external view returns (bool) {
        return nonce == uint256(keccak256(abi.encodePacked(_contract, _user, _timestamp)));
    }
}
