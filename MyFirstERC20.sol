// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract ERC20 {
    uint256 public totalSupply;
    string public name;
    string public symbol;
    //uint8 public decimals;

    mapping(address => uint) public balanceOf;// solidity automaticlly implements a public function of this name
    mapping(address => mapping(address => uint)) public allowance;//same

    constructor(string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;

        _mint(msg.sender, 100e18);
    }

    function decimals() external pure returns(uint8){
        return 18; 
    }
    function transfer(address recipient, uint amount) external returns (bool) {
        return _transfer(msg.sender, recipient, amount);
    }
    function transferFrom(address sender, address recipient, uint amount) external returns (bool) {
        uint currentAllowance = allowance[sender][msg.sender];

        require(
            currentAllowance >= amount,
            "ERC20: transfer amount exceeds allowance"
        );

        allowance[sender][msg.sender] = currentAllowance - amount;

        return _transfer(sender, recipient, amount);
    }

    function approve(address spender, uint amount) external returns(bool) {
        require(spender != address(0), "ERC20: transfer to the zero address");

        allowance[msg.sender][spender] = amount;
        return true;
    }

    function _transfer(address sender, address recipient, uint amount) private returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        uint senderBalance = balanceOf[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

        balanceOf[sender] = senderBalance - amount;
        balanceOf[recipient] += amount;

        return true;
    }

    function _mint(address to, uint amount) internal {
        require(to != address(0), "ERC20: mint to the zero address");

        totalSupply += amount;
        balanceOf[to] += amount;
    }
}   
